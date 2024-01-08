<nav aria-label="Website Navigation">
	<a href="/" class="brand-logo" aria-label="Website Home" role="menuitem">&lt;/mboyea&gt;</a>
	<div class="site-nav" aria-label="Website Pages" role="menubar">
		<button id="site-nav-dropdown-button" type="button" aria-expanded="false" aria-controls="site-nav-menu">☰</button>
		<ul id="site-nav-menu">
			<li><a href="/articles" role="menuitem">Articles</a></li>
			<li><a href="/apps" role="menuitem">Apps</a></li>
			<li><a href="/games" role="menuitem">Games</a></li>
			<li><a href="/portfolio" role="menuitem">Portfolio</a></li>
			<li><a href="/support" role="menuitem">Support</a></li>
		</ul>
	</div>
</nav>

<style lang="scss">
	nav {
		height: 4rem;
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		align-items: center;
		background-color: var(--header-background-color);
		.brand-logo {
			height: 100%;
			padding-left: 1rem;
			display: flex;
			flex-direction: row;
			align-items: center;
			color: var(--brand-color);
			font-family: var(--brand-font);
			font-weight: bold;
			font-size: 2rem;
			text-decoration: none;
			&:hover {
				color: var(--brand-color-dark);
			}
			&:active {
				color: var(--brand-color);
			}
		}
		.site-nav {
			#site-nav-dropdown-button {
				padding: 0 1rem 0.35rem 1rem;
				border: none;
				background-color: transparent;
				font-family: var(--title-font);
				font-size: 2.5rem;
				&:hover {
					color: var(--brand-color);
				}
			}
			#site-nav-menu {
				visibility: hidden;
				width: 100%;
				margin: 0;
				padding: 0;
				padding-bottom: 0.8rem;
				position: absolute;
				right: 0;
				z-index: -1;
				transform: translateY(-100%);
				display: flex;
				flex-direction: column;
				background-color: var(--header-background-color);
				text-align: right;
				transition: transform 280ms ease-out;
				li {
					display: contents;
					a {
						padding: 0.3rem 0;
						padding-right: 0.6rem;
						font-size: 1.5rem;
						font-weight: bold;
						text-decoration: none;
						font-family: var(--title-font);
						&:visited {
							color: var(--default-text-color);
						}
						&:hover, &:focus {
							color: var(--brand-color);
						}
						&:active {
							color: var(--brand-color-dark);
						}
					}
				}
			}
			&:focus-within {
				#site-nav-dropdown-button {
					color: var(--brand-color);
				}
				#site-nav-menu {
					border-bottom: 1px solid var(--default-border-color);
					visibility: visible;
					transform: translateY(0);
				}
			}
		}
	}
	@media screen and (min-width: 740px) {
		nav {
			.site-nav {
				height: 100%;
				#site-nav-dropdown-button {
					display: none;
				}
				#site-nav-menu {
					height: 100%;
					visibility: visible;
					padding: 0;
					padding-right: 1rem;
					display: flex;
					flex-direction: row;
					gap: 0.5rem;
					position: static;
					z-index: 0;
					transform: translateY(0);
					li {
						a {
							height: 100%;
							padding: 0 0.4rem;
							display: flex;
							align-items: center;
						}
					}
				}
			}
		}
	}
</style>
