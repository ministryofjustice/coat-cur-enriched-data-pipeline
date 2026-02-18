FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.26.0@sha256:a46cf0271046348f87a55b6f59fd44de365440cd61949d7f4d79d048332fb76d

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
