restart-parser:
	docker compose build parser
	docker compose up -d parser