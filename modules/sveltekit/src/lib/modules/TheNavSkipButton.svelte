<script lang="ts">
  let {
    targetId = 'page-main',
  } = $props();
  const focusId = () => {
    const element = document.getElementById(targetId);
    element?.focus();
    element?.scrollIntoView({
      behavior: 'smooth',
      block: 'start',
    });
  }
</script>

<button class="skip-to-content require-script" onclick={focusId}>Skip to Main Content</button>

<noscript>
  <a href="#{targetId}">
    <button class="skip-to-content">Skip to Main Content</button>
  </a>
</noscript>

<style lang="scss">
  button.skip-to-content {
    position: absolute;
    transform: translateY(-100%) translateX(-2px);
    border-radius: 0 0 0.5rem 0;
    transition: transform 0.3s;
    &:focus {
      transform: translateY(-2px) translateX(-2px);
    }
  }
  @media (scripting: none) or (scripting: initial-only) {
    .require-script {
      display: none !important;
    }
  }
</style>
