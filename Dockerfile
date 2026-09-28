FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.49.0@sha256:76283713f584b8908b7c3d52d775519da8ba2ede65bb58270d42b7bda4a40fac

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
