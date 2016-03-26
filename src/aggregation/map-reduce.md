# MapReduce

MapReduce是一中用于进行大数据聚合操作的模式，而不是一个特定的函数或软件。

![](map-reduce.png)


## MongoDB中的MapReduce实现

- MongoDB提供了mapReduce函数来实现MapReduce；
- MapReduce需要用到的所有阶段函数都使用JavaScript来编写。
- mapReduce函数只能使用一个集合作为输入；
- mapReduce函数的计算结果可以是一个文档或一组文档；


## 示例

### 数据模型

```
{
     _id: ObjectId("50a8240b927d5d8b5891743c"),
     cust_id: "abc123",
     ord_date: new Date("Oct 04, 2012"),
     status: 'A',
     price: 25,
     items: [ { sku: "mmm", qty: 5, price: 2.5 },
              { sku: "nnn", qty: 5, price: 2.5 } ]
}
```

### 返回每个顾客所购商品的总价

#### 构造 map函数

```
var mapFunction1 = function() {
                       emit(this.cust_id, this.price);
                   };
```

- map 函数被应用于集合中的每一个文档，`this`就是指向输入的文档；
- map函数对单个文档进行处理，生成一个或一组键值对，并使用emit函数将这个键值对发送给reduce函数。

#### 构造 reduce函数

```
var reduceFunction1 = function(keyCustId, valuesPrices) {
                          return Array.sum(valuesPrices);
                      };
```

- reduce函数用于对map发射出来的结果进行合并；
- map发射出来的键值对被按键分组，并将键和值的数组作为输入；
- 并不是每个键只会被输入一次，当每个键对应的值很多时，它将会被拆分成很多个reduce操作；
- reduce函数应该被设计为可递归调用，它的返回值应该可以作为下一次reduce的输入（value）。

#### 使用mapReduce函数

```
db.orders.mapReduce(
                     mapFunction1,
                     reduceFunction1,
                     { out: "map_reduce_example" }
                   )
```

- 输出结果被定向到 `map_reduce_example`集合中。