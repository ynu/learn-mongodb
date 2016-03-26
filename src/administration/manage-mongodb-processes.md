# mongod 进程管理

## 启动mongod进程

### 基本方法

`mongod`

### 指定数据目录

默认情况下，MongoDB数据库文件存被放在`/data/db`目录下。也可以在启动的时候指定位置：
`mongod --dbpath /srv/mongodb/`

### 指定连接端口

MongoDB数据库连接端口默认为27017，启动时可以使用`--port`选项指定其他端口：
`mongod --port 12345`

### 启用用户认证

当我们需要对数据库操作进行身份认证时，在启动时可以使用`--auth`选项指定：
`mongod --auth`

### 在后台运行mongod

`nohup mongod &`

## 结束mongod进程

### 在Shell中结束进程

```
use admin
db.shutdownServer()
```

### 使用`--shutdown`选项结束进程

`mongod --shutdown`

### 使用 Ctrl + C 结束进程

当我们使用交互模式启动mongod时，可以按Ctrl+C键结束当前进程。

### 使用kill命令结束进程

在Linux系统中，我们可以使用kill命令结束mongod进程：
`kill <mongod process ID>`

注意：千万不要使用`kill -9`结束mongod进程。