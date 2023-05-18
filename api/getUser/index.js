const pg = require("pg");

const { Client } = pg;

module.exports.handler = async (event) => {
  const requestBody = JSON.parse(event.body);

  try {
    const client = new Client({
      host: "palodevsecops.clqlzzlfgyxm.ap-southeast-1.rds.amazonaws.com",
      user: "postgres",
      database: "palodevsecops",
      password: "palodevsecops",
      port: 5432,
    });

    await client.connect();

    await client.query(
      `INSERT INTO test_users (username, password) VALUES ('${requestBody.username}', '${requestBody.password}')`
    );

    await client.end();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "successfully insert new user",
      }),
    };
  } catch (err) {
    console.log("Error while trying to connect to db");
    return err;
  }
};
