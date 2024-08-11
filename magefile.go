//go:build mage
// +build mage

package main

import (
	"fmt"

	"github.com/magefile/mage/sh"
)

// A build step that requires additional params, or platform specific steps for example
func Run() error {
	fmt.Println("Building...")
	return sh.Run("echo", "build", "-o", "MyApp", ".")
}
