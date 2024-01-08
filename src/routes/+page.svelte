<h1 id="featured-img">I'm Matthew Boyea.</h1>
<section class="centered">
	<h2>Engineer. Athlete. Scholar.</h2>
	<p>I seek to provide value for my communities, my family, and my self.</p>
	<p>In that effort, I study all manner of philosophies, systems, and experiences.</p>
	<p>This is my website. I hope it is helpful to you.</p>
</section>
<section class="banner">
	<ul>
		<li><a href="/games">Play my games!</a></li>
		<li><a href="/apps">Try my apps!</a></li>
		<li><a href="/articles">Read my writing!</a></li>
	</ul>
</section>
<section class="centered">
	<p>If you would like to donate to me, <a href="/support">see my support page.</a></p>
</section>

<style lang="scss">
	h2 {
		font-family: var(--brand-font);
	}
	#featured-img {
		margin: 0;
		padding: 12vw 0 18vw 0;
		border-bottom: 1px solid var(--default-border-color);
		text-shadow: 3px 3px 5px black;
		font-size: max(4vw, 2rem);
		&:before {
			background-image: url('$imgs/homepage-background.jpg');
		}
	}
	.centered {
		padding: 0 2rem;
		text-align: center;
	}
	.banner {
		padding: 0.5rem 2rem;
		border-top: 1px solid var(--default-border-color);
		border-bottom: 1px solid var(--default-border-color);
		background-color: var(--content-background-color);
		ul {
			margin: 0;
			padding: 0;
			display: flex;
			justify-content: center;
			flex-direction: row;
			list-style-type: none;
			gap: 3rem;
			li {
				display: contents;
				a {
					padding: 0.5rem 0;
					font-family: var(--brand-font);
					font-size: 1.25rem;
					font-weight: bold;
					text-decoration: none;
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
	}
	@media screen and (max-width: 650px) {
		.banner {
			ul {
				flex-direction: column;
				gap: 0.8rem;
				li {
					a {
						text-align: center;
						font-size: 1.5rem;
					}
				}
			}
		}
	}
</style>
