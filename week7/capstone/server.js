const express = require('express');
const mySQL = require('mysql');
const CORS = require('cors')
const PORT = 4000

//mySQL Server
const db = mySQL.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Phillip2020#',
    database: 'BobRoss' //BobRoss
})

//Error Handling
db.connect((err) => {
    if(err){
        throw err;
    }
    console.log('Connected to database successfully!')
})

//Express Server
const app = express();
app.use(express.json());
app.use(CORS());

//Creat Column
app.post('/insertColumn', (req, res) => {
    let colPost = req.body  //req.body.product etc
    console.log(req.body)
    let myQuery = `ALTER TABLE '${colPost}' ADD COLUMN id INT PRIMARY KEY auto_increment NOT NULL FIRST;`
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        res.send('Column created successfully.')
    })
})

//Create Row
app.post('/insertRow', (req, res) => {
    let post = req.body  //req.body.product etc
    console.log(req.body)
    let myQuery = `INSERT INTO RossFiles (episode, title, details) VALUES ('${post.episode}', '${post.title}', '${post.details};`
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        res.send('Row created successfully.')
    })
})

//Select Query
app.get('/rows', (req, res) => {
    let myQuery = 'SELECT * FROM RossFiles'
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        res.send(result)
    })
})

//Select Single Query
app.get('/rows/:id', (req, res) => {
    let single = req.body
    let myQuery = `SELECT '${single}' FROM RossFiles`
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        res.send(result)
    })
})

//Update Query
app.post('/updateRow/:id', (req, res) => {
    let updated = req.body
    let myQuery = `UPDATE RossFiles SET episode = '${updated}', title = '${updated}', details = '${updated}' WHERE id = ${req.params.id}` //product = '${newProduct}' WHERE id = ${req.params.id}
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        res.send('Successfully updated.')
    })
})

//Delete Query
app.delete('/deleteRow/:id', (req, res) => {
    let myQuery = `DELETE FROM RossFiles WHERE id = ${req.params.id}`
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        res.send('Successfully deleted.')
    })
})

//PORT
app.listen(PORT, () => {
    console.log(`Local server open on PORT ${PORT}`)
})