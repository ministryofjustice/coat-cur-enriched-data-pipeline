FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.50.0@sha256:b7e2c0ea1e0758a7ba736797350817466a6c5dad15e0b0b7a3c1c3c2096fef13

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
