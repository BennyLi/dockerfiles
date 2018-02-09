# Docker Apps

The purpose of this repo is to launch desktop apps from inside an isolated Docker container. This can be used to keep the host system clean.

## Usage

Amend the Dockerfile to your needs. Then launch it via

```
./launch.sh <application-name>
```

### Examples

To launch the Atom text editor run
```
./launch.sh atom
```

## TODO

* Add an option to rebuild the image on a Dockerfile change
* Add an option to recreate the container of image changes
* Seperate multiple apps on different Dockerfiles
* <your-todo-here>
