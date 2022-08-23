// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Shopping {
    uint userCount = 0;
    uint productCount = 0;
    uint orderCount = 0;

    struct UserInfo {
        uint id;
        string name;
        uint cash;
        uint point;
    }

    struct ProductInfo {
        uint id;
        string name;
        uint price;
        uint quantity;
        uint rate;
        string owner;
    }

    struct OrderInfo {
        uint id;
        uint userId;
        uint totalPrice;
        uint totalPoint;
        uint accumulation;
        uint[][] items;
    }

    struct Items {
        uint productId;
        uint amount;
    }

    event productEvent(uint256 _id, string _name, uint256 _price, uint256 _quantity, uint256 _rate, string _owner);
    event userEvent(uint256 _id, string _name, uint256 _cash, uint256 _point);
    event orderEvent(uint _id, uint _userId, uint _totalPrice, uint _totalPoint, uint _accumulation,  uint[][] _items);
    
    mapping(uint256=>UserInfo) public UserInfoMapping;
    mapping(uint256=>ProductInfo) public ProductMapping;
    mapping(uint256=>OrderInfo) public OrderMapping;

    function getAllUser() public view returns(UserInfo[] memory){
        UserInfo[] memory result = new UserInfo[](userCount);
        for(uint i=0; i<userCount; i++) {
            result[i] = UserInfoMapping[i];
        }
        return result;
    }

    function getUserInfo(uint256 _id) public view returns(UserInfo memory){
        require(_id < userCount, "Out of range");
        return UserInfoMapping[_id];
    }

    function createUser(string memory _name, uint256 _cash, uint256 _point) public {
        UserInfoMapping[userCount] = UserInfo(userCount, _name, _cash, _point);
        emit userEvent(userCount, _name, _cash, _point);
        userCount++;
    }

    function getProductById(uint256 _id) public view returns(ProductInfo memory){
        require(_id < productCount, "Out of range");
        return ProductMapping[_id];
    }

    function getAllProduct() public view returns(ProductInfo[] memory){
        ProductInfo[] memory result = new ProductInfo[](productCount);
        for(uint i=0; i<productCount; i++) {
            result[i] = ProductMapping[i];
        }
        return result;
    }

    function addProduct(string memory _name, uint256 _price, uint256 _quantity, uint256 _rate, string memory _owner) public {
        ProductMapping[productCount] = ProductInfo(productCount, _name, _price, _quantity, _rate, _owner);
        emit productEvent(productCount, _name, _price, _quantity, _rate, _owner);
        productCount++;
    }

    function getAllOrder() public view returns(OrderInfo[] memory){
        OrderInfo[] memory result = new OrderInfo[](orderCount);
        for(uint i=0; i<orderCount; i++) {
            result[i] = OrderMapping[i];
        }
        return result;
    }

    function orderByCash(uint256 _userId, uint[][] memory _data) public {
        uint _totalPrice = 0;
        uint _accumulation = 0;
        bool boolean = true;

        for(uint i=0; i<_data[0].length; i++) {
            ProductInfo memory _productInfo = getProductById(_data[0][i]);
            boolean = boolean && (_productInfo.quantity >= _data[1][i]);
            uint sum = _productInfo.price * _data[1][i];
            _totalPrice += sum;
            _accumulation += _productInfo.rate * sum / 100;
        }

        require(boolean && (UserInfoMapping[_userId].cash >= _totalPrice), "Wrong Values");

        UserInfoMapping[_userId].cash -= _totalPrice;
        UserInfoMapping[_userId].point += _accumulation;

        for(uint i=0; i<_data[0].length; i++) {
            ProductMapping[_data[0][i]].quantity -= _data[1][i];
        }
        
        OrderMapping[orderCount] = OrderInfo(orderCount, _userId, _totalPrice, 0, _accumulation, _data);
        emit orderEvent(orderCount, _userId, _totalPrice, 0, _accumulation, _data);
        orderCount++;
    }

    function orderByPoint(uint256 _userId, uint[][] memory _data) public {
        uint _totalPoint = 0;
        bool boolean = true;

        for(uint i=0; i<_data[0].length; i++) {
            ProductInfo memory _productInfo = getProductById(_data[0][i]);
            boolean = boolean && (_productInfo.quantity >= _data[1][i]);
            uint sum = _productInfo.price * _data[1][i];
            _totalPoint += sum;
        }

        require(boolean && (UserInfoMapping[_userId].point >= _totalPoint), "Wrong Values");

        UserInfoMapping[_userId].point -= _totalPoint;

        for(uint i=0; i<_data[0].length; i++) {
            ProductMapping[_data[0][i]].quantity -= _data[1][i];
        }
        
        OrderMapping[orderCount] = OrderInfo(orderCount, _userId, 0, _totalPoint, 0, _data);
        emit orderEvent(orderCount, _userId, 0, _totalPoint, 0, _data);
        orderCount++;
    }
}  