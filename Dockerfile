FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.47.0@sha256:74623e2e24f407153513fcddbbe7d8cc9299a7165a9e428fc827a8eb820dda95

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
