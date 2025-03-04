<script lang="ts">
  import ThemeToggle from "$lib/modules/ThemeToggle.svelte"
</script>

<div id="site-menu" aria-label="Navigation Menu" role="menubar">
  <a href="/" class="home" role="menuitem" aria-label="Home Page">
    &lt;/mboyea&gt;
  </a>
  <nav class="site-menu-dropdown">
    <button class="site-menu-dropdown-button" type="button" aria-expanded="true" aria-controls="site-menu-dropdown-list">☰</button>
    <ul class="site-menu-dropdown-list">
      <li><a href="/projects" class="page" role="menuitem" aria-label="Projects Page">Projects</a></li>
      <li><a href="/about" class="page" role="menuitem" aria-label="About Page">About</a></li>
      <li><a href="/contact" class="page" role="menuitem" aria-label="Contact Page">Contact</a></li>
      <li class="theme-toggle"><ThemeToggle /></li>
    </ul>
  </nav>
</div>

<style lang="scss">
  #site-menu {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    background-color: var(--color-bg);
    a {
      font-size: 1.6rem;
      text-decoration: none;
      &.page {
        width: 100%;
      }
      &.home {
        padding: 0 0.2em 0 0.2em;
        font-family: var(--brand-font);
        font-size: 2rem;
        font-weight: bold;
      }
    }
    .site-menu-dropdown {
      .site-menu-dropdown-button {
        padding: 0 0.2em 0 0.2em;
        font-size: 2rem;
        font-weight: bold;
        border: none;
        background-color: transparent;
      }
      .site-menu-dropdown-list {
        position: absolute;
        right: 0;
        transform: translateY(-100%);
        transition: transform 300ms ease-out;
        width: 100%;
        padding: 0;
        margin: 0;
        visibility: hidden;
        // expects parent to be a higher z-index than the website body
        z-index: -1;
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        list-style-type: none;
        text-align: right;
        background-color: var(--color-bg);
        border-bottom: 1px var(--color-bg-alt) solid;
        li {
          display: contents;
        }
      }
      &:focus-within, &:hover {
        .site-menu-dropdown-button {
          color: var(--color-blue);
          &:focus {
            outline-width: 0;
            color: var(--color-blue-alt);
          }
        }
        .site-menu-dropdown-list {
          visibility: visible;
          transform: translateY(0);
        }
      }
    }
  }
</style>
