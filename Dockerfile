FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.21.0@sha256:312e931a1a4822af79b2fe567c62f37ee1264dd34507a9ccd16b98c95bf7ea9

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
