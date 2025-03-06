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
      <li><a href="/" class="page" role="menuitem" aria-label="Home Page">Home</a></li>
      <li><a href="/contact" class="page" role="menuitem" aria-label="Contact Page">Contact</a></li>
      <li><!--<ThemeToggle />--></li>
    </ul>
  </nav>
</div>

<style lang="scss">
  #site-menu {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: stretch;
    background-color: inherit;
    a {
      padding: 1rem;
      font-size: 1.6rem;
      font-weight: bold;
      text-decoration: none;
      &.page {
        width: 100%;
        color: var(--color-fg);
      }
      &.home {
        padding: 1rem;
        font-family: var(--brand-font);
        font-size: 2rem;
        font-weight: bold;
        color: var(--color-green);
      }
      &:hover {
        color: var(--color-green);
      }
      &:focus {
        background-color: var(--color-bg-alt);
        color: var(--color-green-alt);
      }
    }
    .site-menu-dropdown {
      .site-menu-dropdown-button {
        padding: 1rem;
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
        background-color: var(--color-bg-dark);
        border-bottom: 1px var(--color-bg-alt) solid;
        li {
          display: contents;
        }
      }
      &:focus-within, &:hover {
        .site-menu-dropdown-button {
          color: var(--color-green);
          &:focus {
            outline-width: 0;
            background-color: var(--color-bg-alt);
            color: var(--color-green-alt);
          }
        }
        .site-menu-dropdown-list {
          visibility: visible;
          transform: translateY(0);
        }
      }
    }
  }
  @media screen and (min-width: 700px) {
    #site-menu {
      .site-menu-dropdown {
        .site-menu-dropdown-button {
          display: none;
        }
        .site-menu-dropdown-list {
          height: 100%;
          visibility: visible;
          display: flex;
          position: static;
          flex-direction: row;
          align-items: center;
          transform: translateY(0);
          border: none;
        }
      }
    }
  }
</style>
