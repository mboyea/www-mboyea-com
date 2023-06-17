www.mboyea.com
===
A portfolio website to host articles, games, and tools built by Matthew Boyea.
---
This website is built with [SvelteKit], [Typescript], & [Sass] to compile a html/css/js application delivered by a [Node.js] server. [Docker] is used to deploy the app within a minified [Ubuntu] environment. [PNPM] manages all dependent packages. [Fly.io] hosts the Docker deployment to serve the completed website.

### Develop
* [Install PNPM].
* Fork this repository.
* Clone this repository to your computer.
* Open a terminal in the root directory of the cloned repository.
* Run `pnpm i` in the terminal to install all dependencies.

From here, you're ready to develop the project. You can run the following scripts in the terminal to work locally with the project.

### Scripts
To run a script, type `pnpm run <script-name>` into a terminal within the root folder.

| script-name | description |
|:----------- |:----------- |
| `dev` | create a local hot-reloading server at [localhost:5173](http://localhost:5173) for development purposes |
| `build` | compile a production version of the app into the build folder |
| `preview` | create a local server which serves the contents of the build folder at [localhost:5173](http://localhost:4173) |
| `check` | evaluate Svelte syntax |
| `check:watch` | re-evaluate Svelte syntax when files are updated |

### Deploy
This app is set up to use [Fly.io] to deploy a Docker container. To deploy with Fly:
* [Install flyctl].
* Run `flyctl deploy`.
* If there is no existing app to deploy to, instead run `flyctl launch`.

### Contribute
Unfortunately, this project doesn't support community contributions right now.

[SvelteKit]: https://kit.svelte.dev/docs/introduction
[Node.js]: https://nodejs.org/en/docs/guides/getting-started-guide
[Docker]: https://docs.docker.com/get-started/overview/
[Ubuntu]: https://ubuntu.com/about
[PNPM]: https://pnpm.io/motivation
[Install PNPM]: https://pnpm.io/installation
[Fly.io]: https://fly.io/docs/
[Install flyctl]: https://fly.io/docs/hands-on/install-flyctl/
