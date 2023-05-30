
## User creat (foydalanuvchi yaratish)

```bash
curl -X POST -i http://localhost:8080/users -d "firstname=Azizbek" -d "lastname=Isroilov" -d "age=18" -d "password=991903704" -d "email=azizdev.full@gmail.com"
```

## Sign in (ro'yxatdan o'tish)

```bash
curl -c cookies.txt -X POST localhost:8080/sign_in -d email=azizdev.full@gmail.com -d password=991903704
```

##  Update (parolni yangilash): (bu ishlashi uchun avval sign_in qilish kerak) (you need to sign_in first for this to work)

```bash
curl -b cookies.txt -X PUT localhost:8080/users -d password=almashti
```

## Sign out (akkountdan chiqish): (bu ishlashi uchun avval sign_in qilish kerak) (you need to sign_in first for this to work)

```bash
curl -b cookies.txt -X DELETE localhost:8080/sign_out 
```

## Delete (akkountni butunlay o'chirib tashlash): (bu ishlashi uchun avval sign_in qilish kerak) (you need to sign_in first for this to work)

```bash
curl -b cookies.txt -X DELETE localhost:8080/users 
```