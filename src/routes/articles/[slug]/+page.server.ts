import type { PageServerLoad } from './$types.js'
import type { Article } from '$types/Article.js';
import { getArticle } from "$api/ArticleRequests";

export const load: PageServerLoad = async ({ params, fetch }) => {
	let pageData: {
		article: Article | null,
		articleError: unknown | null,
	} = {
		article: null,
		articleError: null,
	};
	try {
		pageData.article = await getArticle(params.slug, fetch);
	} catch(e) {
		pageData.articleError = (e as Error).message;
	}
	return pageData;
}
