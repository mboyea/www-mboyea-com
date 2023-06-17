<script lang="ts">
	let currentYear: number = new Date().getFullYear();
</script>

<style lang="scss"></style>

<header id="header">
	<nav>
		<ul>
			<li><a href="/">Home</a></li>
			<li><a href="/articles">Articles</a></li>
			<li><a href="/games">Games</a></li>
			<li><a href="/tools">Tools</a></li>
			<li><a href="/about">About</a></li>
			<li><a href="/support">Support</a></li>
		</ul>
	</nav>
</header>

<div id="page">
	<slot />
</div>

<footer id="footer">
	<p>Copyright © {currentYear} Matthew Boyea</p>
</footer>