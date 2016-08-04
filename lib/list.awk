BEGIN {
  current_file = ""
  task_lines = ""
  current_project = ""
}

FNR == 1 {
  # this is a new project, display the previous
  display()
} 

FILENAME != current_file {
  # this is a new file, setup environment
  total_records = FNR
  current_file = FILENAME
  # assumes first line is the project name
  current_project = $0
}

/^[-|+] / {
  # collect tasks
  if (task_lines == "") {
    task_lines = $0 "\n"
  } else {
    task_lines = task_lines $0 "\n"
  }
}

/^## COMP/ {
  # COMPLETE section gets ignored
  nextfile
}

END {
  # processing is over, display the last project, if any
  display()
}

# Display a project
function display() {
  if (task_lines != "") {
    # only print projects with items
    print current_project
    print task_lines
  }
  # reset
  current_project = ""
  task_lines = ""
  total_records = 0
}
