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
            "sub_api_url": "占位"
          }
        },
        {
          "term": {
            "appid": "占位"
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
          "cardinality": {    //cardinality为去重计算,先去重再求和
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
            "appid": "占位"
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
                        "appid": "占位"
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

---

## 包含“用户登录信息”的关键字的各个 userid 分布

</br>

```json
{
    "size": 1, //明细数据显示一条
    "query": {
        "bool": {
            "must": [
                {
                    "term": {
                        "appid": "占位"
                    }
                },
                {
                    "wildcard": {
                        //模糊匹配
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
                "size": 999 //聚合数据（userid）显示条数，默认是20，超过20则会不显示
            }
        }
    }
}
```

---

## 查询总 PV，UV

</br>

```json
GET flink_ops_ppo_20210301/_search
{
     "size": 0,
        "query": {
            "bool": {
                "must": [
                {
                        "term": {
                           "appid": ""
                    }
                },
                {
                        "range": {
                            "ts": {
                                "gte": "2021-03-01T00:00:00.000+08:00",
                                "lte": "2021-03-01T23:59:59.000+08:00"
                        }
                    }
                }
            ]
        }
    },
        "aggs": {
            "pv": {
                "sum": {
                    "field": "open_cnt"  
            }
        },
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
## 查询每分钟的UV,PV，接口访问最小，平均，最大耗时
</br>

```json
{
    "size": 1,
    "query": {
        "bool": {
            "must": [
                {
                    "term": {
                        "appid": ""
                    }
                },
                {
                    "wildcard": {
                        "api_url": ""
                    }
                },
                {
                    "range": {
                        "ts": {
                            "gte": "2020-12-04T02:18:00+08:00",
                            "lte": "2020-12-04T02:18:59+08:00"
                        }
                    }
                }
            ]
        }
    },
    "aggs": {
        "data": {
            "date_histogram": {
                "field": "ts",
                "interval": "1m",
                "format": "yyyy-MM-dd HH:mm:ss",
                "time_zone": "+08:00"
            },
            "aggs": {
                "mintime": {
                    "percentiles": {
                        "field": "min_time",
                        "percents": [
                            50       //精度为50，则是取中位数
                        ]
                    }
                },
                "midtime": {
                    "percentiles": {
                        "field": "avg_time",
                        "percents": [
                            50
                        ]
                    }
                },
                "maxtime": {
                    "percentiles": {
                        "field": "max_time",
                        "percents": [
                            50   
                        ]
                    }
                },
                "uv": {
                    "cardinality": {
                        "field": "guid",
                        "precision_threshold": 12000
                    }
                }
            }
        }
    }
}
```
