<script lang="ts">
	import './+layout.scss'
	import TheSiteNav from '$modules/TheSiteNav.svelte';

	let currentYear: number = new Date().getFullYear();
</script>

<header id="page-header">
	<TheSiteNav/>
</header>

<div id="page-main">
	<slot />
</div>

<footer id="page-footer">
	<p>Copyright © {currentYear} Matthew Boyea</p>
</footer>

<style lang="scss">
	#page-header {
		border-bottom: 1px solid var(--default-border-color);
		flex-shrink: 0;
		z-index: 1;
		background-color: var(--header-background-color);
		box-shadow: 0px -2px 6px black;
	}
	#page-main {
		display: flex;
		flex-direction: column;
		flex: 1 0 auto;
	}
	#page-footer {
		height: 3rem;
		border-top: 1px solid var(--default-border-color);
		flex-shrink: 0;
		display: flex;
		align-items: center;
		justify-content: center;
		background-color: var(--footer-background-color);
		box-shadow: 0px 2px 6px black;
		p {
			text-align: center;
		}
	}
</style>
