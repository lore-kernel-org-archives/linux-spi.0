From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [GIT PULL] SPI updates for v4.4
Date: Thu, 5 Nov 2015 11:00:35 +0000
Message-ID: <20151105110035.GQ1717@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tk6xM/wkRlnXD2NA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tk6xM/wkRlnXD2NA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861:

  Linux 4.3 (2015-11-01 16:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v4=
=2E4

for you to fetch changes up to c70efb85153162295dc80099e95dab93d486a3ed:

  Merge remote-tracking branches 'spi/topic/s3c64xx', 'spi/topic/ti-qspi' a=
nd 'spi/topic/txx9' into spi-next (2015-11-04 11:02:16 +0000)

----------------------------------------------------------------
spi: Updates for v4.4

Quite a lot of activity in SPI this cycle, almost all of it in drivers
with a few minor improvements and tweaks in the core.

 - Updates to pxa2xx to support Intel Broxton and multiple chip selects.
 - Support for big endian in the bcm63xx driver.
 - Multiple slave support for the mt8173
 - New driver for the auxiliary SPI controller in bcm2835 SoCs.
 - Support for Layerscale SoCs in the Freescale DSPI driver.

----------------------------------------------------------------

There's quite a few trivial conflicts with "spi: Drop owner assignments
=66rom spi_drivers".  I was in two minds about including that here or just
pushing separate cleanup patches to individual drivers/subsystems, I can
respin with the patch dropped if you prefer.

Andrew F. Davis (2):
      spi: Add THIS_MODULE to spi_driver in SPI core
      spi: Drop owner assignment from spi_drivers

Andrew Y. Kuksov (1):
      spi: imx: fix ecspi mode setup

Andy Shevchenko (16):
      spi: core: propagate return code of __spi_validate_bits_per_word()
      spi: pxa2xx: choose closest lower speed
      spi: dw: use plain struct device * at earlier ->probe()
      spi: dw: remove unneeded cr0 member of struct chip_data
      spi: dw: remove bits_per_word member of struct chip_data
      spi: dw: eliminate speed variable in ->transfer_one()
      spi: dw: eliminate unused threshold variables
      spi: dw: introduce spi_shutdown_chip()
      spi: dw-pci: remove unused pdev member from struct dw_spi_pci
      spi: dw-mmio: convert to unified device property API
      spi: dw: explicitly free IRQ handler in dw_spi_remove_host()
      spi: dw: remove a NULL check when call ->remove()
      spi: core: use gpio_is_valid() helper
      spi: pxa2xx: move debug messages to pump_transfer()
      spi: pxa2xx: derive struct chip_data from struct drv_data
      spi: dw: replace magic constant by DW_SPI_DR

David Mosberger-Tang (1):
      spi: atmel: Fix DMA-setup for transfers with more than 8 bits per word

Felipe Balbi (1):
      spi: ti-qspi: improve ->remove() callback

Franklin S Cooper Jr (1):
      spi: Setup the master controller driver before setting the chipselect

Heiner Kallweit (7):
      spi: s3c64xx: clean up runtime PM if driver registration fails
      spi: s3c64xx: extend driver to make full use of runtime PM autosuspend
      spi: s3c64xx: simplify suspend / resume handlers
      spi: s3c64xx: replace clock disabling with runtime PM suspend call in=
 remove function
      spi: ath79: simplify iomem resource mapping
      spi: bitbang: remove unneeded check
      spi: bitbang: switch to the generic implementation of transfer_one_me=
ssage

Jarkko Nikula (27):
      spi: txx9: Use transfer speed unconditionally
      spi: s3c64xx: Use transfer speed unconditionally
      spi: octeon: Use transfer speed unconditionally
      spi: bfin-sport: Calculate transfer speed unconditionally
      spi: spi-bfin5xx: Calculate transfer speed unconditionally
      spi: au1550: Simplify au1550_spi_setupxfer()
      spi: mpc512x: Call mpc512x_psc_spi_transfer_setup() unconditionally
      spi: omap-uwire: Remove needless bits_per_word and speed_hz tests
      spi: omap-100k: Rely on validations done by spi core
      spi: dw: Remove needless if statements
      spi: dw: Remove test for non-zero spi->max_speed_hz
      spi: spi-fsl-dspi: Remove duplicated register write
      spi: pxa2xx: Remove two variables from struct chip_data
      spi: pxa2xx: Remove if statement that is always true in pump_transfer=
s()
      spi: pxa2xx: Remove cr0 variable from struct chip_data
      spi: pxa2xx: Set the max_speed_hz of the master
      spi: pxa2xx: Use ACPI_COMPANION() instead of acpi_bus_get_device()
      spi: atmel: Remove needless bits_per_word and speed_hz tests
      spi: pxa2xx: Remove unused psp member variable from struct chip_data
      spi: pxa2xx: Convert unique ID string of ACPI device as unsigned inte=
ger
      spi: pxa2xx: Save other reg_cs_ctrl bits when configuring chip select
      spi: pxa2xx: Align a few defines
      spi: pxa2xx: Use LPSS prefix for defines that are Intel LPSS specific
      spi: pxa2xx: Add output control for multiple Intel LPSS chip selects
      spi: pxa2xx: Detect number of enabled Intel LPSS SPI chip select sign=
als
      spi: pxa2xx: Add support for Intel Broxton
      spi: pxa2xx: Rework self-initiated platform data creation for non-ACPI

Javier Martinez Canillas (2):
      spi: fix kernel-doc warnings about missing return desc in spi.h
      spi: fix kernel-doc warnings about missing return desc in spi.c

Jon Hunter (1):
      spi: Map SPI OF client IRQ at probe time

Jonas Gorski (7):
      spi/bcm63xx: remove unused rx_tail variable
      spi/bcm63xx: always use a fixed number of CS
      spi/bcm63xx: hardcode busnum to 0
      spi/bcm63xx: replace custom io accessors with standard ones
      spi/bcm63xx: fix standard accessors and compile guard
      spi/bcm63xx: move message control word description to register offsets
      spi/bcm63xx: move register definitions into the driver

Leilk Liu (4):
      spi: mediatek: Update document devicetree bindings to support multipl=
e devices
      spi: mediatek: remove mtk_spi_config
      spi: mediatek: handle controller_data in mtk_spi_setup
      spi: mediatek: mt8173 spi multiple devices support

Luis de Bethencourt (1):
      spi: davinci: use spi->cs_gpio directly

Mark Brown (12):
      Merge branches 'topic/core' and 'topic/stats' of git://git.kernel.org=
/.../broonie/spi into spi-doc
      Merge remote-tracking branch 'spi/fix/core' into spi-linus
      Merge remote-tracking branches 'spi/fix/atmel', 'spi/fix/imx', 'spi/f=
ix/omap2-mcspi', 'spi/fix/ti-qspi' and 'spi/fix/xilinx' into spi-linus
      Merge remote-tracking branch 'spi/topic/core' into spi-next
      Merge remote-tracking branch 'spi/topic/davinci' into spi-next
      Merge remote-tracking branch 'spi/topic/doc' into spi-next
      Merge remote-tracking branches 'spi/topic/ath97', 'spi/topic/atmel', =
'spi/topic/au1550', 'spi/topic/bcm2835' and 'spi/topic/bcm2835aux' into spi=
-next
      Merge remote-tracking branches 'spi/topic/bcm53xx', 'spi/topic/bcm63x=
x', 'spi/topic/bfin-sport', 'spi/topic/bfin5xx' and 'spi/topic/bitbang' int=
o spi-next
      Merge remote-tracking branches 'spi/topic/coldfire' and 'spi/topic/dw=
' into spi-next
      Merge remote-tracking branches 'spi/topic/fsl-dspi', 'spi/topic/mpc51=
2x', 'spi/topic/mtk', 'spi/topic/oc-tiny' and 'spi/topic/octeon' into spi-n=
ext
      Merge remote-tracking branches 'spi/topic/omap-100k', 'spi/topic/omap=
-uwire', 'spi/topic/owner', 'spi/topic/pxa' and 'spi/topic/pxa2xx' into spi=
-next
      Merge remote-tracking branches 'spi/topic/s3c64xx', 'spi/topic/ti-qsp=
i' and 'spi/topic/txx9' into spi-next

Martin Sperl (6):
      spi: add transfer histogram statistics via sysfs
      spi: bcm2835aux: spi: add bindings for the bcm2835 auxiliary spi devi=
ces
      spi: bcm2835aux: add bcm2835 auxiliary spi device driver
      spi: bcm2835: change initialization order and switch to platform_get_=
irq
      spi: bcm2835aux: fixed bad data on longer transfers
      spi: bcm2835aux: change initialization order and switch to platform_g=
et_irq

Mika Westerberg (1):
      spi: pxa2xx: Remove empty function pxa2xx_spi_dma_resume()

Neil Armstrong (1):
      spi: omap2-mcspi: disable other channels CHCONF_FORCE in prepare_mess=
age

Nicolas Boichat (1):
      spi: bitbang: Replace spinlock by mutex

Ricardo Ribalda Delgado (1):
      spi/spi-xilinx: Fix race condition on last word read

Tobias Klauser (1):
      spi: oc-tiny: Use of_property_read_u32 instead of open-coding it

Vaishali Thakkar (1):
      spi: bcm53xx: Adjust devm usage

Vignesh R (2):
      spi: ti-qspi: Fix data corruption seen on r/w stress test
      spi: spi-ti-qspi: switch to polling mode for better r/w performance

Wolfram Sang (1):
      spi: spi-coldfire-qspi: enable RuntimePM before registering to the co=
re

Yuan Yao (1):
      spi: Add DSPI support for layerscape family

 .../bindings/spi/brcm,bcm2835-aux-spi.txt          |  38 ++
 .../devicetree/bindings/spi/spi-mt65xx.txt         |   9 +-
 arch/arm/mach-u300/dummyspichip.c                  |   1 -
 arch/mips/bcm63xx/dev-spi.c                        |  42 +-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |  44 --
 arch/mips/txx9/generic/spi_eeprom.c                |   1 -
 drivers/char/tpm/st33zp24/spi.c                    |   1 -
 drivers/gpio/gpio-74x164.c                         |   1 -
 drivers/gpio/gpio-max7301.c                        |   1 -
 drivers/gpio/gpio-mc33880.c                        |   1 -
 drivers/gpio/gpio-mcp23s08.c                       |   2 -
 drivers/gpu/drm/panel/panel-lg-lg4573.c            |   1 -
 drivers/gpu/drm/panel/panel-samsung-ld9040.c       |   1 -
 drivers/hwmon/ad7314.c                             |   1 -
 drivers/hwmon/adcxx.c                              |   1 -
 drivers/hwmon/ads7871.c                            |   1 -
 drivers/hwmon/adt7310.c                            |   1 -
 drivers/hwmon/lm70.c                               |   1 -
 drivers/hwmon/max1111.c                            |   1 -
 drivers/iio/accel/kxsd9.c                          |   1 -
 drivers/iio/accel/st_accel_spi.c                   |   1 -
 drivers/iio/adc/ad7266.c                           |   1 -
 drivers/iio/adc/ad7298.c                           |   1 -
 drivers/iio/adc/ad7476.c                           |   1 -
 drivers/iio/adc/ad7791.c                           |   1 -
 drivers/iio/adc/ad7793.c                           |   1 -
 drivers/iio/adc/ad7887.c                           |   1 -
 drivers/iio/adc/ad7923.c                           |   1 -
 drivers/iio/adc/max1027.c                          |   1 -
 drivers/iio/adc/mcp320x.c                          |   1 -
 drivers/iio/adc/ti-adc128s052.c                    |   1 -
 drivers/iio/amplifiers/ad8366.c                    |   1 -
 drivers/iio/common/ssp_sensors/ssp_dev.c           |   1 -
 drivers/iio/dac/ad5064.c                           |   1 -
 drivers/iio/dac/ad5360.c                           |   1 -
 drivers/iio/dac/ad5380.c                           |   1 -
 drivers/iio/dac/ad5421.c                           |   1 -
 drivers/iio/dac/ad5446.c                           |   1 -
 drivers/iio/dac/ad5449.c                           |   1 -
 drivers/iio/dac/ad5504.c                           |   1 -
 drivers/iio/dac/ad5624r_spi.c                      |   1 -
 drivers/iio/dac/ad5686.c                           |   1 -
 drivers/iio/dac/ad5755.c                           |   1 -
 drivers/iio/dac/ad5764.c                           |   1 -
 drivers/iio/dac/ad5791.c                           |   1 -
 drivers/iio/dac/ad7303.c                           |   1 -
 drivers/iio/dac/mcp4922.c                          |   1 -
 drivers/iio/frequency/ad9523.c                     |   1 -
 drivers/iio/frequency/adf4350.c                    |   1 -
 drivers/iio/gyro/adis16080.c                       |   1 -
 drivers/iio/gyro/adis16130.c                       |   1 -
 drivers/iio/gyro/adis16136.c                       |   1 -
 drivers/iio/gyro/adis16260.c                       |   1 -
 drivers/iio/gyro/adxrs450.c                        |   1 -
 drivers/iio/gyro/st_gyro_spi.c                     |   1 -
 drivers/iio/imu/adis16400_core.c                   |   1 -
 drivers/iio/imu/adis16480.c                        |   1 -
 drivers/iio/magnetometer/st_magn_spi.c             |   1 -
 drivers/iio/pressure/ms5611_spi.c                  |   1 -
 drivers/iio/pressure/st_pressure_spi.c             |   1 -
 drivers/iio/proximity/as3935.c                     |   1 -
 drivers/input/misc/ad714x-spi.c                    |   1 -
 drivers/input/misc/adxl34x-spi.c                   |   1 -
 drivers/input/touchscreen/ad7877.c                 |   1 -
 drivers/input/touchscreen/ad7879-spi.c             |   1 -
 drivers/input/touchscreen/ads7846.c                |   1 -
 drivers/input/touchscreen/cyttsp4_spi.c            |   1 -
 drivers/input/touchscreen/cyttsp_spi.c             |   1 -
 drivers/input/touchscreen/tsc2005.c                |   1 -
 drivers/leds/leds-dac124s085.c                     |   1 -
 drivers/media/i2c/s5c73m3/s5c73m3-spi.c            |   1 -
 drivers/media/tuners/msi001.c                      |   1 -
 drivers/mfd/arizona-spi.c                          |   1 -
 drivers/mfd/cros_ec_spi.c                          |   1 -
 drivers/mfd/da9052-spi.c                           |   1 -
 drivers/mfd/ezx-pcap.c                             |   1 -
 drivers/mfd/mc13xxx-spi.c                          |   1 -
 drivers/mfd/stmpe-spi.c                            |   1 -
 drivers/mfd/tps65912-spi.c                         |   1 -
 drivers/mfd/wm831x-spi.c                           |   1 -
 drivers/misc/ad525x_dpot-spi.c                     |   1 -
 drivers/misc/bmp085-spi.c                          |   1 -
 drivers/misc/eeprom/at25.c                         |   1 -
 drivers/misc/eeprom/eeprom_93xx46.c                |   1 -
 drivers/misc/lattice-ecp3-config.c                 |   1 -
 drivers/misc/lis3lv02d/lis3lv02d_spi.c             |   1 -
 drivers/misc/ti_dac7512.c                          |   1 -
 drivers/mmc/host/mmc_spi.c                         |   1 -
 drivers/mtd/devices/m25p80.c                       |   1 -
 drivers/mtd/devices/mtd_dataflash.c                |   1 -
 drivers/mtd/devices/sst25l.c                       |   1 -
 drivers/net/can/spi/mcp251x.c                      |   1 -
 drivers/net/ethernet/micrel/ks8851.c               |   1 -
 drivers/net/ethernet/microchip/enc28j60.c          |   1 -
 drivers/net/ethernet/qualcomm/qca_spi.c            |   1 -
 drivers/net/ieee802154/at86rf230.c                 |   1 -
 drivers/net/ieee802154/cc2520.c                    |   1 -
 drivers/net/ieee802154/mrf24j40.c                  |   1 -
 drivers/net/phy/spi_ks8995.c                       |   1 -
 drivers/net/wireless/cw1200/cw1200_spi.c           |   1 -
 drivers/net/wireless/libertas/if_spi.c             |   1 -
 drivers/net/wireless/p54/p54spi.c                  |   1 -
 drivers/net/wireless/ti/wl1251/spi.c               |   1 -
 drivers/net/wireless/ti/wlcore/spi.c               |   1 -
 drivers/nfc/st-nci/spi.c                           |   1 -
 drivers/nfc/trf7970a.c                             |   1 -
 drivers/regulator/tps6524x-regulator.c             |   1 -
 drivers/rtc/rtc-ds1305.c                           |   1 -
 drivers/rtc/rtc-ds1343.c                           |   1 -
 drivers/rtc/rtc-ds1347.c                           |   1 -
 drivers/rtc/rtc-ds1390.c                           |   1 -
 drivers/rtc/rtc-ds3234.c                           |   1 -
 drivers/rtc/rtc-m41t93.c                           |   1 -
 drivers/rtc/rtc-m41t94.c                           |   1 -
 drivers/rtc/rtc-max6902.c                          |   1 -
 drivers/rtc/rtc-mcp795.c                           |   1 -
 drivers/rtc/rtc-pcf2123.c                          |   1 -
 drivers/rtc/rtc-r9701.c                            |   1 -
 drivers/rtc/rtc-rs5c348.c                          |   1 -
 drivers/rtc/rtc-rx4581.c                           |   1 -
 drivers/spi/Kconfig                                |  15 +-
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-ath79.c                            |  11 +-
 drivers/spi/spi-atmel.c                            |  24 +-
 drivers/spi/spi-au1550.c                           |  11 +-
 drivers/spi/spi-bcm2835.c                          |  14 +-
 drivers/spi/spi-bcm2835aux.c                       | 512 +++++++++++++++++=
++++
 drivers/spi/spi-bcm53xx.c                          |  13 +-
 drivers/spi/spi-bcm63xx.c                          | 210 ++++++++-
 drivers/spi/spi-bfin-sport.c                       |   5 +-
 drivers/spi/spi-bfin5xx.c                          |   6 +-
 drivers/spi/spi-bitbang.c                          | 152 ++----
 drivers/spi/spi-coldfire-qspi.c                    |   3 +-
 drivers/spi/spi-davinci.c                          |  15 +-
 drivers/spi/spi-dw-mmio.c                          |   7 +-
 drivers/spi/spi-dw-pci.c                           |  29 +-
 drivers/spi/spi-dw.c                               | 108 ++---
 drivers/spi/spi-dw.h                               |   6 +
 drivers/spi/spi-fsl-dspi.c                         |   3 -
 drivers/spi/spi-imx.c                              |   7 +
 drivers/spi/spi-mpc512x-psc.c                      |   8 +-
 drivers/spi/spi-mt65xx.c                           | 129 ++++--
 drivers/spi/spi-oc-tiny.c                          |  14 +-
 drivers/spi/spi-octeon.c                           |   2 +-
 drivers/spi/spi-omap-100k.c                        |  26 +-
 drivers/spi/spi-omap-uwire.c                       |   7 +-
 drivers/spi/spi-omap2-mcspi.c                      |  28 ++
 drivers/spi/spi-ppc4xx.c                           |   4 +-
 drivers/spi/spi-pxa2xx-dma.c                       |   4 -
 drivers/spi/spi-pxa2xx.c                           | 257 +++++++----
 drivers/spi/spi-pxa2xx.h                           |   9 -
 drivers/spi/spi-s3c24xx.c                          |   4 +-
 drivers/spi/spi-s3c64xx.c                          |  46 +-
 drivers/spi/spi-ti-qspi.c                          |  88 +---
 drivers/spi/spi-tle62x0.c                          |   1 -
 drivers/spi/spi-txx9.c                             |   2 +-
 drivers/spi/spi-xilinx.c                           |  38 +-
 drivers/spi/spi.c                                  | 136 +++++-
 drivers/spi/spidev.c                               |   1 -
 drivers/staging/fbtft/fbtft.h                      |   1 -
 drivers/staging/fbtft/flexfb.c                     |   1 -
 drivers/staging/iio/accel/adis16201_core.c         |   1 -
 drivers/staging/iio/accel/adis16203_core.c         |   1 -
 drivers/staging/iio/accel/adis16204_core.c         |   1 -
 drivers/staging/iio/accel/adis16209_core.c         |   1 -
 drivers/staging/iio/accel/adis16220_core.c         |   1 -
 drivers/staging/iio/accel/adis16240_core.c         |   1 -
 drivers/staging/iio/accel/lis3l02dq_core.c         |   1 -
 drivers/staging/iio/accel/sca3000_core.c           |   1 -
 drivers/staging/iio/adc/ad7192.c                   |   1 -
 drivers/staging/iio/adc/ad7280a.c                  |   1 -
 drivers/staging/iio/adc/ad7606_spi.c               |   1 -
 drivers/staging/iio/adc/ad7780.c                   |   1 -
 drivers/staging/iio/adc/ad7816.c                   |   1 -
 drivers/staging/iio/addac/adt7316-spi.c            |   1 -
 drivers/staging/iio/frequency/ad9832.c             |   1 -
 drivers/staging/iio/frequency/ad9834.c             |   1 -
 drivers/staging/iio/gyro/adis16060_core.c          |   2 -
 drivers/staging/iio/magnetometer/hmc5843_spi.c     |   1 -
 drivers/staging/iio/meter/ade7753.c                |   1 -
 drivers/staging/iio/meter/ade7754.c                |   1 -
 drivers/staging/iio/meter/ade7758_core.c           |   1 -
 drivers/staging/iio/meter/ade7759.c                |   1 -
 drivers/staging/iio/meter/ade7854-spi.c            |   1 -
 drivers/staging/iio/resolver/ad2s1200.c            |   1 -
 drivers/staging/iio/resolver/ad2s1210.c            |   1 -
 drivers/staging/iio/resolver/ad2s90.c              |   1 -
 drivers/staging/mt29f_spinand/mt29f_spinand.c      |   1 -
 drivers/tty/serial/ifx6x60.c                       |   2 +-
 drivers/tty/serial/max3100.c                       |   1 -
 drivers/tty/serial/max310x.c                       |   1 -
 drivers/tty/serial/sc16is7xx.c                     |   1 -
 drivers/usb/host/max3421-hcd.c                     |   1 -
 drivers/video/backlight/ams369fg06.c               |   1 -
 drivers/video/backlight/corgi_lcd.c                |   1 -
 drivers/video/backlight/ili922x.c                  |   1 -
 drivers/video/backlight/l4f00242t03.c              |   1 -
 drivers/video/backlight/ld9040.c                   |   1 -
 drivers/video/backlight/lms283gf05.c               |   1 -
 drivers/video/backlight/lms501kf03.c               |   1 -
 drivers/video/backlight/ltv350qv.c                 |   1 -
 drivers/video/backlight/s6e63m0.c                  |   1 -
 drivers/video/backlight/tdo24m.c                   |   1 -
 drivers/video/backlight/tosa_lcd.c                 |   1 -
 drivers/video/backlight/vgg2432a4.c                |   1 -
 drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c    |   1 -
 drivers/video/fbdev/omap/lcd_mipid.c               |   1 -
 .../omap2/displays-new/panel-lgphilips-lb035q02.c  |   1 -
 .../omap2/displays-new/panel-nec-nl8048hl11.c      |   1 -
 .../omap2/displays-new/panel-sony-acx565akm.c      |   1 -
 .../omap2/displays-new/panel-tpo-td028ttec1.c      |   1 -
 .../omap2/displays-new/panel-tpo-td043mtea1.c      |   1 -
 include/linux/pxa2xx_ssp.h                         |   1 +
 include/linux/spi/spi.h                            |  44 +-
 include/linux/spi/spi_bitbang.h                    |   2 +-
 sound/soc/codecs/ad1836.c                          |   1 -
 sound/soc/codecs/ad193x-spi.c                      |   1 -
 sound/soc/codecs/adau1761-spi.c                    |   1 -
 sound/soc/codecs/adau1781-spi.c                    |   1 -
 sound/soc/codecs/adau1977-spi.c                    |   1 -
 sound/soc/codecs/adav801.c                         |   1 -
 sound/soc/codecs/ak4104.c                          |   1 -
 sound/soc/codecs/cs4271-spi.c                      |   1 -
 sound/soc/codecs/da7210.c                          |   1 -
 sound/soc/codecs/pcm1792a.c                        |   1 -
 sound/soc/codecs/pcm512x-spi.c                     |   1 -
 sound/soc/codecs/rt5677-spi.c                      |   1 -
 sound/soc/codecs/ssm2602-spi.c                     |   1 -
 sound/soc/codecs/tlv320aic23-spi.c                 |   1 -
 sound/soc/codecs/tlv320aic26.c                     |   1 -
 sound/soc/codecs/wm0010.c                          |   1 -
 sound/soc/codecs/wm8510.c                          |   1 -
 sound/soc/codecs/wm8711.c                          |   1 -
 sound/soc/codecs/wm8728.c                          |   1 -
 sound/soc/codecs/wm8731.c                          |   1 -
 sound/soc/codecs/wm8737.c                          |   1 -
 sound/soc/codecs/wm8741.c                          |   1 -
 sound/soc/codecs/wm8750.c                          |   1 -
 sound/soc/codecs/wm8753.c                          |   1 -
 sound/soc/codecs/wm8770.c                          |   1 -
 sound/soc/codecs/wm8776.c                          |   1 -
 sound/soc/codecs/wm8804-spi.c                      |   1 -
 sound/soc/codecs/wm8900.c                          |   1 -
 sound/soc/codecs/wm8983.c                          |   1 -
 sound/soc/codecs/wm8985.c                          |   1 -
 sound/soc/codecs/wm8988.c                          |   1 -
 sound/soc/codecs/wm8995.c                          |   1 -
 247 files changed, 1409 insertions(+), 931 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-aux-=
spi.txt
 create mode 100644 drivers/spi/spi-bcm2835aux.c

--tk6xM/wkRlnXD2NA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOzbSAAoJECTWi3JdVIfQAPQH/jEc95npuni2IechT1HbbCxo
b5uK44kfMFphh5FzyLkHXFqLR9/TgXM2kLoX02QaoR0CUMMuBeg3e/dB/fuf7FVh
Uq3HY6hyX0ZaGYFm/5v+tU9uHukvouqzxjuUV4XzeY7GeoOP0w27z8s3eibSqPEl
u6m9fWCnALHQtcSW86CIjGicATCDnyR9Le2DkhYKLUCkCuuapMC/IL1WqudB6gAD
Es9uCCOrlTJ6XDcdVZtX/VY+ZrEflf3+q0WX5vxiO8FMnfGiN+dy6zAHRKSGaiV0
FWpB+wB6E4akmmgCYLG3urY7q/u882zmVAOjWED34POQ3w3JyXwfXqbaM+cKuKk=
=eJfe
-----END PGP SIGNATURE-----

--tk6xM/wkRlnXD2NA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
