FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.29.0@sha256:df1ca49da80425c5fa15824ba09c5b3a536633608b90ff6623802e56716efb40

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
