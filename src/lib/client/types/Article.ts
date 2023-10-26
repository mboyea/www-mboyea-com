// TODO: Article type - see www.yourzombiemop.com src code
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
	title: 'Title',
	publishDate: '',
	lastEditDate: '',
	descriptionMd: '',
	summaryMd: '',
	textMd: '',
}
