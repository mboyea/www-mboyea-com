import type { Article } from "$types/Article";
import { paramsToCamelCase } from "$utils/objectUtils";

/** Get all articles. */
export const getArticles = async () => {
	const route = `/api/v1/articles`;
	const request: RequestInit = {
		method: 'GET',
		redirect: 'follow',
	}
	const response = await fetch(route, request);
	if (!response.ok) {
		throw new Error(
			`${response.status} - ${JSON.stringify(await response.json())}`
		);
	}
	return paramsToCamelCase(await response.json()) as Promise<Article[]>;
}

/** Get article by ID. */
export const getArticle = async (id: number): Promise<Article> => {
	const route = `/api/v1/articles/${id}`;
	const request: RequestInit = {
		method: 'GET',
		redirect: 'follow',
	}
	const response = await fetch(route, request);
	if (!response.ok) {
		throw new Error(
			`${response.status} - ${JSON.stringify(await response.json())}`
		);
	}
	return paramsToCamelCase(await response.json()) as Promise<Article>;
}
