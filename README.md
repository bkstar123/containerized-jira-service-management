# Containerized Jira Service Management

This repository contains a Docker-based setup for running Jira Service Management (formerly known as Jira Service Desk) with PostgreSQL as the database backend.

## Prerequisites

- Docker
- Docker Compose
- Git

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/containerized-jira-service-management.git
   cd containerized-jira-service-management
   ```

2. Create a `.env` file in the root directory with the following variables:
   ```env
   POSTGRES_VERSION=13
   JIRASM_VERSION=10.6.1
   HOST_PORT=your_desire_port
   POSTGRES_USER=your_postgres_user
   POSTGRES_PASSWORD=your_secure_password
   ```

3. Start the services:
   ```bash
   docker-compose up -d
   ```

4. Access Jira Service Management at `http://localhost:your_desire_port`

## Architecture

The setup consists of two main services:

1. **PostgreSQL Database**
   - Uses the official PostgreSQL Docker image
   - Data is persisted using Docker volumes
   - Configurable through environment variables

2. **Jira Service Management**
   - Based on the custom image `bkstar123/jira-service-management:10.6.1`  
   - You can re-build the image by going to **jirasm** folder and using **docker build** command. But firstly you need to download the jira service management installer from  https://www.atlassian.com/software/jira/service-management/download-archives, I use atlassian-servicedesk-10.6.1.tar.gz  
   - Connected to PostgreSQL database
   - Data is persisted using Docker volumes
   - Accessible through the configured host port

## Configuration

### Environment Variables

- `POSTGRES_VERSION`: PostgreSQL image version (default: latest)
- `JIRASM_VERSION`: Jira Service Management version (default: 10.6.1)
- `HOST_PORT`: Port to expose Jira Service Management  
- `POSTGRES_USER`: PostgreSQL username
- `POSTGRES_PASSWORD`: PostgreSQL password

### Volumes

- `jirasm_postgres_data`: PostgreSQL data persistence
- `jirasm_data`: Jira Service Management data persistence

## Maintenance

### Backup

To backup your data, you can use Docker volume commands:

```bash
# Backup PostgreSQL data
docker run --rm -v jirasm_postgres_data:/source -v $(pwd):/backup alpine tar czf /backup/postgres_backup.tar.gz -C /source .

# Backup Jira data
docker run --rm -v jirasm_data:/source -v $(pwd):/backup alpine tar czf /backup/jira_backup.tar.gz -C /source .
```

### Logs

View logs for the services:

```bash
# View all logs
docker-compose logs

# View specific service logs
docker-compose logs jira
docker-compose logs postgres
```

## Troubleshooting

1. If you encounter database connection issues:
   - Ensure PostgreSQL is running: `docker-compose ps`
   - Check PostgreSQL logs: `docker-compose logs postgres`

2. If Jira Service Management fails to start:
   - Check Jira logs: `docker-compose logs jira`
   - Verify environment variables in `.env` file

## License

This project is licensed under the terms of the included LICENSE file.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
