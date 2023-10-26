<script lang="ts">
	import { getArticle } from "$api/ArticleRequests";
	import { onMount } from "svelte";
  import type { PageData } from "./$types";
	export let data: PageData;

	const loadArticle = () => {
		const articleId = parseInt(data.slug) || -1;
		if (articleId < 1) {
			// TODO: handle couldn't find article
			console.error(`'${data.slug}' is not a valid article id`)
			return;
		}
		getArticle(articleId)
			.then((result) => {
				console.log(result);
			})
			.catch((e) => {
				console.error(e);
			});
	}

	onMount(()=>{
		loadArticle();
	});
</script>

<h1>Article [{data.slug}]</h1>
<p>Aa about [{data.slug}].</p>
