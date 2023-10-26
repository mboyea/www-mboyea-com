export type Article = {
	id: number;
	title: string;
	publishDate: string;
	lastEditDate: string;
	descriptionMd: string;
	summaryMd: string;
	textMd: string;
}

export const mockArticle: Article = {
	id: 0,
	title: 'Mock Article',
	publishDate: '2023-10-26T00:09:52.221Z',
	lastEditDate: '2023-10-26T00:09:52.221Z',
	descriptionMd: 'This is a brief mock article, to be used for testing purposes.',
	summaryMd: 'To summarize:\n> all functionality should be working!\n-*Lists*\n-**Text decoration**\n-`Code snippets`',
	textMd: 'Blockquotes should be funtional.\n> This way, we can draw attention to important words.\nCode blocks should also work.\n```cpp\nint main() {\nstd::cout << "Hello world!";\n}\n```',
}
