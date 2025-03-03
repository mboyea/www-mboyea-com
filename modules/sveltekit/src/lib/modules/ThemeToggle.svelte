<script lang="ts">
  import { onMount } from "svelte";
  import userTheme from "$lib/stores/UserTheme";
  import type { Theme } from "$lib/types/Theme";
  let checkbox: HTMLInputElement | undefined = undefined;
  onMount(() => {
    // get systemTheme, update toggle switch to match
    const systemTheme = window.matchMedia('(prefers-color-scheme: light)');
    checkbox!.checked = systemTheme.matches;
    // when systemTheme modified, update toggle switch to match & activate system userTheme
    const systemThemeChangeCallback = (e: MediaQueryListEvent) => {
      checkbox!.checked = e.matches;
      userTheme.set('system');
    }
    systemTheme.addEventListener('change', systemThemeChangeCallback)
    // when 'Enter' or 'Space' pressed targeting toggle switch, simulate a click on it instead
    checkbox?.addEventListener('keydown', (e: KeyboardEvent) => {
      switch (e.key) {
        case 'Enter': {
          e.preventDefault();
          checkbox?.click();
          break;
        }
        case 'Space': {
          e.preventDefault();
          checkbox?.click();
          break;
        }
      }
    });
    // when toggle switch clicked, update userTheme to match
    checkbox?.addEventListener('click', (e: MouseEvent) => {
      if (checkbox!.checked) {
        userTheme.set('light');
      } else {
        userTheme.set('dark');
      }
    })
    // when userTheme modified, update toggle switch to match
    const themeUnsubscribe = userTheme.subscribe((value: Theme) => {
      if (value === 'system') {
        return;
      }
      checkbox!.checked = (value === 'light');
    })
    // onDestroy
    return () => {
      themeUnsubscribe();
      systemTheme.removeEventListener('change', systemThemeChangeCallback);
    }
  });
</script>
<label class="switch require-script">
  💡
  <input bind:this={checkbox} type="checkbox" role="menuitemcheckbox" aria-checked="false" aria-label="Toggle Light Mode">
  <span class="slider"></span>
</label>

<style>
  @media (scripting: none) or (scripting: initial-only) {
    .require-script {
      display: none !important;
    }
  }
  .switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 34px;
    input {
      opacity: 0;
      width: 0;
      height: 0;
    }
    .slider {
      position: absolute;
      cursor: pointer;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      border-radius: 34px;
      background-color: #cccccc;
      &:before {
        position: absolute;
        content: "";
        height: 26px;
        width: 26px;
        left: 4px;
        bottom: 4px;
        border-radius: 50%;
        background-color: white;
      }
    }
    input {
      &:checked + .slider {
        background-color: #2196F3;
      }
      &:focus + .slider {
        box-shadow: 0 0 1px #2196F3;
      }
      &:checked + .slider:before {
        transform: translateX(26px);
      }
    }
  }
</style>
