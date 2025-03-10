---
title: www-mboyea-com
author: [ Matthew T. C. Boyea ]
lang: en
subject: website
keywords: [ nix, docker, podman, image, postgres, svelte, sveltekit, typescript, sass, website, fly, fly.io, server ]
default_: readme
---

[🌐 www.mboyea.com](https://www.mboyea.com)

## A portfolio website for Matthew Boyea

This website prioritizes *speed*, *clarity*, and *attractiveness*.
It's supposed to make clients, recruiters, and engineers think "I want to hire this guy to do *my* website."
Questions? [Read the FAQ](#faq).

### Installation

First, copy the repository.

- [Clone this repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) from [GitHub](https://github.com/mboyea/www-mboyea-com).

Because [Nix (the package manager)] provides all packages, it is the only dependency required to be installed manually.

- [Install Nix: the package manager](https://nixos.org/download/).
- [Enable Nix flakes](https://nixos.wiki/wiki/Flakes).

From here, you can run any of the project [Scripts](#scripts).

However, you won't have access to the project packages (`npm`, `psql`, `podman`, `flyctl`, etc.) in your PATH by default.
You probably want those for testing and usage while debugging.
You can run `nix develop` to open a subshell with these dependencies.

This works fine, but it's nice to automatically have the software dependencies when you enter into the project directory.
To do that, we install [direnv](https://direnv.net/).

- [Install direnv](https://direnv.net/docs/installation.html).
- [Install nix-direnv](https://github.com/nix-community/nix-direnv#installation) (optional).
- Open a terminal in the project's root directory.
- Run `direnv allow`

Now you don't have to type `nix develop`; all the packages are automatically provided when your shell enters into the project directory.

### Usage

Be sure to [read the license](./LICENSE.md).

#### Scripts

Scripts can be run from within any of the project directories.

| Command | Description |
|:--- |:--- |
| `nix run` | Alias for `nix run .#start dev` |
| `nix run .#[SCRIPT] ...` | Run a script |
| `nix run .#[SCRIPT] help` | Print usage information about a script |
| `nix develop` | Start a subshell with the software dependencies installed |

| SCRIPT | Description |
|:--- |:--- |
| `help` | Print this helpful information |
| `start` | Start the app locally |
| `deploy` | Deploy the app to Fly.io |

**Note:** Currently you cannot run scripts that use `podman` to create a container while offline. For more information, see [github.com/containers/podman/issues/23566](https://github.com/containers/podman/issues/23566).

#### Deployment (Fly.io)

You'll need to be signed into a [Fly.io] account to deploy.

- [Make a Fly.io account](https://fly.io/dashboard).
  Link your payment method in the account.
- Run `flyctl auth login`

Secret deployment credentials will be stored in the file `.env`.
The contents of this file can never be revealed publicly, so be careful to only share its contents with other developers.

- Create a file named `.env` in the root directory.
- Add to `.env`:
  ```sh
  FLY_APP_NAME="<unique_app_name>"
  FLY_DB_NAME="<unique_app_name>"
  POSTGRES_PASSWORD="<unique_password>"
  POSTGRES_WEBSERVER_PASSWORD="<unique_password>"
  ```
- Run `nix run .#deploy all`

The application will perform its first deployment.
It may hang while deploying the webserver for the first time, but this is just a byproduct of waiting for Fly to initialize the application.
With patience, your server should deploy and you can visit the app online!

You can re-deploy after making changes to the database, server, or secrets with the same `.#deploy` command.

- `nix run .#deploy all`
- `nix run .#deploy secrets`
- `nix run .#deploy database webserver`

**If you ever modify the design of an existing database table, you must manually convert the old table before redeploying.**
It is recommended that you first test the conversion process on a fake database using `nix run .#start prod` and `psql -h localhost -U postgres`.

- Run `flyctl postgres connect --user postgres --password <unique_password>`
- Modify the old table using [ALTER TABLE](https://www.postgresql.org/docs/current/sql-altertable.html).

After initial deployment, you can use [flyctl](https://fly.io/docs/flyctl/) to manage your deployed servers.
Or visit [fly.io/dashboard](https://fly.io/dashboard).

## FAQ

### How does it work?

[Nix (the package manager)] uses [declarative scripting](https://en.wikipedia.org/wiki/Declarative_programming) to:

- Install and lock required dependencies reproducibly.
- Compile source code into production packages.
- Containerize production packages into [Docker] images.
- Expose the required packages, images, and dependencies to shell scripts that test and deploy the packages.
- Expose the environment and scripts to the developer.

Source code for the web server is in `modules/sveltekit/`.
[SvelteKit] is used to build a [Node.js] server, making use of [Sass] for superior CSS features and [TypeScript] for type security in both the front-end and back-end of the server.
Nix packages a Docker image with this webserver inside.

Source code for the database is in `modules/postgres/`.
[Postgres] is used to provide a SQL database that best supports concurrency at scale.

Source code for deployment is in `modules/fly/`.
[Fly.io] is used as a hosting provider for the webserver Docker image and the Postgres database.
Fly natively supports concurrent Postgres instances, and provides some [convenient CLI tools](https://fly.io/docs/flyctl/postgres/) for database management.
It also allows the webserver to connect to the database over an internal network, so the Postgres database doesn't have to be exposed to the internet.
These features make Fly an ideal hosting provider for performance and security.
If I ever decided that Fly was an inferior hosting option, it would be no problem to migrate from their service to another, because you can run Docker containers pretty much anywhere.
Hooray for avoiding [vendor lock-in](https://en.wikipedia.org/wiki/Vendor_lock-in)!

Scripts are defined in `scripts/` and their dependencies are declared in `flake.nix`.
Scripts are used to run development environments and deploy the application.
Because scripts consume packages provided by `flake.nix`, if you want to run them directly (like `./scripts/start.sh dev`) you must use `nix develop` or `direnv allow`.

### How to contribute?

Unfortunately, this project doesn't support code contributions from the community right now.
However, you are free to [post Issues](https://github.com/mboyea/www-mboyea-com/issues) in this repository.

I am not currently receiving donations.
There is no way to fund my projects at this time, but if enough interest is generated, a process for donations will be provided.

Feel free to fork, just be sure to [read the license](./LICENSE.md).

[Nix (the package manager)]: https://nixos.org/
[Docker]: https://docs.docker.com/get-started/overview/
[SvelteKit]: https://kit.svelte.dev/docs/introduction
[Node.js]: https://nodejs.org/en/docs/guides/getting-started-guide
[Vue]: https://vuejs.org/
[Angular]: https://angularjs.org/
[Sass]: https://sass-lang.com/guide
[Typescript]: https://www.typescriptlang.org/why-create-typescript
[Postgres]: https://www.postgresql.org/
[Fly.io]: https://fly.io/docs/
