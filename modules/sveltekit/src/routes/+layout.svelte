<script lang="ts">
  import './+layout.scss';
  import TheNav from '$lib/modules/TheNav.svelte';
  import TheNavSkipButton from '$lib/modules/TheNavSkipButton.svelte';
  import MailIcon from '~icons/mingcute/mail-line';
  import GitHubIcon from '~icons/mingcute/github-line';
  import PhoneIcon from '~icons/mingcute/phone-line';
  import LinkedInIcon from '~icons/mingcute/linkedin-line';
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
    <span class="no-break">
      Built with
      <span role="img" aria-label="love">❤</span>
      using
      <a href="https://svelte.dev/docs/kit/introduction">SvelteKit</a>
      |
    </span>
    <span class="no-break">
      View source code on
      <a href="https://github.com/mboyea/www-mboyea-com">GitHub</a>
    </span>
  </p>
  <p>
    <span class="no-break">
      © {currentYear} Matthew Terrance Carlos Boyea
      |
    </span>
    <span class="no-break">
      <a href="mailto:contact@mboyea.com">
        <MailIcon class="icon" />
      </a>
      |
      <a href="tel:9132032484">
        <PhoneIcon class="icon" />
      </a>
      |
      <a href="https://www.linkedin.com/in/mboyea">
        <LinkedInIcon class="icon" />
      </a>
      |
      <a href="https://github.com/mboyea">
        <GitHubIcon class="icon" />
      </a>
    </span>
  </p>
</footer>

<style lang="scss">
  :global(html, body) {
    height: max(100%, 100vh);
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
    background-color: var(--color-dark-dark);
  }
  #page-main {
    flex: 1 0;
    display: flex;
    flex-direction: column;
    &:focus {
      outline: none;
    }
  }
  #page-footer {
    flex: 0 0;
    z-index: 1;
    text-align: center;
    background-color: var(--color-dark-dark);
    border-top: 1px var(--color-bg-alt) solid;
  }
</style>
