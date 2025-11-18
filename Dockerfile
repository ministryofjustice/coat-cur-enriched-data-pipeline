FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.21.0@sha256:067ee7262dcb1f6fba0960aa62c729e4dadc0201

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
