import { PG_URL } from "$env/static/private";
import pg from "pg";
const { Client } = pg;

let client = new Client({ connectionString: PG_URL });

console.log(`Connecting to database at host: ${client.host}.`);
client.connect()
.then(() => {
	console.log('Client successfully connected to database.');
})
.catch(e => {
	console.error(`Connection failed: ${e}`);
});
client.query('SELECT $1::text as message', ['Client successfully queried database.'])
.then((response) => {
	console.log(response.rows[0].message);
})
.catch(e => {
	console.error(`Query failed: ${e}`);
});

const psql = client;
export default psql;
