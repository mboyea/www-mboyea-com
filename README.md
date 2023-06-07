www.mboyea.com
===
A portfolio website built to host articles, games, and tools built by Matthew Boyea
---
This website is built with [SvelteKit] to create a html/css/js application delivered by a [Node.js] server. [Docker] is used to deploy the app within a minified [Ubuntu] environment. [pnpm] manages all dependent packages. The Docker container is currently hosted by [Fly.io] for the completed website.

### Develop
* [Install pnpm].
* Fork this repository.
* Clone this repository to your computer.
* Open a terminal in the root directory of the cloned repository.
* Run `pnpm i` in the terminal to install all dependencies.

From here, you're ready to devlelop your project. You can run the following scripts in the terminal to work locally with the project.

### Scripts
To run a script, type `pnpm run <script-name>` into the terminal within the root folder.

| script-name | description |
|:----------- |:----------- |
| `dev` | create a local hot-reloading server at [localhost:5173](http://localhost:5173) for development purposes |
| `build` | compile a production version of the app into the build folder |
| `preview` | create a local server which serves the contents of the build folder |
| `check` | get evaluation of project syntax from sveltekit |
| `check:watch` | run `check` and provide updates when files are saved |

To edit commands, see "scripts" in package.json

### Deploy
To deploy this app, create a Docker Image from the Dockerfile and deploy it to your hosting provider of choice.

This app is set up to use [Fly.io] to create the Docker Image and deploy the Container to the cloud. To deploy with [Fly.io], first make sure to [install flyctl]. Then run `flyctl deploy`. If there is no existing app to deploy to, instead run `flyctl launch` and follow the instructions.

### Contribute
Unfortunately, this project doesn't support community contributions right now.

[SvelteKit]: https://kit.svelte.dev/docs/introduction
[Node.js]: https://nodejs.org/en/docs/guides/getting-started-guide
[Docker]: https://docs.docker.com/get-started/overview/
[Ubuntu]: https://ubuntu.com/about
[pnpm]: https://pnpm.io/motivation
[Fly.io]: https://fly.io/docs/
[Install pnpm]: https://pnpm.io/installation
[install flyctl]: https://fly.io/docs/hands-on/install-flyctl/
