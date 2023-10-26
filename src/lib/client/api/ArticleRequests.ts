import type { Article } from "$types/Article";

/** Get all articles. */
export const getArticles = async () => {
	const request: RequestInit = {
		method: 'GET',
		redirect: 'follow',
	}
	const response = await fetch('/api/v1/articles', request);
	return response.json();
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
			`fetch route: ${route}\n` +
			`response: ${response.status} ${response.statusText}\n` +
			`payload: ${await response.json()}`
		);
	}
	const result: Article = await (response.json() as Promise<Article>);
	return result;
}
