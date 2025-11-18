FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.20.0@sha256:6cfccc9aca038a56a0400a8b382f989ed7ba6868f35e0d94fe564cee3f2e6cd5

ARG MOJAP_IMAGE_VERSION="default"
ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/
RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
