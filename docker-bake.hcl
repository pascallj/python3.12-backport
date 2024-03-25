group "default" {
  targets = ["native","crossbuild"]
}

variable "NAME" {
  default = "$NAME"
}

variable "EMAIL" {
  default = "$EMAIL"
}

variable "CHANGE" {
  default = "$CHANGE"
}

target "base" {
  args = {
    NAME = NAME
    EMAIL = EMAIL
    CHANGE = CHANGE
  }
  output = ["type=local,dest=artifacts"]
}

target "native" {
  inherits = ["base"]
  target = "native-binaries"
}

target "crossbuild" {
  args = {
    ARCH = arch
  }
  inherits = ["base"]
  matrix = {
    arch = ["armhf", "arm64"]
  }
  name = "crossbuild-${arch}"
  target = "crossbuild-binaries"
}
