FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.38.0@sha256:6d5673d45c3c05b04a3f8c1ae3b24c5472ae753b9d1e5e822507995643b34abe

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
