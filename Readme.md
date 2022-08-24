# 실행 문서
## Truffle / Ganache 사용

```
npm i -g truffle
npm i -g ganache-cli
```

## env 파일

```
ADDRESS=
HOST=
GANACHEPORT=
NETWORKID=
```
- ADDRESS : 0번째 address
- HOST : Ganache 호스트
- GANACHEPORT : Ganache 포트
- NETWORKID : Ganache network ID

## 명령어

1. ganache-cli -i [NetworkID] -p [포트]
2. truffle migrate
3. npm start

# Api 문서

- UserInfo : [ id, name, cash, point ]

- ProductInfo : [ id, name, price, quantity, rate, owner ]

- OrderInfo [ id, userId, totalPrice, totalPoint, accumulation, [[ product IDs, ... ], [ amounts, ...]] ]

## Product

### get     /product
- request : -
- response : [ProductInfo, ...]

### get     /product/:id
- param : id
- request : -
- response : [ ProductInfo ]

### post    /product
- request :
{
    name : string,
    price : number,
    quantity : number,
    rate : number(%),
    owner : string
}
- response : { ProductInfo }

## User

### get     /user
- request : -
- response : { ProductInfo }

### get     /user/:id
- param : id
- request : -
- response : { ProductInfo }

### post    /user
- request :
{
    name : string,
    cash : number,
    point : number
}
- response : { ProductInfo }

## Order

### get     /order
- request : -
- response : [ OrderInfo, ... ]

### post    /order/cash
- request :
{
    userId : number,
    items : array
    [
        {
            productId: number,
            amount: number
        }, ...
    ]
}
- response : { OrderInfo }

### post    /order/point
- request :
{
    userId : number,
    items : array
    [
        {
            productId: number,
            amount: number
        }, ...
    ]
}
- response : { OrderInfo }
