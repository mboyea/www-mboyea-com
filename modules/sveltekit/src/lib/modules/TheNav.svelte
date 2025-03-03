<script lang="ts">
  import LogoIcon from "$lib/modules/LogoIcon.svelte"
  import ThemeToggle from "$lib/modules/ThemeToggle.svelte"
</script>

<div id="site-menu" aria-label="Navigation Menu" role="menubar">
  <a href="/" role="menuitem" aria-label="Home Page"><LogoIcon/></a>
  <nav class="site-menu-dropdown">
    <button class="site-menu-dropdown-button" type="button" aria-expanded="true" aria-controls="site-menu-dropdown-list">☰</button>
    <ul class="site-menu-dropdown-list">
      <li><a href="/projects" role="menuitem" aria-label="Projects Page">Projects</a></li>
      <li><a href="/about" role="menuitem" aria-label="About Page">About</a></li>
      <li><a href="/contact" role="menuitem" aria-label="Contact Page">Contact</a></li>
      <li><ThemeToggle /></li>
    </ul>
  </nav>
</div>

<style lang="scss">
  #site-menu {
    .site-menu-dropdown {
      .site-menu-dropdown-list {
        visibility: hidden;
      }
      &:focus-within, &:hover {
        .site-menu-dropdown-list {
          // TODO: fix mouse click action on ThemeToggle
          visibility: visible;
        }
      }
    }
  }
</style>
