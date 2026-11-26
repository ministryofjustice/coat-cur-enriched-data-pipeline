FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.61.0@sha256:0569d91c6ab001e7e7be5fcae68f8d21c2e49fff0efd51f092e3ff094f9579f4

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
