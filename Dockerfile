FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.57.0@sha256:f2f2f632c9b9de59f868ba8c66ff19540dec715355345ae4cba11af3ad8b4957

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
