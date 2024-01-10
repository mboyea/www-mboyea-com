<script lang="ts">
  import type { PageData } from "./$types";
	export let data: PageData;
</script>

<h1 class="centered">All Articles</h1>
{#if data.articles}
<nav>
	<ul>
		{#each data.articles as article (article.id)}
		<li>
			<a href="/articles/{article.url}">{article.title}</a>
		</li>
		{/each}
	</ul>
</nav>
{:else if data.articlesError}
<p>{data.articlesError}</p>
{/if}
