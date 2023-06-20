<script lang="ts">
	let currentYear: number = new Date().getFullYear();
</script>

<style lang="scss"></style>

<header id="page-header">
	<nav>
		<ul>
			<li><a href="/">Home</a></li>
			<li><a href="/articles">Articles</a></li>
			<li><a href="/apps">Apps</a></li>
			<li><a href="/games">Games</a></li>
			<li><a href="/portfolio">Portfolio</a></li>
			<li><a href="/support">Support</a></li>
		</ul>
	</nav>
</header>

<div id="page-container">
	<slot />
</div>

<footer id="page-footer">
	<p>Copyright © {currentYear} Matthew Boyea</p>
</footer>