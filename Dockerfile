FROM ghcr.io/ministryofjustice/analytical-platform-airflow-python-base:1.55.0@sha256:76e462d63b5303a1203c2299140d2ac1f39aedffe922e918a99671c558c75418

ARG MOJAP_IMAGE_VERSION="default"

ENV MOJAP_IMAGE_VERSION=${MOJAP_IMAGE_VERSION}

COPY requirements.txt requirements.txt
COPY scripts/ scripts/

RUN <<EOF
pip install --no-cache-dir --requirement requirements.txt
EOF

ENTRYPOINT ["python3", "scripts/main.py"]
