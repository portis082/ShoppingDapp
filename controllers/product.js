const { deployed } = require("../utils/connect");

module.exports = {
    get: async (req, res) => {
        try {
            const productInfo = await deployed.methods.getAllProduct().call();
            res.status(200).json(productInfo);
        } catch (err) {
            res.status(404).send("Server Error");
        }
    },

    getById: async (req, res) => {
        const id = req.params.id;
        
        try{
            const data = await deployed.methods.getProductById(id).call();
            res.status(200).json(data);
        } catch(err) {
            res.status(400).send("Incorrect id");
        }
    },

    addProduct: async (req, res) => {
        const { name, price, quantity, rate, owner } = req.body;

        if(!name || price === undefined || quantity === undefined || quantity === undefined || !owner) {
            res.status(401).send("Wrong Infomation");
        } else {
            try {
                const result = await deployed.methods.addProduct(name, price, quantity, rate, owner).send();
                res.status(200).json(result.events.productEvent.returnValues); 
            } catch (err) {
                res.status(404).send("Server Error");
            }
        }
    }
}