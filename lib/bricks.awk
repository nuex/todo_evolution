/^\+ / {
  n = split(FILENAME, p, "/")
  print p[n] ": " $0
  nextfile
}
