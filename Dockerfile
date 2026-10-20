FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.53.0@sha256:75941a069aa56d00644fcfb5e3185ce2f7f29f5d50b1bb3d3fea4b139086d137

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
