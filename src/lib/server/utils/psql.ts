import { PG_URL } from "$env/static/private";
import pg from "pg";
const { Pool } = pg;

console.log(`Establishing connection to database.`);
let pool = new Pool({ connectionString: PG_URL });

console.log(`Testing connection to database.`);
try {
	await pool.connect();
	console.log('Client successfully connected to database.');
	try {
		const response = await pool.query(
			'SELECT $1::text as message',
			['Client successfully queried database.']
		);
		console.log(response.rows[0].message);
		console.log('Test successful.')
	}
	catch(e) {
		console.error(`Query failed: ${e}`);
	}
}
catch(e) {
	console.error(`Connection failed: ${e}`);
}

const psql = pool;
export default psql;
