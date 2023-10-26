<script lang="ts">
	import { marked } from 'marked';
	import { getArticle } from "$api/ArticleRequests";
  import type { PageData } from "./$types";
	export let data: PageData;
	const articleData = getArticle(parseInt(data.slug));
</script>

{#await articleData}
<p>Loading article...</p>
{:then article}
<h1>{article.title}</h1>
<p>{article.publishDate}</p>
<p>{article.lastEditDate}</p>
{@html marked.parse(article.descriptionMd)}
{@html marked.parse(article.summaryMd)}
{@html marked.parse(article.textMd)}
{:catch error}
<p>{error}</p>
{/await}
