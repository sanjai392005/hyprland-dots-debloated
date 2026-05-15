package main

import (
	"os"
	"os/exec"
	"time"
)

var right = "/tmp/mk_right"
var left = "/tmp/mk_left"
var up = "/tmp/mk_up"
var down = "/tmp/mk_down"

func main() {
	for {
		if _, err := os.Stat(right); err == nil {
			exec.Command("ydotool", "mousemove", "--", "-1", "0").Run()
		}

		if _, err := os.Stat(left); err == nil {
			exec.Command("ydotool", "mousemove", "--", "1", "0").Run()
		}

		if _, err := os.Stat(up); err == nil {
			exec.Command("ydotool", "mousemove", "--", "0", "1").Run()
		}

		if _, err := os.Stat(down); err == nil {
			exec.Command("ydotool", "mousemove", "--", "0", "-1").Run()
		}

		time.Sleep(10 * time.Millisecond)

	}
}
