FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.51.0@sha256:b2c6bf9b3bef35870a965bed9872daccbaccb8e57f7f2421841eb8beed130c61

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
