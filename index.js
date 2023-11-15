const express = require('express'),
  morgan = require('morgan'),
  fs = require('fs'), // import built in node modules fs and path 
  path = require('path');

const app = express();
app.use(morgan('common'));

let top10movies = [
    {
        title: "The Matrix",
        year: 1999,
        director: "The Wachowskis",
    },

    {
        title: "Predator",    
        year: 1987,
        director: "John McTiernan",
    },
    {   title: "Prometheus",   
        year: 2012, 
        director: "Ridley Scott",
    },
    {
        title: "The Dark Knight",
        year: 2008,
        director: "Christopher Nolan",  
    },
    {
        title: "Star Wars",
        year: 1977,
        director: "George Lucas",
    },
    {
        title: "The Big Short",
        year: 2015, 
        director: "Adam McKay",
    },
    {
        title: "The Godfather",
        year: 1972,
        director: "Francis Ford Coppola",
    },
    {
        title: "The Lord of the Rings",
        year: 2001,
        director: "Peter Jackson",
    },
    {
        title: "Schindler's List",
        year: 1993,
        director: "Steven Spielberg",
    },
    {
        title: "Forrest Gump",
        year: 1994,
        director: "Robert Zemeckis",
    }
]
// create a write stream (in append mode)
// a ‘log.txt’ file is created in root directory


// setup the logger
const accessLogStream = fs.createWriteStream(path.join(__dirname, 'log.txt'), {flags: 'a'})
app.use(morgan('combined', {stream: accessLogStream}));

// serve static files
app.use(express.static('public'));

app.get('/documentation.html', (req, res) => {
  res.sendFile('public/documentation.html', {root: __dirname});
});

app.get('/', (req, res) => {
  res.send('Welcome to my appFlix!');
});

app.get('/movies', (req, res) => {
  res.json(top10movies);
});
app.get('/')

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something Broke!');
});

app.listen(8080, () => {
  console.log('Your app is listening on port 8080.');
});