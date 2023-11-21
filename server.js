const express = require('express'),
  app = express(),
  bodyParser = require('body-parser'),
  uuid = require('uuid');

app.use(bodyParser.json());

let users = [
{
    id: 1,
    name: "kim",
    favoriteMovies: [""]
},
{
    id: 2,
    name: "Joe",
    favoriteMovies: ["The Predator"]
},

]

let movies = [
    {
        "Title": "The Fountain",
        "Description": "A classic",
        "Genre": { 
        "Name":"Drama",
        "Year": "2015"
    },
        "Director": {
            "Name": "Darren Aaronofsky",
            "Bio": "Darren Aronofsky was born February 12, 1969, in Brooklyn, New York. He is the founder and CEO of the American Institute of Motion Picture Art and Technology (A-MPT).",
            "Birth": 1969.0
},
        "imageURL": "https://upload.wikimedia.org/wikipedia/en/0/0a/The_Fountain_%282015%29.jpg",
        "featured": false
    },
     {
        "Title":"The Predator",
        "Description": "Dutch (Arnold Schwarzenegger), a soldier of fortune, is hired by the U.S. government to secretly rescue a group of politicians trapped in Guatemala. But when Dutch and his team, and their crew, are transported to which includes weapons expert Blain (Jesse Ventura) and CIA agent George (Carl Weathers), land in Central America, something is gravely wrong. After finding a string of dead bodies, the crew discovers they are being hunted by a brutal creature with superhuman strength and the ability to disappear into its surroundings.he jungle, an alien ship crash-lands on Earth. Man must fight to survive.",
        "Genre": {
        "Name":"Action",
        "Year": "1987"
     },
        "Director": {
            "Name": "John McTiernan",
            "Bio": "Darren John Campbell McTiernan Jr. is an American filmmaker. He is best known for his action films, including Predator, Die Hard, and The Hunt for Red October.Aronofsky was born February 12, 1969, in Brooklyn, New York. He is the founder and CEO of the American Institute of Motion Picture Art and Technology (A-MPT).",
            "Birth": 1969.0
        },
        "imageURL": "https://www.imdb.com/title/tt0093773/mediaviewer/rm2307609089/?ref_=tt_ov_i",
        "featured": false
    }
];

// CREATE
app.post('/users', (req, res) => {
    const newUser  = req.body;

    if (newUser.name) {
        newUser.id = uuid.v4();
        users.push(newUser);
        res.status(201).json(newUser)
    } else {
        res.status(400).send('User not created');
    }
})
// CREATE
app.post('/users/:id/:movieTitle', (req, res) => {
    const { id, movieTitle } = req.params;

    let user = users.find( user => user.id == id);

    if (user) {
        user.favoriteMovies.push(movieTitle);
        res.status(200).send(`${movieTitle} has been added to user ${id}'s array of favorite movies`);
    } else {
        res.status(400).send('no such user');
    }
})
// READ
app.get('/movies', (req, res) => {
    res.status(200).json(movies);
})
// READ
app.get('/movies/:title', (req, res) => {
    const { title } = req.params;
    const movie = movies.find( movie => movie.Title === title);

    if (movie) {
        res.status(200).json(movie);
    } else {
        res.status(400).send('Movie not found')
    }
});
// READ
app.get('/movies/genre/:genreName', (req, res) => {
    const { genreName } = req.params;
    const genre = movies.find( movie => movie.Genre.Name === genreName ).Genre;

    if (genre) {
        res.status(200).json(genre);
    } else {
        res.status(400).send('Genre not found')
    }
});
// READ
app.get('/movies/directors/:directorName', (req, res) => {
    const { directorName } = req.params;
    const director = movies.find( movie => movie.Director.Name === directorName ).Director;

    if (director) {
        res.status(200).json(director);
    } else {
        res.status(400).send('Director not found')
    }
});
// UPDATE
app.put('/users/:id', (req, res) => {
    const { id } = req.params;
    const updatedUser = req.body;

    let user = users.find( user => user.id == id);

    if (user) {
        user.name = updatedUser.name;
        res.status(200).json(user);
    } else {
        res.status(400).send('no such user');
    }
})
// DELETE
app.delete('/users/:id/:movieTitle', (req, res) => {
    const { id, movieTitle } = req.params;

    let user = users.find( user => user.id == id);

    if (user) {
        user.favoriteMovies = user.favoriteMovies.filter( title => title !== movieTitle);
        res.status(200).send(`${movieTitle} has been removed from user ${id}'s array of favorite movies`);
    } else {
        res.status(400).send('no such user');
    }
})
// DELETE
app.delete('/users/:id', (req, res) => {
    const { id } = req.params;

    let user = users.find( user => user.id == id);

    if (user) {
        users = users.filter( user => user.id != id);
    
        res.status(200).send(`user ${id} has been removed from users`);
    } else {
        res.status(400).send('no such user');
    }
})

app.listen(8080, () => console.log ('listening on port 8080'))