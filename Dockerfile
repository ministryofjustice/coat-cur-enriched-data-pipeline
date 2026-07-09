FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.34.0@sha256:5629c969956f0746cdf5c2333e9f049e752851b3cf5e10a9d8f5b02d387b5c18

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
