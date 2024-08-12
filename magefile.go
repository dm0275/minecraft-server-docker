//go:build mage
// +build mage

package main

import (
	"fmt"
	"log"
	"os"

	"github.com/magefile/mage/sh"
)

var (
	imageName = "dm0275/minecraft-server"
	mcVersion = "1.18.2"
	logger    = log.Default()
)

type MinecraftConfig struct {
	WorldName string
	WorldDir  string
	ModsDir   string
	Version   string
	Port      string
	MaxMemory string
	MinMemory string
}

func setupDirectories(worldName string) (string, string) {
	cwd, err := os.Getwd()
	checkErr(err)

	worldDir := fmt.Sprintf("%s/data_forge/%s/world", cwd, worldName)
	modsDir := fmt.Sprintf("%s/data_forge/%s/mods", cwd, worldName)

	err = os.MkdirAll(worldDir, 0o755)
	checkErr(err)

	err = os.MkdirAll(modsDir, 0o755)
	checkErr(err)

	return worldDir, modsDir
}

func defaultConfig(worldName string) map[string]string {
	worldDir, modsDir := setupDirectories(worldName)
	mcImage := fmt.Sprintf("%s:forge-%s", imageName, mcVersion)

	return map[string]string{
		"WORLD":        worldName,
		"WORLD_DIR":    worldDir,
		"MODS_DIR":     modsDir,
		"PORT":         "25565",
		"MC_IMAGE":     mcImage,
		"JAVA_MIN_MEM": "3G",
		"JAVA_MAX_MEM": "3G",
	}
}

// Run minecraft server (default configuration)
func Run(worldName string) error {
	config := defaultConfig(worldName)
	debug(fmt.Sprintf("Minecraf Config: %s", config))

	return execEnv("docker compose up -d", config)
}

// Run specific minecraft server version
func RunVersion(worldName, version string) error {
	worldDir, modsDir := setupDirectories(worldName)
	mcImage := fmt.Sprintf("%s:forge-%s", imageName, version)

	config := map[string]string{
		"WORLD":        worldName,
		"WORLD_DIR":    worldDir,
		"MODS_DIR":     modsDir,
		"PORT":         "25565",
		"MC_IMAGE":     mcImage,
		"JAVA_MIN_MEM": "3G",
		"JAVA_MAX_MEM": "3G",
	}

	return execEnv("docker compose up -d", config)
}

func exec(cmd string) error {
	output, err := sh.Output("bash", "-c", cmd)

	// Print output
	logger.Println(output)

	return err
}

func execEnv(cmd string, env map[string]string) error {
	output, err := sh.OutputWith(env, "bash", "-c", cmd)

	// Print output
	logger.Println(output)

	return err
}

func debug(msg string) {
	if os.Getenv("MAGEFILE_VERBOSE") == "1" {
		logger.Println(msg)
	}
}

func checkErr(err error) {
	if err != nil {
		logger.Fatalf(fmt.Sprintf("ERROR: %s", err))
	}
}
