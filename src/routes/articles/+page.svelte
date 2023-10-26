<script lang="ts">
	import { getArticles } from "$api/ArticleRequests";
	const articleDataList = getArticles();
</script>

<h1>All Articles</h1>
{#await articleDataList}
<p>Loading articles...</p>
{:then articleList}
<ul>
	{#each articleList as article (article.id)}
	<li><a href="/articles/{article.id}">{article.title}</a></li>
	{/each}
</ul>
{:catch error}
<p>{error}</p>
{/await}
