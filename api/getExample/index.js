"use strict";
import { Client } from "pg";

exports.handler = async function (event, context) {
  let requestBody;

  try {
    requestBody = JSON.parse(event.body);
  } catch (e) {
    return {
      statusCode: 200,
      body: JSON.stringify("Invalid body"),
    };
  }

  try {
    const client = new Client({
      user: process.env.DB_USER,
      host: process.env.HOST,
      database: process.env.DB_NAME,
      password: process.env.DB_PASSWORD,
      port: 5432,
    });

    await client.connect();

    const res = await client.query(
      `SELECT * FROM todo_users WHERE name='${requestBody.username}' AND password='${requestBody.password}'`
    );

    await client.end();

    if (res.rowCount > 0) {
      return {
        statusCode: 200,
        body: JSON.stringify({ userVerified: true }),
      };
    }

    return { statusCode: 200, body: JSON.stringify({ userVerified: false }) };
  } catch (err) {
    console.log("Error while trying to connect to db");
  }
};
