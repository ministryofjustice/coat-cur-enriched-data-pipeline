FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.24.1@sha256:00ab45aa365be087d7717fdee73df331084e7e36ce57180377b7c3537e8c53af

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
