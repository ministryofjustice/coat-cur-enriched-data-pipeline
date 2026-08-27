FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.42.0@sha256:658e6b71cc3d44775c97726aedc535db17d4634ff916b94d71b76c46c2cf5da5

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
