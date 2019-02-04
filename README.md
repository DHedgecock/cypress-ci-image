# Cypress CI Image

This image includes everything needed to run Cypress in a Docker container. Use
volumes to include the test files for a nearly zero config acceptance test runner:

```yml
version: '3'
services:
  test:
    image: nginx:1.15.8
    volumes:
      - ./test/nginx.conf:/etc/nginx/nginx.conf
      - ./dist:/www/dat
  cypress:
    image: dhedgecock/cypress-ci:10.3.1.5
    # See https://github.com/cypress-io/cypress/issues/350
    ipc: host
    command: ./node_modules/.bin/cypress run --config baseUrl=http://test
    depends_on:
      - test
    volumes:
      - ./cypress:/usr/cypress/cypress
      - ./cypress.json:/usr/cypress/cypress.json
```