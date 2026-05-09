# Multi-stage build — keeps the final image small
FROM python:3.11-slim AS base
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

FROM base AS builder
COPY pyproject.toml .
RUN pip install --no-cache-dir ".[dev]" --target /install

FROM base AS final
COPY --from=builder /install /usr/local/lib/python3.11/site-packages
COPY src/ ./src/

EXPOSE 8000
CMD ["uvicorn", "src.app.main:app", "--host", "0.0.0.0", "--port", "8000"]
