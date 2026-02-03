FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.24.1@sha256:ce3298a43c74b6811ee7d60d8dc44cced167f92570f027e2aff911ed096ce1f7

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
