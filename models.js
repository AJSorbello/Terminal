/**
 * Mongoose library for MongoDB object modeling.
 *
 * @type {*}
 */
const mongoose = require("mongoose");

/**
 * Bcrypt library for hashing passwords.
 *
 * @type {*}
 */
const bcrypt = require('bcrypt');

/**
 * Defines the schema for movies in the MongoDB database.
 *
 * @type {*}
 */
let movieSchema = mongoose.Schema({
  Title: { type: String, required: true },
  Description: { type: String, required: true },
  Genre: {
    Name: String,
    Description: String,
  },
  Director: {
    Name: String,
    Bio: String,
  },
  Actors: [String],
  ImagePath: String,
  Featured: Boolean,
  Year: String,
  TrailerPath: String
});

/**
 * Defines the schema for users in the MongoDB database.
 *
 * @type {*}
 */
let userSchema = mongoose.Schema({
  Fullname: { type: String, required: true },
  Username: { type: String, required: true },
  Password: { type: String, required: true },
  Email: { type: String, required: true },
  Birthday: Date,
  FavoriteMovies: [{ type: mongoose.Schema.Types.ObjectId, ref: "Movie" }],
});

/**
 * Static method to hash a password using bcrypt.
 *
 * @param {string} password - The password to hash.
 * @returns {string} Hashed password.
 */
userSchema.statics.hashPassword = (password) => {
  return bcrypt.hashSync(password, 10);
};

/**
 * Method to validate a password against a hashed password stored in the user document.
 *
 * @param {string} password - The password to validate.
 * @returns {boolean} True if the password is valid, false otherwise.
 */
userSchema.methods.validatePassword = function(password) {
  return bcrypt.compareSync(password, this.Password);
};

/**
 * MongoDB model for movies.
 *
 * @type {*}
 */
let Movie = mongoose.model("Movie", movieSchema);

/**
 * MongoDB model for users.
 *
 * @type {*}
 */
let User = mongoose.model("User", userSchema);

module.exports.Movie = Movie;
module.exports.User = User;
