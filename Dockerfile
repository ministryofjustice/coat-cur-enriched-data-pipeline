FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.31.0@sha256:01187293c4d94e4d33026b6d15f973b94976963112151c80f97184740c3b3641

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
