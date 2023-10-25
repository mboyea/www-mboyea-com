// get all articles
export const getArticles = async () => {
	const request: RequestInit = {
		method: 'GET',
		redirect: 'follow',
	}
	const response = await fetch('/api/v1/articles', request);
	return response.json();
}

// get article by ID
export const getArticle = async (id: string) => {
	const request: RequestInit = {
		method: 'GET',
		redirect: 'follow',
	}
	const response = await fetch(`/api/v1/articles/${id}`, request);
	return response.json();
}
