FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.54.0@sha256:47656779822d00a1d832ed743f1fc2f4587d492b09b7b637a9ea32b8298d14e1

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
