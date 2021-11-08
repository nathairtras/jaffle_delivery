This repo is meant as a "shortcut" to getting developers playing with DBT locally.
It is meant to provide a sandbox for [jaffle_shop](https://github.com/dbt-labs/jaffle_shop).
This repo is provided as a submodule for convenience, all licensing for that material depends on the included license.

This should probably have a license, but there's nothing really here beyond some very basic docker-compose, so do with _this_ code as you see fit.

The readme for `jaffle_shop` should be followed.
The following commands correspond to commands in the repo, but using bash scripts as wrappers for dockerized DBT.

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