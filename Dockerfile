FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.60.0@sha256:0a1c41eeda51c3b72d4c381f33c38e6314df579b850259b73d2b95cd13e88365

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
