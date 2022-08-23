const { deployed } = require("../utils/connect");

module.exports = {
    get: async (req, res) => {
        try {
            const userInfo = await deployed.methods.getAllUser().call()
            res.status(200).json(userInfo);
        } catch (err) {
            res.status(401).send("Server Error");
        }
    },

    getById: async (req, res) => {
        const id = req.params.id;
        
        try{
            const userInfo = await deployed.methods.getUserInfo(id).call();
            res.status(200).json(userInfo);
        } catch(err) {
            res.status(400).send("Incorrect id");
        }
    },

    createUser: async (req, res) => {
        const { name, cash, point } = req.body;

        if(!name || cash === undefined || point === undefined) {
            res.status(401).send("Wrong Infomation");
        } else {
            try {
                const result = await deployed.methods.createUser(name, cash, point).send();
                res.status(200).json(result.events.userEvent.returnValues);
            } catch (err) {
                res.status(404).send("Server Error");
            }
        }
    }
}