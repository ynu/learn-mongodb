# 数据模型设计


## 内嵌数据模型

![Data model with embedded fields that contain all related information.](data-model-denormalized.png)

- 一般地，这几种情况下应该使用内嵌数据模型：
	- 实体之间存在“包含”关系（One-to-One）；
	- 实体之间存在“One-to-Many”关系；
- 内嵌数据模型为读操作提供更好的性能；
- 内嵌关系可能导致文档在更新之后出现存储空间增长。当数据库试用MMAPv1存储引擎时，这将影响写操作的性能，并可能会出现数据碎片化；

## 常规数据模型

![Data model using references to link documents. Both the ``contact`` document and the ``access`` document contain a reference to the ``user`` document.](data-model-normalized.png)

- 一般地，以下几种情形应当使用常规数据模型
	- 内嵌数据模型不能提供很好的性能的时候；
	- 实体之间存在“Many-to-Many”关系时；