FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.56.0@sha256:609f7696bf5490708f2ace5f053329c96adbf0c4cd6b2c8398cd97b59af55896

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
