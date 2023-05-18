const pg = require("pg");

const { Client } = pg;

module.exports.handler = async (requestBody) => {
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
    const res = await client.query(`SELECT * FROM test_users`);

    await client.end();

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: `now have ${res.rowCount} users in the DB`,
      }),
    };
  } catch (err) {
    console.log("Error while trying to connect to db");
    return err;
  }
};
