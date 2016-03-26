# 连接到数据库

In this section, you connect to the database server, which runs as mongod, and begin using the mongo shell to select a logical database within the database instance and access the help text in the mongo shell.

## Connect to a mongod

在命令行下，我们可以通过以下命令连接到MongoDB：
`mongo`

默认情况下，mongo命令通过27017端口连接到本地MongoDB服务器，如果需要使用其他的端口和主机，可以使用 --port 和 --host 选项。

## Select a Database

当连接到数据库后，默认选中的是test数据库。你可以使用以下命令查看当前选中的数据库：

`db`

在mongo shell环境下，可以使用下面的命令列出当前服务器可用的数据库列表：

`show dbs`

要切换数据库，可以使用下面的命令：

`use mydb`

即使mydb数据库不存在，我们也可以使用上面的命令，这种情况下，系统将自动创建一个mydb数据。

切换之后，可以使用下面的命令确认一下：

`db`


### Display mongo Help

当我们需要获取命令帮助的时候，可以使用 `help` 命令。