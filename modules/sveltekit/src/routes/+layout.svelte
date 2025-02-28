<script lang="ts">
  import './+layout.scss'
  let currentYear: number = new Date().getFullYear();
</script>

<header id="page-header">
  <p>Insert header here.</p>
</header>

<div id="page-main">
  <slot />
</div>

<footer id="page-footer">
  <p>Built with 🧡 using SvelteKit | View source in <a href="https://github.com/mboyea/www-mboyea-com">GitHub</a></p>
  <p>© {currentYear} Matthew Terrance Carlos Boyea</p>
</footer>

<style lang="scss">
  :global(html, body) {
    height: 100%;
  }
  :global(body) {
    display: flex;
    flex-direction: column;
    margin-top: 0;
    margin-bottom: 0;
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
