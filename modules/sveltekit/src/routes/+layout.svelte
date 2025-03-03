<script lang="ts">
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
  <p>Built with 🧡 using SvelteKit | View source at <a href="https://github.com/mboyea/www-mboyea-com">GitHub</a></p>
  <p>© {currentYear} Matthew Terrance Carlos Boyea</p>
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
  }
  #page-main {
    flex: 1 0;
  }
  #page-footer {
    flex: 0 0;
  }
</style>
