import type { Article } from "$types/Article";
import { paramsToCamelCase } from "$utils/objectUtils";

/** Get all articles. */
export const getArticles = async (fetchCallback = fetch) => {
	const route = `/api/v1/articles`;
	const request: RequestInit = {
		method: 'GET',
		redirect: 'follow',
	}
	const response = await fetchCallback(route, request);
	if (!response.ok) {
		throw new Error(
			`${response.status} - ${JSON.stringify(await response.json())}`
		);
	}
	return paramsToCamelCase(await response.json()) as Promise<Article[]>;
}

/** Get article by URL. */
export const getArticle = async (url: string, fetchCallback = fetch): Promise<Article> => {
	const route = `/api/v1/articles/${url}`;
	const request: RequestInit = {
		method: 'GET',
		redirect: 'follow',
	}
	const response = await fetchCallback(route, request);
	if (!response.ok) {
		throw new Error(
			`${response.status} - ${JSON.stringify(await response.json())}`
		);
	}
	return paramsToCamelCase(await response.json()) as Promise<Article>;
}
