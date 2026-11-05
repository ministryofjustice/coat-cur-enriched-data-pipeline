FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.59.0@sha256:f9847e29457e68555e21e9c680b3e96f0a15335273b77d7add91519dd10ab050

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
