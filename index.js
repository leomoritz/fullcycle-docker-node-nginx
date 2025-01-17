// External Dependencies
const express = require('express')
const path = require('path')
const mysql = require('mysql')
const { faker } = require('@faker-js/faker')

// Database Configuration
const DB_CONFIG = {
    host: 'db',
    user: 'root',
    password: 'root',
    database: 'nodedb'
};

// Database Seeding
var person = generateRandomPerson()
const sql = `INSERT INTO people(name, phone, email) values ('${person.name}', '${person.phone}', '${person.email}')`

const connection = mysql.createConnection(DB_CONFIG)
connection.query(sql, (error, results) => {
    if (error) throw error
    console.log('Person inserted:', results)
})


function generateRandomPerson() {
    return person = {
        name: faker.person.firstName() + ' ' + faker.person.lastName(),
        phone: faker.phone.number(),
        email: faker.internet.email()
    }
}

// App configuration
const app = express()

// Definindo o motor de templates EJS
app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))

// Rota para pegar as pessoas do banco e renderizar no HTML
const query = 'SELECT * FROM people'

app.get('/', (req, res) => {
    connection.query(query, (error, results) => {
        if (error) throw error
        res.render('index', { people: results })
    })
})

const PORT = 3000
app.listen(PORT, () => {
    console.log(`Rodando na porta ${PORT}`)
})

// Hook que encerra conexão com o banco quando o servidor for encerrado
process.on('SIGINT', () => {
    connection.end((err) => {
        if (err) {
            console.error('Erro ao fechar a conexão:', err.stack);
        }
        console.log('Conexão com o banco encerrada.');
        process.exit(0);
    });
});