import dotenv from "dotenv"

dotenv.config()

const mongoDB = require('mongoose');
const uri = process.env.MONGO_URI
mongoDB.connect(uri)

export default mongoDB
