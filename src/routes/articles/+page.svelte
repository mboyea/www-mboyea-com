<script lang="ts">
	import type { PageData } from "./$types";
	import { marked } from 'marked';
	export let data: PageData;
</script>

<h1 class="centered">All Articles</h1>
{#if data.articles}
<nav>
	<ul>
		{#each data.articles as article (article.id)}
		<li>
			<a href="/articles/{article.url}">
				<h2 class="title">{article.title}</h2>
				{#if article.descriptionMd}
				<div class="description">
					{@html marked.parse(article.descriptionMd)}
				</div>
				{/if}
			</a>
		</li>
		{/each}
	</ul>
</nav>
{:else if data.articlesError}
<p>{data.articlesError}</p>
{/if}

<style lang="scss">
	nav {
		padding: 0 2rem;
		ul {
			margin: 0;
			padding: 0;
			li {
				display: contents;
				a {
					display: block;
					padding: 1px 0;
					text-decoration: none;
					border-top: solid 1px;
				}
			}
		}
	}
</style>
