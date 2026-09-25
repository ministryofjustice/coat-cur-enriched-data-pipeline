FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.48.0@sha256:6bf35bf31ee47d21a042039b161bfc271b60211ad5a1c6d95b19c34fa11fec2f

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
