FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.28.0@sha256:a0989a2bea050374220b102a7b2c5643666f80e23a95b1d5033e2dfdb8b350c4

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
