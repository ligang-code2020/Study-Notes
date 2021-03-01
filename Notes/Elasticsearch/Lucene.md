# 常用语法查询

## 小程序某个接口，各个 app_version 的 uv 分布

</br>

```json
GET rho_log_nrt_20210225/_search
{
  "size": 1,
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "sub_api_url": "https://mall.xsyxsc.com/user/product/queryShopCar/v3"
          }
        },
        {
          "term": {
            "appid": "wx6025c5470c3cb50c"
          }
        }
      ]
    }
  },
  "aggs": {
    "group_by_blversion": {  //分组
      "terms": {
        "field": "app_version"
      },
      "aggs": {
        "uv": {
          "cardinality": {    //cardinality为去重计算
            "field": "guid",
            "precision_threshold": 12000   //精度
          }
        }
      }
    }
  }
}
```

---

## 小程序基础库某个版本的 UV 分布

</br>

```json
GET rho_log_nrt_20210226/_search
{
  "size": 1,
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "appid": "wx6025c5470c3cb50c"
          }
        },
        {
          "range": {
            "bl_version": {
              "gte": "2.11.0"
            }
          }
        },
        {
          "range": {
            "ts": {
              "gte": "2021-02-26T00:00:00.000",
              "lte": "2021-02-26T08:00:00.000",
              "time_zone": "+08:00"
            }
          }
        }
      ]
    }
  },
  "aggs": {
    "uv": {
      "cardinality": {
        "field": "guid",
        "precision_threshold": 12000
      }
    }
  }
}
```

---

## 某个设备，最近七天 app_version 在 1.2.1 以下的各个 userid 的分布

</br>

```json
GET rho_log_nrt_20210226/_search
{
    "size": 0,
    "query": {
        "bool": {
            "must": [
                {
                    "term": {
                        "appid": "flutter-mobile-f7-0403"
                    }
                },
                {
                    "range": {
                        "app_version": {
                            "lt": "1.2.1"
                        }
                    }
                }
            ]
        }
    },
    "aggs": {
        "userlist": {
            "terms": {
                "field": "userid",
                "size": 999
            }
        }
    }
}
```

## 包含“用户登录信息”的关键字的各个 userid 分布

</br>

```json
{
    "size": 1,  //明细数据显示一条
    "query": {
        "bool": {
            "must": [
                {
                    "term": {
                        "appid": "flutter-mobile-f7-0403"
                    }
                },
                {
                    "wildcard": {   //模糊匹配
                        "err_name": "*用户登录信息*"
                    }
                }
            ]
        }
    },
    "aggs": {
        "userlist": {
            "terms": {
                "field": "userid",
                "size": 999     //聚合数据（userid）显示条数，默认是20，超过20则会不显示
            }
        }
    }
}
```
