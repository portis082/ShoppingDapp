const { deployed } = require("../utils/connect");

module.exports = {
    get: async (req, res) => {
        try {
            const orderInfo = await deployed.methods.getAllOrder().call();
            res.status(200).json(orderInfo);
        } catch (err) {
            res.status(404).send("Server Error");
        }
    },

    orederByCash: async (req, res) => {
        const { userId, items } = req.body;
        const data = [[], []];

        items.forEach((el) => {
            data[0].push(el.productId);
            data[1].push(el.amount);
        });

        try {
            const result = await deployed.methods.orderByCash(userId, data).send();
            res.status(200).json(result.events.orderEvent.returnValues); 
        } catch (err) {
            res.status(404).send("Wrong Infomation");
        }
    },

    orederByPoint: async (req, res) => {
        const { userId, items } = req.body;
        const data = [[], []];

        items.forEach((el) => {
            data[0].push(el.productId);
            data[1].push(el.amount);
        });

        try {
            const result = await deployed.methods.orderByPoint(userId, data).send();
            res.status(200).json(result.events.orderEvent.returnValues); 
        } catch (err) {
            res.status(404).send("Wrong Infomation");
        }
    }
}