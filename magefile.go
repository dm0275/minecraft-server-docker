//go:build mage
// +build mage

package main

import (
	"fmt"

	"github.com/magefile/mage/sh"
)

// A build step that requires additional params, or platform specific steps for example
func Run(version string) error {
	fmt.Println("Building...")
	return run(fmt.Sprintf("echo version %s", version))
}

func run(cmd string) error {
	output, err := sh.Output("bash", "-c", cmd)
	// Print output
	fmt.Println(output)

	return err
}
