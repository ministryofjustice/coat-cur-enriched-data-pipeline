FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.52.0@sha256:3eeb78a1d858e7452bbe4c4087adf5d0076d03c4c71b6bc3e33da9ed3eacaa44

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
