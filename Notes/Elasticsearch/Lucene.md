# 常用语法查询

## 小程序某个接口，各个 app_version 的 uv 分布

```json5
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
    "group_by_blversion": {
      //分组
      "terms": {
        "field": "app_version"
      },
      "aggs": {
        "uv": {
          "cardinality": {
            //cardinality为去重计算,先去重再求和
            "field": "guid",
            "precision_threshold": 12000
            //精度
          }
        }
      }
    }
  }
}
```

---

## 小程序基础库某个版本的 UV 分布

```json5
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

```json5
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

```json5
{
  "size": 1,
  //明细数据显示一条
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
        "size": 999
        //聚合数据（userid）显示条数，默认是20，超过20则会不显示
      }
    }
  }
}
```

---

## 查询总 PV，UV

```json5
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

## 查询每分钟的 UV,PV，接口访问最小，平均，最大耗时

```json5
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
              50
              //精度为50，则是取中位数
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

---

## 查询最近的机型的 PV、UV 分布(常用指标)

```json5
{
  "size": 0,
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "appid": {
              "value": ""
            }
          }
        },
        {
          "range": {
            "ts": {
              "gte": "2021-03-04T00:00:00.000+08:00"
            }
          }
        }
      ]
    }
  },
  "aggs": {
    "full_typelist": {
      "terms": {
        "script": "doc['phone_type'].values +' / '+doc['full_type'].values",
        //机型和型号拼接起来
        "size": 120,
        "order": {
          "_count": "desc"
          //根据count降序排列
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
  }
}
```

---

## 首页平均加载时长

```json5
{
  "size": 0,
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "appid": {
              "value": "wx6025c5470c3cb50c"
            }
          }
        },
        {
          "term": {
            "sub_url": {
              "value": "pages/home/index/index"
            }
          }
        }
      ]
    }
  },
  "aggs": {
    "avg_time": {
      "percentiles": {
        "field": "fpr",
        "percents": [
          50
        ]
        //取中位数
      }
    }
  }
}
```

## 获取手机操作系统分布

```json5
{
  "size": 0,
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "appid": {
              "value": ""
            }
          }
        },
        {
          "range": {
            "ts": {
              "gte": "2021-05-11T00:00:00.000",
              "lte": "2021-05-11T23:59:59.000",
              "time_zone": "+08:00"
            }
          }
        }
      ]
    }
  },
  "aggs": {
    "version": {
      "terms": {
        "script": {
          "source": "def os = doc['os'].value;def isIos = os.indexOf('iOS') !== -1; def isAndorid = os.indexOf('Android') !== -1; if(isIos || isAndorid) {def ios = 'ios'; def andorid = 'Andorid'; def osSystem = isIos ? ios : andorid; return osSystem}"
          // 使用脚本语言进行数据过滤
          // 学习教程 "https://blog.csdn.net/qq_28834355/article/details/109050305" 
          // "https://blog.csdn.net/u013613428/article/details/78134170/"
        }
      }
    }
  }
}
```

## 聚合数据(空数据补0)

```json5
{
  "size": 0,
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "appid": {
              "value": ""
            }
          }
        },
        {
          "term": {
            "err_type": {
              "value": "error"
            }
          }
        },
        {
          "range": {
            "ts": {
              "gte": "2021-05-01",
              "lte": "2021-05-11",
              "time_zone": "+08:00"
            }
          }
        }
      ]
    }
  },
  "sort": [
    {
      "ts": {
        "order": "desc"
      }
    }
  ],
  "aggs": {
    "data": {
      "date_histogram": {
        "field": "ts",
        "interval": "1d",
        "format": "yyyy-MM-dd",
        "time_zone": "+08:00",
        "min_doc_count": 0, // 空数值补0
        "extended_bounds": {
          "min": "2021-03-09", // 最小值
          "max": "2021-04-07"  // 最大值
        }
      },
      "aggs": {
        "count": {
          "sum": {
            "field": "count"
          }
        }
      }
    }
  }
}
```
## Es对深层次数据结构的聚合
```json5
{
  "size": 1, 
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "appid": {
              "value": ""
            }
          }
        },
        {
          "range": {
            "event_time": {
              "gte": "2021-06-09T00:00:00.000",
              "lte": "2021-06-09T23:59:59.000",
              "time_zone": "+08:00"
            }
          }
        }
      ]
    }
  },
  "aggs": {
    "parameter": {
      "nested": {
        "path": "parameter"  // 定位到parameter对象里
      },
      "aggs": {
        "parameterKey": {
          "terms": {
            "field": "parameter.type" // 指定parameter里面的对象
          },
          "aggs": {
            "rev": {
              "reverse_nested": {}, // 跳出parameter的结构，回到和parameter的同级结构
              "aggs": {
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
      }
    }
  }
}

```
小知识点：
1.keyword字段如果要进行模糊查询，只能借助wildcard
```json5
{
  "size": 20,
  "query": {
    "bool": {
      "must": [
        {
          "wildcard": {
            "name": {
              "value": "*昊途*"
            }
          }
        }
      ]
    }
  },
  "sort": [
    {
      "updatetime": {
        "order": "desc"
      }
    }
  ]
}

```
2.text字段进行模糊查询，使用match进行查询
```json5
{
  "size": 20, 
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "creater": "贺"
          }
        }
      ]
    }
  }
}
```
## ES对聚合后的数据进行排序
```json5
{
  "size": 0, 
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "appid": {
              "value": ""
            }
          }
        },
        {
          "range": {
            "ts": {
              "gte": "2021-06-01",
              "lte": "2021-06-02"
            }
          }
        }
      ]
    }
  },
  "aggs": {
    "ts":{
      "terms": {
        "field": "ts",
        "size": 30,
        "order": {
          "_term": "desc"
        }
      },
      "aggs": {
        "aa": {
          "terms": {
            "field": "app_version"
          },
          "aggs": {
            "uv": {
              "sum": {
                "field": "uv"
              }
            },
            "sort":{  // 对聚合的uv进行排序  参考链接：https://www.cnblogs.com/chenmz1995/p/11265470.html
              "bucket_sort": {
                "sort": {
                  "uv":{
                    "order":"desc"
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

```