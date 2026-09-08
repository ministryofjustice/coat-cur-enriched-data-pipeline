FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.44.0@sha256:b03a3bcb269bcfa1d58d398074eb39f47a023af6a916a5ebda8fe70f2bca9431

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
