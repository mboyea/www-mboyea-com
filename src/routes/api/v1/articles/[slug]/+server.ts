import { json, type ServerLoad } from "@sveltejs/kit";
import psql from "$lib/server/utils/psql";

export const GET: ServerLoad = async ({ params }) => {
	const response = await psql.query(
		isNaN(parseInt(params.slug || 'a')) ?
		`
			SELECT *
			FROM article
			WHERE url='${params.slug}'
		` :
		`
			SELECT *
			FROM article
			WHERE id=${params.slug}
		`
	);
	if (response.rowCount < 1) {
		return json('Article not found.', { status: 404 });
	}
	let result = response.rows[0]
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
