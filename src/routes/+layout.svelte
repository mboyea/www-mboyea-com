<script lang="ts">
	import './+layout.scss'
	import SiteNav from '$modules/SiteNav.svelte'

	let currentYear: number = new Date().getFullYear();
</script>

<header id="page-header">
	<div class="brand-logo">
		<a href="/">mboyea</a>
	</div>
	<SiteNav/>
</header>

<div id="page-main">
	<slot />
</div>

<footer id="page-footer">
	<p>Copyright © {currentYear} Matthew Boyea</p>
</footer>

<style lang="scss">
	.brand-logo {
		height: 100%;
		padding-left: 1rem;
		display: flex;
		flex-direction: row;
		align-items: center;
		a {
			display: flex;
			align-items: center;
			font-size: xx-large;
			height: 80%;
			color: var(--brand-color);
			font-family: var(--brand-font);
			font-weight: bold;
			text-decoration: none;
		}
	}
	#page-header {
		height: 4rem;
		flex-shrink: 0;
		display: flex;
		flex-direction: right;
		justify-content: space-between;
		background-color: var(--header-background-color);
		box-shadow: 0px -2px 6px black;
	}
	#page-main {
		flex: 1 0 auto;
	}
	#page-footer {
		height: 3rem;
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
