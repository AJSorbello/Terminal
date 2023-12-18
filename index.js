const express = require("express");
BodyParser = require("body-parser");
UUID = require("uuid");
const morgan = require("morgan");
const mongoose = require("mongoose");
const Models = require("./models.js");

const app = express();

// Models
const Movies = Models.Movie;
const Users = Models.User;
const Genres = Models.Genre;
const Directors = Models.Director;

// MongoDB Connection
mongoose.connect("mongodb://127.0.0.1:27017/cfDB");

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(morgan("common"));

//inputing body parser
// app.use(bodyParser.json());

// Middleware for passport
// app.use(bodyParser.urlencoded({ extended: true }));
let auth = require("./auth")(app);
const passport = require("passport");
require("./passport");

app.get("/", (req, res) => {
  res.send("Welcome to myFlix!");
});
// User Routes
// GET: Fetch all users
app.get("/users",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    try {
      const users = await Users.find();
      res.status(200).json(users);
    } catch (err) {
      res.status(500).send("Error: " + err);
    }
  }
);

// GET: Fetch a user by username
app.get(
  "/users/:Username",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    try {
      const user = await Users.findOne({ Username: req.params.Username });
      user ? res.json(user) : res.status(404).send("User not found");
    } catch (err) {
      res.status(500).send("Error: " + err);
    }
  }
);

// PUT: Update a user's info by username
// app.put("/users/:Username",
// passport.authenticate("jwt", { session: false }),
// async (req, res) => {
//   try {
//     const updatedUser = await Users.findOneAndUpdate(
//       { Username: req.params.Username },
//       { $set: req.body },
//       { new: true }
//     );
//     updatedUser
//       ? res.json(updatedUser)
//       : res.status(404).send("User not found");
//   } catch (err) {
//     res.status(500).send("Error: " + err);
//   }
// });

// PUT: Update a user's info by username
app.put("/users/:Username",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    // CONDITION TO CHECK ADDED HERE
    if (req.user.Username !== req.params.Username) {
      return res.status(400).send("Permission denied");
    }
    // CONDITION ENDS
    await Users.findOneAndUpdate(
      { Username: req.params.Username },
      {
        $set: {
          Username: req.body.Username,
          Password: req.body.Password,
          Email: req.body.Email,
          Birthday: req.body.Birthday,
        },
      },
      { new: true }
    ) // This line makes sure that the updated document is returned
      .then((updatedUser) => {
        res.json(updatedUser);
      })
      .catch((err) => {
        console.log(err);
        res.status(500).send("Error: " + err);
      });
  }
);

// POST: Add a user
//Add a user
/* We’ll expect JSON in this format
{
  ID: Integer,
  Username: String,
  Password: String,
  Email: String,
  Birthday: Date
}*/
app.post("/users", async (req, res) => {
  await Users.findOne({ Username: req.body.Username })
    .then((user) => {
      if (user) {
        return res.status(400).send(req.body.Username + "already exists");
      } else {
        Users.create({
          Username: req.body.Username,
          Password: req.body.Password,
          Email: req.body.Email,
          Birthday: req.body.Birthday,
        })
          .then((user) => {
            res.status(201).json(user);
          })
          .catch((error) => {
            console.error(error);
            res.status(500).send("Error: " + error);
          });
      }
    })
    .catch((error) => {
      console.error(error);
      res.status(500).send("Error: " + error);
    });
});

// Delete a user by username
app.delete(
  "/users/:Username",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    await Users.findOneAndUpdate({ Username: req.params.Username })
      .then((user) => {
        if (!user) {
          res.status(400).send(req.params.Username + " was not found");
        } else {
          res.status(200).send(req.params.Username + " was deleted.");
        }
      })
      .catch((err) => {
        console.error(err);
        res.status(500).send("Error: " + err);
      });
  }
);

