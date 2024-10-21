variable "containers" {
  type = list(object({
    name = string
    storage = string
  }))
}

variable "blobs" {
  type = list(object({
    name = string
    container = string
    storage = string
  }))
}