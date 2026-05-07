FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.30.0@sha256:bb99083bba8d81154f5d80c8d527633da75fde65bc91ece83ad78ab173851a03

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
