const router = require("express").Router();
const productController = require("../controllers/product");
const userController = require("../controllers/user");
const orderController = require("../controllers/order");

router.get("/product", productController.get);
router.get("/product/{:id}", productController.getById);
router.post("/product", productController.addProduct);

router.get("/user", userController.get);
router.get("/user/{:id}", userController.getById);
router.post("/user", userController.createUser);

router.get("/order", orderController.get);
router.post("/order/cash", orderController.orederByCash);
router.post("/order/point", orderController.orederByPoint);

module.exports = router;