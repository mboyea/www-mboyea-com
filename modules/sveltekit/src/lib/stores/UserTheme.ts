import { writable } from "svelte/store"
import { browser } from "$app/environment";
import type { Theme } from "$lib/types/Theme"

// get initial userTheme from localStorage
const defaultUserTheme: Theme = 'system'
// ! const initialUserTheme: Theme = browser ? window.localStorage.getItem('userTheme') as Theme ?? defaultUserTheme : defaultUserTheme;
const initialUserTheme: Theme = defaultUserTheme;
// create userTheme store
const userThemeStore = writable<Theme>(initialUserTheme);
export default userThemeStore;
// when store is modified, save userTheme to localStorage
userThemeStore.subscribe((value: Theme) => {
  if (browser) {
    // ? updating the theme from localStorage using JavaScript causes the page to flicker the system theme on every page load, so it's best to not enable persistent themes
    // ! window.localStorage.setItem('userTheme', value);
    // expects css to consume theme with selectors [data-theme="dark"] and [data-theme="light"]
    document.documentElement.setAttribute('data-theme', value);
  }
})
