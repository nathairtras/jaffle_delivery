## Using this repo
This repo is meant as a "shortcut" to getting developers playing with DBT locally.
It is meant to provide a sandbox for [jaffle_shop](https://github.com/dbt-labs/jaffle_shop).
This repo is provided as a submodule for convenience, all licensing for that material depends on the included license.

This should probably have a license, but there's nothing really here beyond some very basic docker-compose, so do with _this_ code as you see fit.

The readme for `jaffle_shop` should be followed.
The following commands correspond to commands in the repo, but using bash scripts as wrappers for dockerized DBT.

### Docker Requirements
If you are using Docker Desktop, you will need to set it to have filesystem access to this repo's folder.
It will be needed for volume mounting the DBT profile and the DBT project directory to the DBT container.

### Changes to Jaffle Shop
Keep in mind that the `jaffle_shop` subfolder _is a git repo!_  Do not make commits to it, do not push from it, just use it as a reference.
You can purge your changes by resetting the file state to get a clean slate.

If you want to preserve your sandbox, consider:
* Forking this repo
* Forking jaffle shop
* Updating your fork of this repo to use the Jaffle Shop fork you created in step two

This may be a terrible approach, but it avoids storing the entire jaffle shop repo in this repo.
The real purpose of this repo is to make `jaffle_shop` faster to use, _not_ to change it.

## Walkthrough Commands
### Start the Docker Postgres backend in the background
`./start-backend`

### Check that DBT works
`./dbt debug`

### Create the DBT seeds
`./dbt seed`

### Run the DBT models
`./dbt run`

### Run the DBT tests
`./dbt test`

### Run the DBT doc generation
`./dbt docs generate`

### Serve the docs
`./dbt docs serve`

While this is running, visit [localhost:8080](http://localhost:8080) to view the docs.
Use `Ctrl+C` to cancel the running container.

### Cleanup
`./stop-backend`

:warning: This will delete your postgres data if you do not update `docker-compose.yml`!

As this is a self-contained sandbox, that is ok.  Re-run `./dbt seed` to restore the data.

## Next Steps
Now that you have successfully run a DBT project, hop into the `jaffle_shop` folder and have a look at how it works.

You can connect to postgres at `localhost:5432` with a postgres client to view the models.