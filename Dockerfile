FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.39.0@sha256:3c208257c2fdc721535a142749ab254a53aef18cdd8a24775f12bc9a1dd10627

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
