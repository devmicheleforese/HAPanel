# OpenHAB API Documentation

## GET and POST with the Terminal

```terminal
curl -X GET "http://192.168.1.81:8080/rest/items/{item_name}/status" -H "Accrpt: */*"
curl -X POST "http://192.168.1.81:8080/rest/items/{item_name}" -H "Accrpt: */*" -H "Content-type: text/plain" -d "ON"
```

Consider using [Postman](https://www.postman.com)