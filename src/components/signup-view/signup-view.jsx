import React, { useState } from "react";

export const SignupView = () => {
  const [fullName, setFullName] = useState("");
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [birthdate, setBirthdate] = useState("");

  const handleSubmit = (event) => {
    event.preventDefault();
    // Add your sign-up logic here, such as sending the form data to the server
    // You can access the values of fullName, username, email, password, and birthdate here
    console.log(fullName, username, email, password, birthdate);
  };
  const data = {
    Username: username,
    Password: password,
    Email: email,
    birthday: birthdate,
  };

  fetch("https://myflix-movies.herokuapp.com/users", {
    method: "POST",
    body: JSON.stringify(data),
    headers: {
      "Content-Type": "application/json",
    },
  }).then((response) => {
    if (response.ok) {
      alert("Account created successfully");
      window.location.reload();
    } else {
      alert("Failed to create account");
    }
  });

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Full Name:
        <input
          type="text"
          placeholder="Full Name"
          value={fullName}
          onChange={(event) => setFullName(event.target.value)}
        />
      </label>
      <label>
        Username:
        <input
          type="text"
          placeholder="Username"
          value={username}
          minLength="3"
          pattern="^[a-zA-Z0-9]+$"
          title="Username can only contain letters and numbers"
          onChange={(event) => setUsername(event.target.value)}
        />
      </label>
      <label>
        Email:
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(event) => setEmail(event.target.value)}
        />
      </label>
      <label>
        Password:
        <input
          type="password"
          placeholder="Password"
          value={password}
          minLength={5}
          pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,}"
          title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
          onChange={(event) => setPassword(event.target.value)}
        />
      </label>
      <label>
        birthday:
        <input
          type="date"
          placeholder="birthday"
          value={birthdate}
          onChange={(event) => setBirthdate(event.target.value)}
        />
      </label>
      <button type="submit">Sign Up</button>
    </form>
  );
};
