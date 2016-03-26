# 添加数据库用户

为了保证数据库的安全，实现数据库用户认证，我们首先需要创建数据库的用户，以便让用户通过用户凭据登录数据库系统。

## 使用用户管理员账户登录系统
`mongo --port 27017 -u siteUserAdmin -p password --authenticationDatabase admin`



## 为特定的数据库添加用户

```
use reporting
db.createUser(
    {
      user: "reportsUser",
      pwd: "12345678",
      roles: [
         { role: "read", db: "reporting" },
         { role: "read", db: "products" },
         { role: "read", db: "sales" },
         { role: "readWrite", db: "accounts" }
      ]
    }
)
```

注意： 2.6以前的版本不适用。

## 系统的内置角色

	- read
	- readWrite
	- dbAdmin 
	- dbOwner
	- userAdmin