// Movie Routes
// GET: Fetch all movies
app.get("/movies", async (req, res) => {
  await Movies.find()
    .then((movies) => {
      res.status(201).json(movies);
    })
    .catch((error) => {
      console.error(error);
      res.status(500).send("Error: " + error);
    });
});
// POST: Add a movie to a user's list of favorites
app.post(
  "/users/:Username/movies/:MovieID",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    try {
      const updatedUser = await Users.findOneAndUpdate(
        { Username: req.params.Username },
        { $push: { FavoriteMovies: req.params.MovieID } },
        { new: true }
      );
      updatedUser
        ? res.json(updatedUser)
        : res.status(404).send("User not found");
    } catch (err) {
      res.status(500).send("Error: " + err);
    }
  }
);

// DELETE: DELETE a movie of a user's list of favorites
app.delete(
  "/users/:Username/movies/:MovieID",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    try {
      const updatedUser = await Users.findOneAndUpdate(
        { Username: req.params.Username },
        { $pull: { FavoriteMovies: req.params.MovieID } },
        { new: true }
      );
      updatedUser
        ? res.json(updatedUser)
        : res.status(404).send("Did not delete.");
    } catch (err) {
      res.status(500).send("Error: " + err);
    }
  }
);

// GET: Fetch a movie by title
app.get("/movies/:Title", async (req, res) => {
  try {
    const movie = await Movies.findOne({ Title: req.params.Title });
    movie ? res.json(movie) : res.status(404).send("Movie not found");
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// GET: Fetch all movies by genre
app.get("/movies/genres/:genreName", async (req, res) => {
  try {
    const movies = await Movies.find({ "Genre.Name": req.params.genreName });
    movies ? res.json(movies) : res.status(404).send("Movies not found");
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// POST: Add a new movie
app.post("/movies", async (req, res) => {
  try {
    const newMovie = new Movie(req.body);
    await newMovies.save();
    res.status(201).send(newMovie);
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// PUT: Update a movie by title
app.put(
  "/movies/:Title",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    try {
      const updatedMovie = await Movies.findOneAndUpdate(
        { Title: req.params.Title },
        { $set: req.body },
        { new: true }
      );
      updatedMovie
        ? res.json(updatedMovie)
        : res.status(404).send("Title not found");
    } catch (err) {
      res.status(500).send("Error: " + err);
    }
  }
);

// DELETE: Remove a movie by title
app.delete(
  "/movies/:Title",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    try {
      const movie = await Movies.findOneAndDelete({ Title: req.params.Title });
      movie
        ? res.status(200).send(`${req.params.Title} was deleted.`)
        : res.status(404).send(`${req.params.Title} was not found`);
    } catch (err) {
      res.status(500).send("Error: " + err);
    }
  }
);

// Genre Routes

// GET: Fetch all genres
app.get("/genres", async (req, res) => {
  try {
    const genres = await Movies.distinct("Genre.Name");
    res.status(200).json(genres);
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// GET: Fetch a genre by name
app.get(
  "/genres/:genreName",
  // passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    try {
      const movie = await Movies.findOne({
        "Genre.Name": req.params.genreName,
      });
      movie ? res.json(movie.Genre) : res.status(404).send("Genre not found");
    } catch (err) {
      res.status(500).send("Error: " + err);
    }
  }
);

// PUT: Update genres description
app.put("/genres/:genreName", async (req, res) => {
  try {
    const movies = await Movies.updateMany(
      { "Genre.Name": req.params.genreName },
      { $set: { "Genre.Description": req.body.genreDescription } }
    );
    res.json(movies);
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// Get: Fetch all directors

app.get("/directors", async (req, res) => {
  try {
    const directors = await Movies.distinct("Director.Name");
    res.status(200).json(directors);
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// GET: Fetch all movies by director
app.get("/movies/director/:directorName", async (req, res) => {
  try {
    const movies = await Movies.find({
      "Director.Name": req.params.directorName,
    });
    movies ? res.json(movies) : res.status(404).send("Director not found");
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// GET: Fetch a director by name
app.get("/directors/:directorName", async (req, res) => {
  try {
    const directors = await Movies.findOne({
      "Director.Name": req.params.directorName,
    });
    directors
      ? res.json(directors.Director)
      : res.status(404).send("Director not found");
  } catch (err) {
    res.status(500).send("Error: " + err);
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send("Something broke!");
});

// Starting the server

app.listen(8080, () => {
  console.log("Listening on port 8080.");
});
