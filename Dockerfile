FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.41.0@sha256:008dd45ab54e1b917b3f2b8005cd5f4e5bb541ff6abad91c813558002a768938

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
