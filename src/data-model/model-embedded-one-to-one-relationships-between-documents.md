# 使用内嵌数据模型对“One-to-One”关系建模

## Pattern

考虑以下使用常规建模方式表示的顾客与地址关系：

```
{
   _id: "joe",
   name: "Joe Bookreader"
}

{
   patron_id: "joe",
   street: "123 Fake Street",
   city: "Faketon",
   state: "MA",
   zip: "12345"
}
```

如果使用内嵌数据模型进行建模：

```
{
   _id: "joe",
   name: "Joe Bookreader",
   address: {
              street: "123 Fake Street",
              city: "Faketon",
              state: "MA",
              zip: "12345"
            }
}
```

使用这种方式，应用程序只需要进行一次查询即可同时读取顾客信息和地址。