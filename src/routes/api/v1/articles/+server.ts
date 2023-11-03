import { json, type ServerLoad } from "@sveltejs/kit";
import psql from "$lib/server/utils/psql";

export const GET: ServerLoad = async () => {
	const response = await psql.query(`
		SELECT *
		FROM article
	`);
	if (response.rowCount < 1) {
		return json('No articles found.', { status: 404 });
	}
	let result = response.rows
	return json(result);
}

export const POST: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.', { status: 403 });
}

export const PATCH: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.', { status: 403 });
}

export const PUT: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.', { status: 403 });
}

export const DELETE: ServerLoad = async ({ params, request }) => {
	return json('You don\'t have access to this endpoint.', { status: 403 });
}
