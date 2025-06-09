FROM openjdk:11-jdk-slim

ENV JIRA_HOME /var/atlassian/application-data/jira
ENV JIRA_INSTALL /opt/atlassian/jira

RUN apt-get update && apt-get install -y curl tar

# Tải JSM bản 5.12.2
ADD https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-servicedesk-5.12.2.tar.gz /tmp/jira.tar.gz

RUN mkdir -p ${JIRA_INSTALL} && \
    tar -xzf /tmp/jira.tar.gz -C /opt/atlassian && \
    mv /opt/atlassian/atlassian-jira-servicedesk-*/* ${JIRA_INSTALL} && \
    rm -rf /opt/atlassian/atlassian-jira-servicedesk-*

RUN mkdir -p ${JIRA_HOME} && \
    chown -R daemon:daemon ${JIRA_HOME} ${JIRA_INSTALL}

USER daemon

EXPOSE 8080

CMD ["/opt/atlassian/jira/bin/start-jira.sh", "-fg"]
