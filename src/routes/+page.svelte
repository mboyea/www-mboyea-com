<script lang="ts">
    import { onMount } from "svelte";

	const test = async () => {
		const request: RequestInit = {
			method: 'GET',
		}
		const response = await fetch('/api', request);
		const responseJSON = await response.json();
	}
	onMount(test);
</script>

<h1>I'm Matthew Boyea</h1>
<p>I practice mixed martial arts, fishing, reading, bodybuilding, cooking, running, gymnastics, automotive mechanics, studying (psychology, philosophy, sociology), photography, videography, writing, game development, and software engineering.</p>
