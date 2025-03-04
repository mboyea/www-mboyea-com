<script lang="ts">
  import { onMount } from 'svelte';
  import './+layout.scss'
  import TheNav from '$lib/modules/TheNav.svelte';
  import TheNavSkipButton from '$lib/modules/TheNavSkipButton.svelte';
  let currentYear: number = new Date().getFullYear();
</script>

<header id="page-header">
  <TheNavSkipButton targetId="page-main" />
  <TheNav />
</header>

<div id="page-main" tabindex="-1">
  <slot />
</div>

<footer id="page-footer">
  <p>
    Built with
    <span role="img" aria-label="love">❤</span>
    using
    <a href="https://svelte.dev/docs/kit/introduction">SvelteKit</a>
    | View source code on
    <a href="https://github.com/mboyea/www-mboyea-com">GitHub</a>
  </p>
  <p>
    © {currentYear} Matthew Terrance Carlos Boyea
    |
    Email
    |
    Phone
    |
    LinkedIn
  </p>
</footer>

<style lang="scss">
  :global(html, body) {
    height: 100%;
  }
  :global(body) {
    display: flex;
    flex-direction: column;
    margin: 0;
  }
  #page-header {
    flex: 0 0;
    z-index: 1;
    border-bottom: 1px var(--color-bg-alt) solid;
  }
  #page-main {
    flex: 1 0;
    &:focus {
      outline: none;
    }
  }
  #page-footer {
    flex: 0 0;
    z-index: 1;
    text-align: center;
    border-top: 1px var(--color-bg-alt) solid;
  }
</style>
