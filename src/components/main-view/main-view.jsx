import React, { useState, useEffect } from "react";
import { MovieCard } from "../movie-card/movie-card";
import { MovieView } from "../movie-view/movie-view";
import { LoginView } from "../login-view/login-view";
import { SignupView } from "../signup-view/signup-view";

export const MainView = () => {
  const [movies, setMovies] = useState([]);
  const [selectedMovie, setSelectedMovie] = useState(null);
  const [user, setUser] = useState(null);
  const [authToken, setAuthToken] = useState(null);

  useEffect(() => {
    if (!authToken) {
      return;
    }

    fetch("https://ajmovies-fc7e7627ec3d.herokuapp.com/movies", {
      headers: { Authorization: `Bearer ${authToken}` },
    })
      .then((response) => response.json())
      .then((movies) => {
        const moviesFromApi = movies.map((movie) => ({
          _id: movie._id,
          Title: movie.Title,
          Description: movie.Description,
          //   Year: movie.Year,
          Genre: {
            Name: movie.Genre.Name,
          },
          Director: {
            Name: movie.Director.Name,
            Bio: movie.Director.Bio,
            Birth: movie.Director.Birth,
          },
          Featured: movie.Featured,
          //   ImagePath: movie.ImagePath,
        }));

        setMovies(moviesFromApi);
      })
      .catch((error) => console.error("Error fetching movies:", error));
  }, [authToken]);

  const handleLogin = (loggedInUser, authToken) => {
    setUser(loggedInUser);
    setAuthToken(authToken);
  };

  if (!user) {
    return (
      <>
        <LoginView onLoggedIn={handleLogin} />
        or
        <SignupView />
      </>
    );
  }

  if (selectedMovie) {
    return (
      <MovieView
        movie={selectedMovie}
        onBackClicked={() => {
          setSelectedMovie(null);
        }}
      />
    );
  }

  if (movies.length === 0) {
    return <div>The list is empty!</div>;
  }

  return (
    <div>
      {movies.map((movie) => (
        <MovieCard
          key={movie._id}
          movie={movie}
          onMovieClick={(newSelectedMovie) => {
            setSelectedMovie(newSelectedMovie);
          }}
        />
      ))}
      <button
        onClick={() => {
          setUser(null);
          setToken(null);
        }}>
        Log out
      </button>
    </div>
  );
};
