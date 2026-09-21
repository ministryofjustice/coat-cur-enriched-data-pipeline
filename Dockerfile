FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.46.0@sha256:551c5af72a3d93d2a772623d1773ace892a953580a871bb77de9d74d0e2c66b6

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
