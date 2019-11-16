const express = require('express')
const path = require('path')
const mongoose = require('mongoose')
const cors = require('cors')
const config = require("config")
const usersRoute = require("./routes/api/users.route")
require('dotenv/config')

const app = express()

app.use(express.urlencoded({extended: false}))
app.use(express.json({limit: '50mb'}));
app.use(cors())

if (!config.get("myprivatekey")) {
    console.error("FATAL ERROR: myprivatekey is not defined.");
    process.exit(1);
  }

//Set a static folder
app.use(express.static(path.join(__dirname,'/data/img')))

app.use('/api/dogs', require('./routes/api/dogs'))
app.use("/api/users", usersRoute);

const PORT = process.env.PORT || 5000

mongoose.connect(process.env.LOCAL_DB, { useNewUrlParser: true }).catch((error) => { console.log(error); });
 
app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
