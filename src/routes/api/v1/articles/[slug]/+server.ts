import { json, type ServerLoad } from "@sveltejs/kit";
import psql from "$lib/server/utils/psql";

export const GET: ServerLoad = async ({ params, request }) => {
	//TODO: return article from database by SLUG

	/*psql.connect();
	const res = await psql.query('SELECT $1::text as message', ['Hello world!'])
	console.log(res.rows[0].message)
	psql.end();

	return json(res.rows[0].message);*/
	return json('');
}

export const POST: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.');
}

export const PATCH: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.');
}

export const PUT: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.');
}

export const DELETE: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.');
}
