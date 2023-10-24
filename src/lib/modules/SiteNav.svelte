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

<style lang="scss">
	nav {
		height: 100%;
		ul {
			margin: 0;
			padding: 0;
			padding-right: 1rem;
			height: 100%;
			display: flex;
			gap: 0.5rem;
			flex-direction: row;
			justify-content: right;
			align-items: center;
			list-style-type: none;
			li {
				display: contents;
				a {
					font-family: 'Trebuchet MS', sans-serif;
					padding: 0 0.4rem;
					height: 60%;
					display: flex;
					align-items: center;
					font-size: larger;
					font-weight: bold;
					text-decoration: none;
					&:hover {
						color: lightgray;
					}
					&:active {
						color: gray;
					}
					&:visited {
						color: var(--default-text-color);
					}
				}
			}
		}
	}
</style>
