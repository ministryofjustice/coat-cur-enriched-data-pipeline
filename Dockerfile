FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.40.0@sha256:2fefac06335445a58e8e2ce07936701e50bd301535f550c7c552387d1f51202d

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
