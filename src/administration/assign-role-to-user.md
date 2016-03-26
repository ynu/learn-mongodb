# 为用户指定角色

## 使用用户管理员登录到
`mongo --port 27017 -u siteUserAdmin -p password --authenticationDatabase admin`

## 为用户指定角色

```
use reporting
db.grantRolesToUser(
  "reportsUser",
  [
    { role: "readWrite", db: "products" } ,
    { role: "readAnyDatabase", db:"admin" }
  ]
)
```