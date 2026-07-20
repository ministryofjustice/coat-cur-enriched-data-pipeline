FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.37.0@sha256:4e924b3b014ee0e7e52cf4fc4e7e94b44b2b4aef9248d2f21aff644528979864

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
