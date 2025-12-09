# Cloud Optimisation and Accoutability Team Enriched Data Pipeline 

This repository maintains Cloud Optimisation and Accountability Team Cost and Usage Report Enriched (GreenOps) Data Pipeline.

The pipeline is comprised of a Python job than runs as a container on AP's Airflow infrastructure.

The pipeline's purpose is to create an Athena table from the GreenOps S3 bucket in APDP, so that the data can be ingested by [CaDeT](https://github.com/moj-analytical-services/create-a-derived-table).

# Releaseing a new version

If the pipeline code is updated, you will need to make a new container release. To release a new container, we use GitHub's native [repository release system](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository).

Creating a new release will automatically run the [container release workflow](.github/workflows/release-container.yml), which will publish a new container version to GHCR.

You will then need to update the container version in [AP's Airflow configuration](https://github.com/ministryofjustice/analytical-platform-airflow), to run the new container in Airflow.
