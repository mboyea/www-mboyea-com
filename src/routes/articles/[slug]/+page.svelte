<script lang="ts">
	import { marked } from 'marked';
  import type { PageData } from "./$types";
	export let data: PageData;
</script>

{#if data.article}
<article>
	<header>
		<h1>{data.article.title}</h1>
		<p>Published: {data.article.publishDate}</p>
		{#if data.article.publishDate != data.article.lastEditDate}
			<p>Last Edited: {data.article.lastEditDate}</p>
		{/if}
	</header>
	{#if data.article.descriptionMd}
		<section class="description">
			<h2>Description</h2>
			{@html marked.parse(data.article.descriptionMd)}
		</section>
	{/if}
	{#if data.article.summaryMd}
		<section class="summary">
			<h2>Summary</h2>
			{@html marked.parse(data.article.summaryMd)}
		</section>
	{/if}
	{@html marked.parse(data.article.textMd)}
</article>
{:else if data.articleError}
<p>{data.articleError}</p>
{/if}

<style lang="scss">
	article {
		width: min(100%, 54rem);
		height: 100%;
		margin: 0 auto;
		padding: 1rem 2rem;
		background-color: var(--article-background-color);
	}
</style>
