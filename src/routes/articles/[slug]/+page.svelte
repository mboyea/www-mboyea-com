<script lang="ts">
	import { getArticle } from "$api/ArticleRequests";
  import type { PageData } from "./$types";
	export let data: PageData;
	let articleData = getArticle(parseInt(data.slug));
</script>

{#await articleData}
<p>Loading article...</p>
{:then article}
<h1>{article.title}</h1>
<p>{article.publishDate}</p>
<p>{article.lastEditDate}</p>
<p>{article.descriptionMd}</p>
<p>{article.summaryMd}</p>
<p>{article.textMd}</p>
{:catch error}
<p>{error}</p>
{/await}
