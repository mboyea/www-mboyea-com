import { json, type ServerLoad } from "@sveltejs/kit";
import psql from "$lib/server/utils/psql";

export const GET: ServerLoad = async ({ params, request }) => {
	if (isNaN(parseInt(params.slug || 'a'))) {
		return json('Ivalid article ID.', { status: 404 });
	}
	const response = await psql.query(`
		SELECT
			id,
			title,
			publish_date AS publishDate,
			last_edit_date AS lastEditDate,
			description_md AS descriptionMd,
			summary_md AS summaryMd,
			text_md AS textMd
		FROM article
		WHERE id=${params.slug}
	`);
	if (response.rowCount < 1) {
		return json('Article not found.', { status: 404 });
	}
	return json(response.rows[0]);
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
