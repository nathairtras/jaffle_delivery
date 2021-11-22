## Using this repo
This repo is meant as a "shortcut" to getting developers playing with DBT locally.
It is meant to provide a sandbox for [jaffle_shop](https://github.com/dbt-labs/jaffle_shop).
This repo is provided as a submodule for convenience, all licensing for that material depends on the included license.

Additionally, this repo offers a set of scripts and configurations for making development against DBT projects using Docker easier.
It can be used as a model for configuring new projects, with the core requirement being a `.envrc` file configured correctly in the project repo.
Assuming a developer has followed this walkthrough, the `.envrc` file (in addition to a valid `profiles.yml` and credentials) is all that is necessary for running a DBT project.

This should probably have a license, but there's nothing really here beyond some very basic docker-compose, so do with _this_ code as you see fit.
The more people using DBT, the better it gets, and there is nothing in here that others have not thought of.

The readme for `jaffle_shop` should be followed.
The only necessary changes are to run the `start-backend` and `stop-backend` scripts as needed to get Postgres running as a local backend.

## Requirements
### Docker
Make sure that Docker is installed, and configured to have read access to common DBT directories:
* `$HOME/.dbt` for DBT `profiles.yml`
* `$HOME/.snowflake` if you are using private key auth for Snowflake (Not for this project)
* This directory for the `jaffle_shop` project

If you do not use Docker Desktop, this may require manual configuration to get the Docker host seeing these paths for volume mounts.

### direnv
direnv is used to load environment files when you enter a directory.
This can be used to store project-specific information, such as the path to the DBT project, or the DBT version the project is running on.
These are then used by the DBT wrapper script in `scripts/dbt` to configure your docker container.

To get started, make sure `direnv` is installed.  You can do this with:
```
brew install direnv
```

This will have important information about how to configure your shell.  For ZSH, you would add this to the end of your `.zshrc`:
```
eval "$(direnv hook zsh)"
```
Once it is installed, you will need to allow the file in this directory to be used.  From the root of the directory, run:
```
direnv allow .
```

Have a look at the example file in this directory to understand usage.
It can be used to:
* Configure the project directory using `$PWD` as all or part of the project path
* Override the default `profiles.yml`
* Set a DBT target to be passed to `--target` in the DBT command
* Set the Docker organisation, image, and version name for the DBT image
* Set the architecture for the DBT image (not yet supported)
* Determine a Docker network needed for connecting

Keep in mind that these files are *shared*, so decisions like alternate profile file path should not be taken lightly.
Creating a standard approach for an entire development team is critical.
One option would be to use a profile file for each project, and have it named accordingly.
This would mean that all users would have a file at `$HOME/.dbt/{project_name}.yml`.

Note that if you are using a Docker container for your backend in a *different* project, you will need to follow the example here.
* Use the provided Bash scripting to identify the network name in `.envrc`
* Run `direnv reload` at the end of the scripts for starting and stopping your backend
  * This will push the newly created network to the environment
  * It will also *remove* the network from the environment when the backend has gone away

**No secrets should be stored in `.envrc`!**
It is stored in GitHub, and is strictly for configuration, *not* secrets!

### DBT wrapper script
A wrapper script written in bash is used to run DBT through Docker.
It can be installed by running `wrapper/install.sh` and following the instructions.

Once this script is installed, you can invoke DBT as if it were installed directly on the machine.
The first time you execute `dbt` with a given version number, that image will be pulled locally.

### Changes to Jaffle Shop
Keep in mind that the `jaffle_shop` subfolder _is a git repo!_  Do not make commits to it, do not push from it, just use it as a reference.
You can purge your changes by resetting the file state to get a clean slate.

If you want to preserve your sandbox, consider:
* Forking this repo
* Forking jaffle shop
* Updating your fork of this repo to use the Jaffle Shop fork you created in step two

This may be a terrible approach, but it avoids storing the entire jaffle shop repo in this repo.
The real purpose of this repo is to make `jaffle_shop` faster to use, _not_ to change it.

Alternatively, if you would rather not deal with submodules:
* Remove the submodule
* Add `jaffle_shop` to the git ignore
* Clone your project into `jaffle_shop`

_It may be worth making this more generic in the future?  Change `jaffle_shop` to `dbt_project`?_

## Walkthrough Commands
### Start the Docker Postgres backend in the background
`./start-backend`

### Check that DBT works
`dbt debug`

### Create the DBT seeds
`dbt seed`

### Run the DBT models
`dbt run`

### Run the DBT tests
`dbt test`

### Run the DBT doc generation
`dbt docs generate`

### Serve the docs
`dbt docs serve`

While this is running, visit [localhost:8080](http://localhost:8080) to view the docs.
Use `Ctrl+C` to cancel the running container.

### Cleanup
`./stop-backend`

:warning: This will delete your postgres data if you do not update `docker-compose.yml`!

As this is a self-contained sandbox, that is ok.  Re-run `dbt seed` to restore the data.

## Next Steps
Now that you have successfully run a DBT project, hop into the `jaffle_shop` folder and have a look at how it works.

You can connect to postgres at `localhost:5432` with a postgres client to view the models.
