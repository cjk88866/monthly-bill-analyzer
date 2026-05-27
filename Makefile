.PHONY: backend-test frontend-build docker-config docker-up docker-down clean-data

backend-test:
	cd backend && .venv/bin/python -m pytest -q

frontend-build:
	cd frontend && npm run build

docker-config:
	docker compose config

docker-up:
	docker compose up --build

docker-down:
	docker compose down

clean-data:
	find data/uploads data/reports -mindepth 1 ! -name .gitkeep -delete
