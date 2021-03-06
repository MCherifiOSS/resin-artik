deviceTypesCommon = require 'resin-device-types/common'
{ networkOptions, commonImg, instructions } = deviceTypesCommon

BOARD_SHUTDOWN_ARTIK = 'The device has performed a shutdown. Press the power switch PSW1 to the off position.'
SET_JUMPER_SD = 'Set SW2 dip switch to position 1:on, 2:on. Also, make sure jumpers J20 and J36 are set towards the edge of the board.'
SET_JUMPER_EMMC = 'Set SW2 dip switch to position 1:off, 2:off.'
BOARD_POWERON_ARTIK = 'Press the power switch PSW1 to the on position. Press and hold for 1 second the SW3 POWER push button.'


postProvisioningInstructions = [
	BOARD_SHUTDOWN_ARTIK
	instructions.REMOVE_INSTALL_MEDIA
	SET_JUMPER_EMMC
	BOARD_POWERON_ARTIK
]

module.exports =
	slug: 'artik10'
	aliases: [ 'artik10' ]
	name: 'Samsung Artik 10'
	arch: 'armv7hf'
	state: 'experimental'

	stateInstructions:
		postProvisioning: postProvisioningInstructions

	instructions: [
		instructions.ETCHER_SD
		instructions.EJECT_SD
		instructions.FLASHER_WARNING
		SET_JUMPER_SD
		BOARD_POWERON_ARTIK
	].concat(postProvisioningInstructions)

	gettingStartedLink:
		windows: 'http://docs.resin.io/#/pages/installing/gettingStarted-Samsung-Artik10.md#windows'
		osx: 'http://docs.resin.io/#/pages/installing/gettingStarted-Samsung-Artik10.md#on-mac-and-linux'
		linux: 'http://docs.resin.io/#/pages/installing/gettingStarted-Samsung-Artik10.md#on-mac-and-linux'

	supportsBlink: false

	yocto:
		machine: 'artik10'
		image: 'resin-image-flasher'
		fstype: 'resin-sdcard'
		version: 'yocto-jethro'
		deployArtifact: 'resin-image-flasher-artik10.resin-sdcard'
		compressed: true

	options: [ networkOptions.group ]

	configuration:
		config:
			partition:
				primary: 4
				logical: 1
			path: '/config.json'

	initialization: commonImg.initialization
