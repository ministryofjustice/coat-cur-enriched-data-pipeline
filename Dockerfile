FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.45.0@sha256:88160b8321de662de0dc5981fb783bd77a50e5e0fa75f0fdb032fd0901301b3c

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
