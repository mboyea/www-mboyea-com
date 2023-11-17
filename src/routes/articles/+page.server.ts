import type { PageServerLoad } from './$types.js'
import type { Article } from '$types/Article.js';
import { getArticles } from "$api/ArticleRequests";

export const load: PageServerLoad = async ({ fetch }) => {
	let pageData: {
		articles: Article[] | null,
		articlesError: unknown | null,
	} = {
		articles: null,
		articlesError: null,
	};
	try {
		pageData.articles = await getArticles(fetch);
	} catch(e) {
		pageData.articlesError = (e as Error).message;
	}
	return pageData;
}
