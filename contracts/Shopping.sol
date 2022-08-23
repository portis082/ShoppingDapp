// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract User {
    uint userCount = 0;
    uint productCount = 0;

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

    event userEvent(uint256 _id, string _name, uint256 _cash, uint256 _point);
    mapping(uint256=>UserInfo) public UserInfoMapping;
    mapping(uint256=>ProductInfo) public ProductMapping;

    function getUserInfo(uint256 _id) public view returns(UserInfo memory){
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
        productCount++;
    }
}