FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.27.0@sha256:c3c013771db4c1b23da352c26caa693e5c8387563335e841e9a37428dfdbbe3d

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
