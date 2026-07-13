FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.36.0@sha256:6fcb73de98885fd13f8bc510c21b190a208d0cc3217ba9b26c59f00e346673e4

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
