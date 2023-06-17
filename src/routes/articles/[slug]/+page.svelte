<script lang="ts">
  import type { PageData } from "./$types";
	export let data: PageData;
</script>

<h1>Article {data.slug}</h1>
<p>Text goes here about {data.slug}.</p>