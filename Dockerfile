FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.32.0@sha256:c317c15ca47a35fd9444beb7dade12c4728660435a890ad30f2f528719a8e7ba

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
