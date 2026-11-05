FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.58.0@sha256:36380dff372fe1b05d034d190d712bb8cd98125212736e549b5929585a4f4cb8

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
