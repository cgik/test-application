# go-db-server
## Description
A simple server written in go. Recieves text, reverses it, stores both in a database and returns result to user. It has no real other purposeful aside from for testing.

## Layout
`/app`: The application location.
`/scripts`: Setup scripts for the app's dependencies (databases).
`/tests`: Tests for the application, including e2e testing.

### Misc
`docker-compose.yaml`: Used for environment setup and e2e testing.
`Makefile`: Coordinating all the things above, good for both automation and users of your application.

## TODO
- Add graceful shutdown 