export type Article = {
	id: number;
	url: string;
	title: string;
	publishDate: string;
	lastEditDate: string;
	featuredImgUrl?: string;
	descriptionMd?: string;
	summaryMd?: string;
	textMd: string;
}

export const mockArticle: Article = {
	id: 0,
	url: 'mock-article',
	title: 'Mock Article',
	publishDate: '2023-10-26T00:09:52.221Z',
	lastEditDate: '2023-10-26T00:09:52.221Z',
	descriptionMd: 'This is a brief article to be used for testing.',
	summaryMd: 'In summary:\n> all functionality should be working!\n\n- *Lists*\n- **Text decoration**\n- `Code snippets`',
	textMd: '## Headers should work.\n### H3\n#### H4\n##### H5\n###### H6\n## Blockquotes should be functional.\n> This way, we can draw attention to important words.\n\n## Code blocks should also work.\n```cpp\nint main() {\nstd::cout << "Hello world!";\n}\n```',
}
