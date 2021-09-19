const express = require('express');
const mySQL = require('mysql');
const CORS = require('cors')
const PORT = 4000

//mySQL Server
const db = mySQL.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'Phillip2020#',
    database: 'FSW140Wk6' //FSW140Wk6
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

//Empty DB
app.get('/createDB', (req, res) => {
    let myQuery = 'CREATE DATABASE FSW140Wk6'
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        let sql = `USE FSW140Wk6`
        db.query(sql, (err, result) => {
            if(err){
                throw err;
            }
        })
        res.send('FSW140Wk6 DB created successfully.')
    })
})

//Create Table
app.get('/createTable', (req, res) => {
    let myQuery = `CREATE TABLE KwikEMart (id INT auto_increment, product VARCHAR(65), price VARCHAR(10), info VARCHAR(130), PRIMARY KEY (id))`
    db.query(myQuery, (err, result) => {
        if(err){
            throw err;
        }
        console.log(result)
        res.send('KwikEMart Table created successfully.')
    })
})

//Create Row
app.post('/insertRow', (req, res) => {
    let post = req.body  //req.body.product etc
    console.log(req.body)
    let myQuery = `INSERT INTO KwikEMart (product, price, info) VALUES ('${post.product}', '${post.price}', '${post.info}');`
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
    let myQuery = 'SELECT * FROM KwikEMart'
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
    let myQuery = `UPDATE KwikEMart SET product = '${updated}', price = '${updated}', info = '${updated}' WHERE id = ${req.params.id}` //product = '${newProduct}' WHERE id = ${req.params.id}
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
    let myQuery = `DELETE FROM KwikEMart WHERE id = ${req.params.id}`
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