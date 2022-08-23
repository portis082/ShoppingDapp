require("dotenv").config();
const express = require("express");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const PORT = process.env.SERVER_PORT || 4000;
const app = express();
const indexRouter = require("./routes");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(
  cors({
    origin: true,
    method: ["GET", "POST", "PATCH", "PUT", "DELETE"],
    credentials: true,
    SameSite: "None",
  }),
);

app.use("/", indexRouter);

app.listen(PORT, () => {
    console.log(`server listening at http://localhost:${PORT}`);
});