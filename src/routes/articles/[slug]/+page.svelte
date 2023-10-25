<script lang="ts">
	import type { Article } from "$types/Article";
	import { getArticle } from "$api/ArticleRequests";
	import { onMount } from "svelte";
  import type { PageData } from "./$types";
	export let data: PageData;

	onMount(()=>{
		getArticle(data.slug)
			.then((responseJSON) => {
				console.log(responseJSON);
			})
			.catch((e) => {
				console.error(e);
			})
	});
</script>

<h1>Article [{data.slug}]</h1>
<p>Aa about [{data.slug}].</p>
