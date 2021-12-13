var cors = require('cors');
const express = require('express');
const app = express();

//middlewares
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cors({origin: '*'}));
//routes
app.use(require('./routers/index'));

app.listen(3000);
console.log('Server on post 3000');


// use it before all route definitions
