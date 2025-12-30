const express = require("express");
const { Client } = require("pg");

const app = express();
const PORT = process.env.PORT || 3000;

app.get("/hello", async (req, res) => {
  const client = new Client({
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    ssl: { rejectUnauthorized: false }
  });

  try {
    await client.connect();
    const result = await client.query("SELECT 1");
    await client.end();

    res.json({
      message: "Hello! Database connected.",
      dbTest: result.rows
    });
  } catch (err) {
    res.status(500).json({
      error: "Database connection failed",
      details: err.message
    });
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
