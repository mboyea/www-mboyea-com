<script lang="ts">
  import MailIcon from '~icons/mingcute/mail-line';
  import GitHubIcon from '~icons/mingcute/github-line';
  import PhoneIcon from '~icons/mingcute/phone-line';
  import LinkedInIcon from '~icons/mingcute/linkedin-line';
</script>

<section>
  <h1 class="centered">Contact Me.</h1>
  <ul>
    <li>
      <a href="mailto:contact@mboyea.com">
        <MailIcon class="icon" />
        contact@mboyea.com
      </a>
    </li>
    <li>
      <a href="tel:9132032484">
        <PhoneIcon class="icon" />
        (913) 203-2484
      </a>
    </li>
    <li>
      <a href="https://www.linkedin.com/in/mboyea">
        <LinkedInIcon class="icon" />
        linkedin.com/in/mboyea
      </a>
    </li>
    <li>
      <a href="https://github.com/mboyea">
        <GitHubIcon class="icon" />
        github.com/mboyea
      </a>
    </li>
  </ul>
</section>

<style lang="scss">
  section {
    width: min(100%, 54rem);
    margin: 0 auto;
    ul {
      li {
        list-style: none;
      }
    }
  }
</style>
