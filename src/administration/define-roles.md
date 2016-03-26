# 创建数据库角色
MongoDB提供了灵活的用户权限控制，除了使用系统内置的角色外，我们还可以创建自定义角色。

## 使用用户管理员登录数据库
`mongo --port 27017 -u siteUserAdmin -p password --authenticationDatabase admin`

## 创建一个新的角色

```
use admin
db.createRole(
   {
     role: "manageOpRole",
     privileges: [
       { resource: { cluster: true }, actions: [ "killop", "inprog" ] },
       { resource: { db: "", collection: "" }, actions: [ "killCursors" ] }
     ],
     roles: []
   }
)
```