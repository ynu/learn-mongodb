# 创建用户管理员

用户管理员是MongoDB中一种内置的角色，它可以创建用户、角色以及为用户指定角色。

## 创建系统的用户管理员

```
use admin
db.createUser(
  {
    user: "siteUserAdmin",
    pwd: "password",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
```

- `admin`数据库是默认的用于管理的数据库；
- 完成以上操作后，可用siteUserAdmin账号登陆数据库系统管理系统用户和角色，但不可以存取具体数据。