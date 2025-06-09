FROM eclipse-temurin:21-jdk-jammy

ENV JIRA_HOME /var/atlassian/application-data/jira
ENV JIRA_INSTALL /opt/atlassian/jira

RUN apt-get update && apt-get install -y curl tar

# Copy JSM bản 10.6.1
COPY atlassian-servicedesk-10.6.1.tar.gz /tmp/jira.tar.gz

RUN mkdir -p ${JIRA_INSTALL} && \
    tar -xzf /tmp/jira.tar.gz -C /opt/atlassian && \
    mv /opt/atlassian/atlassian-jira-servicedesk-*/* ${JIRA_INSTALL} && \
    rm -rf /opt/atlassian/atlassian-jira-servicedesk-*

RUN mkdir -p ${JIRA_HOME} && \
    chown -R daemon:daemon ${JIRA_HOME} ${JIRA_INSTALL}

USER daemon

EXPOSE 8080

CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]
