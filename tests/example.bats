#!/usr/bin/env bats

load "/usr/local/lib/bats/load.bash"

format_date() {
  date -r 222
}

setup() {
  stub date \
      "-r 222 : echo 'I am stubbed!'" \
      "-r \* : echo 'Wed Dec 31 18:03:42 CST 1969'"
}

teardown() {
  unstub date
}

@test "date format util formats date with expected arguments" {
  result="$(format_date)"
  [ "$result" == 'I am stubbed!' ]

  result="$(format_date)"
  [ "$result" == 'Wed Dec 31 18:03:42 CST 1969' ]
}