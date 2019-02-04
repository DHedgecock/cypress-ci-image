FROM cypress/base:10

WORKDIR /usr/cypress

# --- Setup Cypress directories
RUN mkdir /home/cypress

# Create non root user
RUN useradd --no-log-init -r -U cypress
RUN chown -R cypress:cypress /usr/cypress
RUN chown -R cypress:cypress /home/cypress
USER cypress

# --- Install Cypress package
# (Avoid many lines of progress bars during install with CI=true)
# https://github.com/cypress-io/cypress/issues/1243
RUN CI=true npm install cypress@3.1.5

# Confirm the cypress install
RUN ./node_modules/.bin/cypress verify