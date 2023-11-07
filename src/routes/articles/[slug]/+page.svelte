<script lang="ts">
	import { marked } from 'marked';
	import { getArticle } from "$api/ArticleRequests";
  import type { PageData } from "./$types";
	export let data: PageData;
	const articleData = getArticle(data.slug);
</script>

{#await articleData}
<p>Loading article...</p>
{:then article}
<article>
	<header>
		<h1>{article.title}</h1>
		<p>Published: {article.publishDate}</p>
		{#if article.publishDate != article.lastEditDate}
			<p>Last Edited: {article.lastEditDate}</p>
		{/if}
	</header>
	{#if article.descriptionMd}
		<section class="description">
			<h2>Description</h2>
			{@html marked.parse(article.descriptionMd)}
		</section>
	{/if}
	{#if article.summaryMd}
		<section class="summary">
			<h2>Summary</h2>
			{@html marked.parse(article.summaryMd)}
		</section>
	{/if}
	{@html marked.parse(article.textMd)}
</article>
{:catch error}
<p>{error}</p>
{/await}

<style lang="scss">
	article {
		width: min(100%, 54rem);
		margin: 0 auto;
		padding: 1rem 2rem;
		background-color: var(--article-background-color);
	}
</style>
