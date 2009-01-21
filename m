From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] eeprom: More consistent symbol names
Date: Wed, 21 Jan 2009 16:04:37 +0100
Message-ID: <20090121160437.6f131056@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Now that all EEPROM drivers live in the same place, let's harmonize
their symbol names.

Also fix eeprom's dependencies, it definitely needs sysfs, and is no
longer experimental after many years in the kernel tree.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 arch/arm/configs/afeb9260_defconfig               |    6 +++---
 arch/arm/configs/ams_delta_defconfig              |    2 +-
 arch/arm/configs/at91cap9adk_defconfig            |    4 ++--
 arch/arm/configs/at91rm9200dk_defconfig           |    2 +-
 arch/arm/configs/at91rm9200ek_defconfig           |    2 +-
 arch/arm/configs/at91sam9260ek_defconfig          |    2 +-
 arch/arm/configs/at91sam9261ek_defconfig          |    4 ++--
 arch/arm/configs/at91sam9263ek_defconfig          |    4 ++--
 arch/arm/configs/at91sam9g20ek_defconfig          |    2 +-
 arch/arm/configs/at91sam9rlek_defconfig           |    4 ++--
 arch/arm/configs/ateb9200_defconfig               |    2 +-
 arch/arm/configs/badge4_defconfig                 |    2 +-
 arch/arm/configs/cam60_defconfig                  |    4 ++--
 arch/arm/configs/cm_x300_defconfig                |    4 ++--
 arch/arm/configs/colibri_defconfig                |    2 +-
 arch/arm/configs/corgi_defconfig                  |    6 +++---
 arch/arm/configs/csb337_defconfig                 |    2 +-
 arch/arm/configs/csb637_defconfig                 |    2 +-
 arch/arm/configs/ecbat91_defconfig                |    4 ++--
 arch/arm/configs/ep93xx_defconfig                 |    2 +-
 arch/arm/configs/ezx_defconfig                    |    4 ++--
 arch/arm/configs/footbridge_defconfig             |    2 +-
 arch/arm/configs/iop13xx_defconfig                |    2 +-
 arch/arm/configs/iop32x_defconfig                 |    2 +-
 arch/arm/configs/iop33x_defconfig                 |    2 +-
 arch/arm/configs/ixp2000_defconfig                |    2 +-
 arch/arm/configs/ixp23xx_defconfig                |    2 +-
 arch/arm/configs/ixp4xx_defconfig                 |    2 +-
 arch/arm/configs/kafa_defconfig                   |    2 +-
 arch/arm/configs/kirkwood_defconfig               |    6 +++---
 arch/arm/configs/loki_defconfig                   |    4 ++--
 arch/arm/configs/magician_defconfig               |    2 +-
 arch/arm/configs/msm_defconfig                    |    2 +-
 arch/arm/configs/mv78xx0_defconfig                |    2 +-
 arch/arm/configs/n770_defconfig                   |    4 ++--
 arch/arm/configs/neocore926_defconfig             |    6 +++---
 arch/arm/configs/neponset_defconfig               |    2 +-
 arch/arm/configs/omap3_beagle_defconfig           |    4 ++--
 arch/arm/configs/omap3_pandora_defconfig          |    6 +++---
 arch/arm/configs/omap_2430sdp_defconfig           |    4 ++--
 arch/arm/configs/omap_apollon_2420_defconfig      |    2 +-
 arch/arm/configs/omap_generic_1510_defconfig      |    2 +-
 arch/arm/configs/omap_generic_1610_defconfig      |    2 +-
 arch/arm/configs/omap_h2_1610_defconfig           |    4 ++--
 arch/arm/configs/omap_h4_2420_defconfig           |    2 +-
 arch/arm/configs/omap_innovator_1510_defconfig    |    2 +-
 arch/arm/configs/omap_ldp_defconfig               |    6 +++---
 arch/arm/configs/omap_osk_5912_defconfig          |    2 +-
 arch/arm/configs/onearm_defconfig                 |    2 +-
 arch/arm/configs/orion5x_defconfig                |    4 ++--
 arch/arm/configs/overo_defconfig                  |    6 +++---
 arch/arm/configs/palmz71_defconfig                |    2 +-
 arch/arm/configs/palmz72_defconfig                |    6 +++---
 arch/arm/configs/pcm027_defconfig                 |    2 +-
 arch/arm/configs/pcm038_defconfig                 |    4 ++--
 arch/arm/configs/picotux200_defconfig             |    2 +-
 arch/arm/configs/pnx4008_defconfig                |    2 +-
 arch/arm/configs/qil-a9260_defconfig              |    4 ++--
 arch/arm/configs/rpc_defconfig                    |    2 +-
 arch/arm/configs/s3c2410_defconfig                |    4 ++--
 arch/arm/configs/s3c6400_defconfig                |    4 ++--
 arch/arm/configs/spitz_defconfig                  |    6 +++---
 arch/arm/configs/sx1_defconfig                    |    2 +-
 arch/arm/configs/trizeps4_defconfig               |    2 +-
 arch/arm/configs/usb-a9260_defconfig              |    2 +-
 arch/arm/configs/usb-a9263_defconfig              |    2 +-
 arch/arm/configs/versatile_defconfig              |    2 +-
 arch/arm/configs/viper_defconfig                  |    4 ++--
 arch/arm/configs/xm_x2xx_defconfig                |    4 ++--
 arch/arm/configs/yl9200_defconfig                 |    2 +-
 arch/avr32/configs/atngw100_defconfig             |    6 +++---
 arch/avr32/configs/atngw100_evklcd100_defconfig   |    4 ++--
 arch/avr32/configs/atngw100_evklcd101_defconfig   |    4 ++--
 arch/avr32/configs/atstk1002_defconfig            |    6 +++---
 arch/avr32/configs/atstk1003_defconfig            |    6 +++---
 arch/avr32/configs/atstk1004_defconfig            |    2 +-
 arch/avr32/configs/atstk1006_defconfig            |    6 +++---
 arch/avr32/configs/favr-32_defconfig              |    6 +++---
 arch/avr32/configs/hammerhead_defconfig           |    6 +++---
 arch/avr32/configs/mimc200_defconfig              |    6 +++---
 arch/blackfin/configs/BF518F-EZBRD_defconfig      |    4 ++--
 arch/blackfin/configs/BF526-EZBRD_defconfig       |    6 +++---
 arch/blackfin/configs/BF527-EZKIT_defconfig       |    6 +++---
 arch/blackfin/configs/BF533-EZKIT_defconfig       |    2 +-
 arch/blackfin/configs/BF533-STAMP_defconfig       |    6 +++---
 arch/blackfin/configs/BF537-STAMP_defconfig       |    6 +++---
 arch/blackfin/configs/BF538-EZKIT_defconfig       |    6 +++---
 arch/blackfin/configs/BF548-EZKIT_defconfig       |    6 +++---
 arch/blackfin/configs/BF561-EZKIT_defconfig       |    2 +-
 arch/blackfin/configs/BlackStamp_defconfig        |    4 ++--
 arch/blackfin/configs/CM-BF527_defconfig          |    4 ++--
 arch/blackfin/configs/CM-BF548_defconfig          |    4 ++--
 arch/blackfin/configs/H8606_defconfig             |    2 +-
 arch/blackfin/configs/IP0X_defconfig              |    2 +-
 arch/blackfin/configs/PNAV-10_defconfig           |    6 +++---
 arch/blackfin/configs/SRV1_defconfig              |    4 ++--
 arch/blackfin/configs/TCM-BF537_defconfig         |    2 +-
 arch/ia64/configs/bigsur_defconfig                |    2 +-
 arch/ia64/configs/zx1_defconfig                   |    2 +-
 arch/m32r/configs/m32104ut_defconfig              |    2 +-
 arch/mips/configs/bigsur_defconfig                |    2 +-
 arch/mips/configs/emma2rh_defconfig               |    2 +-
 arch/mips/configs/fulong_defconfig                |    4 ++--
 arch/mips/configs/msp71xx_defconfig               |    2 +-
 arch/mips/configs/mtx1_defconfig                  |    4 ++--
 arch/mips/configs/pnx8335-stb225_defconfig        |    4 ++--
 arch/mips/configs/rbtx49xx_defconfig              |    2 +-
 arch/powerpc/configs/44x/sam440ep_defconfig       |    4 ++--
 arch/powerpc/configs/44x/warp_defconfig           |    4 ++--
 arch/powerpc/configs/52xx/cm5200_defconfig        |    4 ++--
 arch/powerpc/configs/52xx/lite5200b_defconfig     |    4 ++--
 arch/powerpc/configs/52xx/motionpro_defconfig     |    4 ++--
 arch/powerpc/configs/52xx/pcm030_defconfig        |    4 ++--
 arch/powerpc/configs/52xx/tqm5200_defconfig       |    4 ++--
 arch/powerpc/configs/83xx/asp8347_defconfig       |    4 ++--
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    6 +++---
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   |    6 +++---
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   |    4 ++--
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   |    6 +++---
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   |    6 +++---
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig |    6 +++---
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   |    4 ++--
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   |    4 ++--
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig   |    6 +++---
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |    4 ++--
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |    4 ++--
 arch/powerpc/configs/83xx/sbc834x_defconfig       |    4 ++--
 arch/powerpc/configs/85xx/mpc8536_ds_defconfig    |    4 ++--
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig    |    4 ++--
 arch/powerpc/configs/85xx/mpc8568mds_defconfig    |    4 ++--
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig    |    4 ++--
 arch/powerpc/configs/85xx/stx_gp3_defconfig       |    4 ++--
 arch/powerpc/configs/85xx/tqm8540_defconfig       |    4 ++--
 arch/powerpc/configs/85xx/tqm8541_defconfig       |    4 ++--
 arch/powerpc/configs/85xx/tqm8548_defconfig       |    4 ++--
 arch/powerpc/configs/85xx/tqm8555_defconfig       |    4 ++--
 arch/powerpc/configs/85xx/tqm8560_defconfig       |    4 ++--
 arch/powerpc/configs/86xx/gef_sbc610_defconfig    |    4 ++--
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig  |    4 ++--
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig  |    4 ++--
 arch/powerpc/configs/86xx/sbc8641d_defconfig      |    4 ++--
 arch/powerpc/configs/c2k_defconfig                |    4 ++--
 arch/powerpc/configs/cell_defconfig               |    2 +-
 arch/powerpc/configs/celleb_defconfig             |    2 +-
 arch/powerpc/configs/chrp32_defconfig             |    4 ++--
 arch/powerpc/configs/g5_defconfig                 |    4 ++--
 arch/powerpc/configs/linkstation_defconfig        |    4 ++--
 arch/powerpc/configs/maple_defconfig              |    4 ++--
 arch/powerpc/configs/mpc5200_defconfig            |    4 ++--
 arch/powerpc/configs/mpc83xx_defconfig            |    4 ++--
 arch/powerpc/configs/mpc85xx_defconfig            |    4 ++--
 arch/powerpc/configs/mpc86xx_defconfig            |    4 ++--
 arch/powerpc/configs/pasemi_defconfig             |    2 +-
 arch/powerpc/configs/pmac32_defconfig             |    4 ++--
 arch/powerpc/configs/ppc40x_defconfig             |    4 ++--
 arch/powerpc/configs/ppc44x_defconfig             |    4 ++--
 arch/powerpc/configs/ppc64_defconfig              |    4 ++--
 arch/powerpc/configs/ppc6xx_defconfig             |    4 ++--
 arch/powerpc/configs/prpmc2800_defconfig          |    4 ++--
 arch/powerpc/configs/pseries_defconfig            |    4 ++--
 arch/powerpc/configs/storcenter_defconfig         |    4 ++--
 arch/sh/configs/cayman_defconfig                  |    4 ++--
 arch/sh/configs/edosk7760_defconfig               |    4 ++--
 arch/sh/configs/migor_defconfig                   |    4 ++--
 arch/sh/configs/r7780mp_defconfig                 |    4 ++--
 arch/sh/configs/r7785rp_defconfig                 |    4 ++--
 arch/sh/configs/rts7751r2d1_defconfig             |    2 +-
 arch/sh/configs/rts7751r2dplus_defconfig          |    2 +-
 arch/sh/configs/se7343_defconfig                  |    4 ++--
 arch/sh/configs/sh7785lcr_defconfig               |    4 ++--
 arch/sh/configs/shx3_defconfig                    |    6 +++---
 arch/sparc/configs/sparc64_defconfig              |    4 ++--
 arch/x86/configs/i386_defconfig                   |    4 ++--
 arch/x86/configs/x86_64_defconfig                 |    4 ++--
 drivers/misc/eeprom/Kconfig                       |    8 ++++----
 drivers/misc/eeprom/Makefile                      |    6 +++---
 176 files changed, 326 insertions(+), 326 deletions(-)

--- linux-2.6.29-rc2.orig/arch/arm/configs/afeb9260_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/afeb9260_defconfig	2009-01-21 15:58:21.000000000 +0100
@@ -719,8 +719,8 @@ CONFIG_I2C_GPIO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_AT24=y
-# CONFIG_SENSORS_EEPROM is not set
+CONFIG_EEPROM_AT24=y
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -744,7 +744,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=y
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/ams_delta_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ams_delta_defconfig	2009-01-21 15:44:56.000000000 +0100
@@ -767,7 +767,7 @@ CONFIG_I2C_OMAP=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91cap9adk_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91cap9adk_defconfig	2009-01-21 15:58:20.000000000 +0100
@@ -676,7 +676,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -703,7 +703,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91rm9200dk_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91rm9200dk_defconfig	2009-01-21 15:45:03.000000000 +0100
@@ -636,7 +636,7 @@ CONFIG_I2C_GPIO=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91rm9200ek_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91rm9200ek_defconfig	2009-01-21 15:45:05.000000000 +0100
@@ -610,7 +610,7 @@ CONFIG_I2C_GPIO=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91sam9260ek_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91sam9260ek_defconfig	2009-01-21 15:44:57.000000000 +0100
@@ -582,7 +582,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91sam9261ek_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91sam9261ek_defconfig	2009-01-21 15:58:18.000000000 +0100
@@ -660,7 +660,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -687,7 +687,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91sam9263ek_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91sam9263ek_defconfig	2009-01-21 15:58:22.000000000 +0100
@@ -670,7 +670,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -697,7 +697,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91sam9g20ek_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91sam9g20ek_defconfig	2009-01-21 15:58:21.000000000 +0100
@@ -665,7 +665,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=y
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/at91sam9rlek_defconfig	2009-01-06 20:24:21.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/at91sam9rlek_defconfig	2009-01-21 15:58:22.000000000 +0100
@@ -566,7 +566,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -593,7 +593,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/ateb9200_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ateb9200_defconfig	2009-01-21 15:45:07.000000000 +0100
@@ -723,7 +723,7 @@ CONFIG_I2C_GPIO=m
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/badge4_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/arm/configs/badge4_defconfig	2009-01-21 15:45:01.000000000 +0100
@@ -750,7 +750,7 @@ CONFIG_I2C_ELEKTOR=m
 # Other I2C Chip support
 #
 # CONFIG_SENSORS_DS1337 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/cam60_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/cam60_defconfig	2009-01-21 15:58:17.000000000 +0100
@@ -722,7 +722,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -749,7 +749,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/cm_x300_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/cm_x300_defconfig	2009-01-21 15:44:51.000000000 +0100
@@ -763,8 +763,8 @@ CONFIG_I2C_PXA=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/colibri_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/arm/configs/colibri_defconfig	2009-01-21 15:44:59.000000000 +0100
@@ -801,7 +801,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/corgi_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/corgi_defconfig	2009-01-21 15:58:21.000000000 +0100
@@ -982,8 +982,8 @@ CONFIG_I2C_PXA=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -1008,7 +1008,7 @@ CONFIG_SPI_PXA2XX=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/csb337_defconfig	2009-01-06 20:13:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/csb337_defconfig	2009-01-21 15:44:54.000000000 +0100
@@ -679,7 +679,7 @@ CONFIG_I2C_GPIO=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/csb637_defconfig	2009-01-06 20:13:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/csb637_defconfig	2009-01-21 15:44:52.000000000 +0100
@@ -704,7 +704,7 @@ CONFIG_I2C_CHARDEV=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/ecbat91_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ecbat91_defconfig	2009-01-21 15:58:18.000000000 +0100
@@ -721,7 +721,7 @@ CONFIG_I2C_GPIO=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -747,7 +747,7 @@ CONFIG_SPI_AT91=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 
 #
--- linux-2.6.29-rc2.orig/arch/arm/configs/ep93xx_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ep93xx_defconfig	2009-01-21 15:45:06.000000000 +0100
@@ -681,7 +681,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/ezx_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ezx_defconfig	2009-01-21 15:58:22.000000000 +0100
@@ -877,7 +877,7 @@ CONFIG_I2C_PXA=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -900,7 +900,7 @@ CONFIG_SPI_PXA2XX=m
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/footbridge_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/arm/configs/footbridge_defconfig	2009-01-21 15:44:58.000000000 +0100
@@ -801,7 +801,7 @@ CONFIG_I2C=m
 #
 # Other I2C Chip support
 #
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/iop13xx_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/iop13xx_defconfig	2009-01-21 15:45:09.000000000 +0100
@@ -744,7 +744,7 @@ CONFIG_I2C_IOP3XX=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/iop32x_defconfig	2009-01-06 20:20:57.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/iop32x_defconfig	2009-01-21 15:45:04.000000000 +0100
@@ -847,7 +847,7 @@ CONFIG_I2C_IOP3XX=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/iop33x_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/iop33x_defconfig	2009-01-21 15:44:49.000000000 +0100
@@ -746,7 +746,7 @@ CONFIG_I2C_IOP3XX=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/ixp2000_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ixp2000_defconfig	2009-01-21 15:44:55.000000000 +0100
@@ -768,7 +768,7 @@ CONFIG_I2C_IXP2000=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/ixp23xx_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ixp23xx_defconfig	2009-01-21 15:45:08.000000000 +0100
@@ -900,7 +900,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/ixp4xx_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/ixp4xx_defconfig	2009-01-21 15:44:55.000000000 +0100
@@ -1083,7 +1083,7 @@ CONFIG_I2C_IXP4XX=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/kafa_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/kafa_defconfig	2009-01-21 15:45:04.000000000 +0100
@@ -603,7 +603,7 @@ CONFIG_I2C_GPIO=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/kirkwood_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/kirkwood_defconfig	2009-01-21 15:58:19.000000000 +0100
@@ -905,8 +905,8 @@ CONFIG_I2C_MV64XXX=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -930,7 +930,7 @@ CONFIG_SPI_ORION=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/loki_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/loki_defconfig	2009-01-21 15:58:22.000000000 +0100
@@ -654,7 +654,7 @@ CONFIG_I2C_MV64XXX=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -675,7 +675,7 @@ CONFIG_SPI_MASTER=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/magician_defconfig	2009-01-06 20:13:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/magician_defconfig	2009-01-21 15:45:10.000000000 +0100
@@ -678,7 +678,7 @@ CONFIG_I2C_PXA=m
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/msm_defconfig	2009-01-06 20:24:21.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/msm_defconfig	2009-01-21 15:45:04.000000000 +0100
@@ -580,7 +580,7 @@ CONFIG_I2C_MSM=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 CONFIG_SENSORS_PCA9633=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/mv78xx0_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/mv78xx0_defconfig	2009-01-21 15:44:53.000000000 +0100
@@ -832,7 +832,7 @@ CONFIG_I2C_MV64XXX=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/n770_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/n770_defconfig	2009-01-21 15:58:19.000000000 +0100
@@ -767,7 +767,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -798,7 +798,7 @@ CONFIG_SPI_OMAP_UWIRE=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_TSC2101 is not set
 # CONFIG_SPI_TSC2102 is not set
 # CONFIG_SPI_TSC210X is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/neocore926_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/neocore926_defconfig	2009-01-21 15:58:16.000000000 +0100
@@ -774,8 +774,8 @@ CONFIG_I2C_CHARDEV=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -798,7 +798,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/neponset_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/arm/configs/neponset_defconfig	2009-01-21 15:44:57.000000000 +0100
@@ -737,7 +737,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # Other I2C Chip support
 #
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_SENSORS_RTC8564 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap3_beagle_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap3_beagle_defconfig	2009-01-21 15:44:56.000000000 +0100
@@ -687,8 +687,8 @@ CONFIG_I2C_OMAP=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap3_pandora_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap3_pandora_defconfig	2009-01-21 15:58:21.000000000 +0100
@@ -713,8 +713,8 @@ CONFIG_I2C_OMAP=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -740,7 +740,7 @@ CONFIG_SPI_OMAP24XX=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_2430sdp_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_2430sdp_defconfig	2009-01-21 15:58:20.000000000 +0100
@@ -710,7 +710,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -743,7 +743,7 @@ CONFIG_SPI_MASTER=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_TSC2101 is not set
 # CONFIG_SPI_TSC2102 is not set
 # CONFIG_SPI_TSC210X is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_apollon_2420_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_apollon_2420_defconfig	2009-01-21 15:58:19.000000000 +0100
@@ -612,7 +612,7 @@ CONFIG_SPI_OMAP24XX=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_TSC2101 is not set
 # CONFIG_SPI_TSC2102 is not set
 # CONFIG_SPI_TSC210X is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_generic_1510_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_generic_1510_defconfig	2009-01-21 15:45:00.000000000 +0100
@@ -637,7 +637,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_generic_1610_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_generic_1610_defconfig	2009-01-21 15:45:03.000000000 +0100
@@ -641,7 +641,7 @@ CONFIG_I2C_ALGOBIT=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_h2_1610_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_h2_1610_defconfig	2009-01-21 15:58:18.000000000 +0100
@@ -700,7 +700,7 @@ CONFIG_I2C_OMAP=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -731,7 +731,7 @@ CONFIG_SPI_OMAP_UWIRE=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_TSC2101=y
 # CONFIG_SPI_TSC2102 is not set
 # CONFIG_SPI_TSC210X is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_h4_2420_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_h4_2420_defconfig	2009-01-21 15:44:54.000000000 +0100
@@ -681,7 +681,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_innovator_1510_defconfig	2009-01-06 20:20:58.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_innovator_1510_defconfig	2009-01-21 15:45:07.000000000 +0100
@@ -631,7 +631,7 @@ CONFIG_I2C_BOARDINFO=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_ldp_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_ldp_defconfig	2009-01-21 15:58:16.000000000 +0100
@@ -629,8 +629,8 @@ CONFIG_I2C_OMAP=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -656,7 +656,7 @@ CONFIG_SPI_OMAP24XX=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/omap_osk_5912_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/omap_osk_5912_defconfig	2009-01-21 15:45:02.000000000 +0100
@@ -711,7 +711,7 @@ CONFIG_I2C_OMAP=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/onearm_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/onearm_defconfig	2009-01-21 15:45:06.000000000 +0100
@@ -698,7 +698,7 @@ CONFIG_I2C_CHARDEV=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/orion5x_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/orion5x_defconfig	2009-01-21 15:44:50.000000000 +0100
@@ -886,8 +886,8 @@ CONFIG_I2C_MV64XXX=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/overo_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/overo_defconfig	2009-01-21 15:58:19.000000000 +0100
@@ -858,8 +858,8 @@ CONFIG_I2C_OMAP=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -885,7 +885,7 @@ CONFIG_SPI_OMAP24XX=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/palmz71_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/palmz71_defconfig	2009-01-21 15:58:23.000000000 +0100
@@ -554,7 +554,7 @@ CONFIG_SPI_OMAP_UWIRE=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_TSC2101 is not set
 # CONFIG_SPI_TSC2102 is not set
 # CONFIG_SPI_TSC210X is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/palmz72_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/palmz72_defconfig	2009-01-21 15:58:17.000000000 +0100
@@ -527,8 +527,8 @@ CONFIG_I2C_PXA=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -552,7 +552,7 @@ CONFIG_SPI_MASTER=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=y
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/pcm027_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/arm/configs/pcm027_defconfig	2009-01-21 15:44:54.000000000 +0100
@@ -606,7 +606,7 @@ CONFIG_I2C_PXA=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/pcm038_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/pcm038_defconfig	2009-01-21 15:58:16.000000000 +0100
@@ -604,7 +604,7 @@ CONFIG_I2C_BOARDINFO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -626,7 +626,7 @@ CONFIG_SPI_BITBANG=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/picotux200_defconfig	2009-01-11 10:57:06.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/picotux200_defconfig	2009-01-21 15:45:04.000000000 +0100
@@ -744,7 +744,7 @@ CONFIG_I2C_GPIO=m
 #
 CONFIG_SENSORS_DS1337=m
 CONFIG_SENSORS_DS1374=m
-CONFIG_SENSORS_EEPROM=m
+CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 CONFIG_SENSORS_PCA9539=m
 CONFIG_SENSORS_PCF8591=m
--- linux-2.6.29-rc2.orig/arch/arm/configs/pnx4008_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/pnx4008_defconfig	2009-01-21 15:45:10.000000000 +0100
@@ -915,7 +915,7 @@ CONFIG_I2C_ALGOPCA=m
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-CONFIG_SENSORS_EEPROM=m
+CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 # CONFIG_SENSORS_PCA9539 is not set
 CONFIG_SENSORS_PCF8591=m
--- linux-2.6.29-rc2.orig/arch/arm/configs/qil-a9260_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/qil-a9260_defconfig	2009-01-21 15:58:19.000000000 +0100
@@ -687,7 +687,7 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -714,7 +714,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/rpc_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/rpc_defconfig	2009-01-21 15:45:01.000000000 +0100
@@ -590,7 +590,7 @@ CONFIG_I2C_ACORN=y
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/s3c2410_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/s3c2410_defconfig	2009-01-21 15:58:17.000000000 +0100
@@ -923,7 +923,7 @@ CONFIG_I2C_SIMTEC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_SENSORS_EEPROM=m
+CONFIG_EEPROM_LEGACY=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -950,7 +950,7 @@ CONFIG_SPI_S3C24XX_GPIO=m
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/s3c6400_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/s3c6400_defconfig	2009-01-21 15:45:09.000000000 +0100
@@ -465,8 +465,8 @@ CONFIG_I2C_S3C2410=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_AT24=y
-# CONFIG_SENSORS_EEPROM is not set
+CONFIG_EEPROM_AT24=y
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/spitz_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/spitz_defconfig	2009-01-21 15:58:20.000000000 +0100
@@ -977,8 +977,8 @@ CONFIG_I2C_PXA=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -1003,7 +1003,7 @@ CONFIG_SPI_PXA2XX=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/arm/configs/sx1_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/sx1_defconfig	2009-01-21 15:45:09.000000000 +0100
@@ -610,7 +610,7 @@ CONFIG_I2C_OMAP=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/trizeps4_defconfig	2009-01-06 20:24:21.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/trizeps4_defconfig	2009-01-21 15:45:07.000000000 +0100
@@ -948,7 +948,7 @@ CONFIG_I2C_PXA_SLAVE=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/usb-a9260_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/usb-a9260_defconfig	2009-01-21 15:58:17.000000000 +0100
@@ -676,7 +676,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/usb-a9263_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/usb-a9263_defconfig	2009-01-21 15:58:20.000000000 +0100
@@ -668,7 +668,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/versatile_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/versatile_defconfig	2009-01-21 15:45:03.000000000 +0100
@@ -611,7 +611,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-CONFIG_SENSORS_EEPROM=m
+CONFIG_EEPROM_LEGACY=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/viper_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/viper_defconfig	2009-01-21 15:44:55.000000000 +0100
@@ -860,8 +860,8 @@ CONFIG_I2C_PXA=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/xm_x2xx_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/xm_x2xx_defconfig	2009-01-21 15:44:51.000000000 +0100
@@ -1009,8 +1009,8 @@ CONFIG_I2C_PXA=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/arm/configs/yl9200_defconfig	2009-01-06 20:20:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/arm/configs/yl9200_defconfig	2009-01-21 15:58:18.000000000 +0100
@@ -682,7 +682,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
--- linux-2.6.29-rc2.orig/arch/avr32/configs/atngw100_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/atngw100_defconfig	2009-01-21 15:58:09.000000000 +0100
@@ -644,8 +644,8 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_AT24=m
-# CONFIG_SENSORS_EEPROM is not set
+CONFIG_EEPROM_AT24=m
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -670,7 +670,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/atngw100_evklcd100_defconfig	2009-01-06 20:24:24.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/atngw100_evklcd100_defconfig	2009-01-21 15:58:10.000000000 +0100
@@ -671,7 +671,7 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -699,7 +699,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/atngw100_evklcd101_defconfig	2009-01-06 20:24:24.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/atngw100_evklcd101_defconfig	2009-01-21 15:58:09.000000000 +0100
@@ -671,7 +671,7 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -699,7 +699,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/atstk1002_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/atstk1002_defconfig	2009-01-21 15:58:09.000000000 +0100
@@ -663,8 +663,8 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_AT24=m
-# CONFIG_SENSORS_EEPROM is not set
+CONFIG_EEPROM_AT24=m
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -689,7 +689,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/atstk1003_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/atstk1003_defconfig	2009-01-21 15:58:08.000000000 +0100
@@ -611,8 +611,8 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_AT24=m
-# CONFIG_SENSORS_EEPROM is not set
+CONFIG_EEPROM_AT24=m
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -637,7 +637,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/atstk1004_defconfig	2009-01-06 20:21:02.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/atstk1004_defconfig	2009-01-21 15:58:10.000000000 +0100
@@ -394,7 +394,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/atstk1006_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/atstk1006_defconfig	2009-01-21 15:58:10.000000000 +0100
@@ -684,8 +684,8 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -710,7 +710,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/favr-32_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/favr-32_defconfig	2009-01-21 15:58:09.000000000 +0100
@@ -633,8 +633,8 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -659,7 +659,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/hammerhead_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/hammerhead_defconfig	2009-01-21 15:58:08.000000000 +0100
@@ -716,8 +716,8 @@ CONFIG_I2C_GPIO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -742,7 +742,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/avr32/configs/mimc200_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/avr32/configs/mimc200_defconfig	2009-01-21 15:58:10.000000000 +0100
@@ -565,8 +565,8 @@ CONFIG_I2C_GPIO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_AT24=y
-# CONFIG_SENSORS_EEPROM is not set
+CONFIG_EEPROM_AT24=y
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -592,7 +592,7 @@ CONFIG_SPI_ATMEL=y
 #
 # SPI Protocol Masters
 #
-CONFIG_SPI_AT25=y
+CONFIG_EEPROM_AT25=y
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF518F-EZBRD_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF518F-EZBRD_defconfig	2009-01-21 15:44:29.000000000 +0100
@@ -746,9 +746,9 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF526-EZBRD_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF526-EZBRD_defconfig	2009-01-21 15:58:11.000000000 +0100
@@ -793,9 +793,9 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -820,7 +820,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF527-EZKIT_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF527-EZKIT_defconfig	2009-01-21 15:58:12.000000000 +0100
@@ -837,9 +837,9 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -864,7 +864,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF533-EZKIT_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF533-EZKIT_defconfig	2009-01-21 15:58:12.000000000 +0100
@@ -719,7 +719,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF533-STAMP_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF533-STAMP_defconfig	2009-01-21 15:58:14.000000000 +0100
@@ -743,9 +743,9 @@ CONFIG_I2C_HELPER_AUTO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -770,7 +770,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF537-STAMP_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF537-STAMP_defconfig	2009-01-21 15:58:12.000000000 +0100
@@ -794,9 +794,9 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 CONFIG_SENSORS_AD5252=m
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -821,7 +821,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF538-EZKIT_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF538-EZKIT_defconfig	2009-01-21 15:58:11.000000000 +0100
@@ -796,9 +796,9 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -823,7 +823,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF548-EZKIT_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF548-EZKIT_defconfig	2009-01-21 15:58:13.000000000 +0100
@@ -928,9 +928,9 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -955,7 +955,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BF561-EZKIT_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BF561-EZKIT_defconfig	2009-01-21 15:58:13.000000000 +0100
@@ -756,7 +756,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/BlackStamp_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/BlackStamp_defconfig	2009-01-21 15:58:12.000000000 +0100
@@ -691,7 +691,7 @@ CONFIG_I2C_GPIO=m
 #
 # CONFIG_DS1682 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
@@ -713,7 +713,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-CONFIG_SPI_AT25=y
+CONFIG_EEPROM_AT25=y
 CONFIG_SPI_SPIDEV=m
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/CM-BF527_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/CM-BF527_defconfig	2009-01-21 15:58:13.000000000 +0100
@@ -715,7 +715,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -742,7 +742,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/CM-BF548_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/CM-BF548_defconfig	2009-01-21 15:58:13.000000000 +0100
@@ -798,7 +798,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8575 is not set
 # CONFIG_SENSORS_PCA9543 is not set
@@ -826,7 +826,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/H8606_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/H8606_defconfig	2009-01-21 15:58:11.000000000 +0100
@@ -750,7 +750,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-CONFIG_SPI_AT25=y
+CONFIG_EEPROM_AT25=y
 CONFIG_SPI_SPIDEV=y
 
 #
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/IP0X_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/IP0X_defconfig	2009-01-21 15:58:11.000000000 +0100
@@ -803,7 +803,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 
 #
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/PNAV-10_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/PNAV-10_defconfig	2009-01-21 15:58:12.000000000 +0100
@@ -755,9 +755,9 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
+# CONFIG_EEPROM_AT24 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 CONFIG_SENSORS_PCF8574=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -781,7 +781,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/SRV1_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/SRV1_defconfig	2009-01-21 15:58:14.000000000 +0100
@@ -798,7 +798,7 @@ CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_SENSORS_AD5252 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCF8575 is not set
 # CONFIG_SENSORS_PCA9543 is not set
@@ -826,7 +826,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-CONFIG_SPI_AT25=m
+CONFIG_EEPROM_AT25=m
 # CONFIG_SPI_SPIDEV is not set
 
 #
--- linux-2.6.29-rc2.orig/arch/blackfin/configs/TCM-BF537_defconfig	2009-01-11 10:57:08.000000000 +0100
+++ linux-2.6.29-rc2/arch/blackfin/configs/TCM-BF537_defconfig	2009-01-21 15:58:14.000000000 +0100
@@ -533,7 +533,7 @@ CONFIG_SPI_BFIN=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/ia64/configs/bigsur_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/ia64/configs/bigsur_defconfig	2009-01-21 15:44:24.000000000 +0100
@@ -752,7 +752,7 @@ CONFIG_I2C_ALGOBIT=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/ia64/configs/zx1_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/ia64/configs/zx1_defconfig	2009-01-21 15:44:24.000000000 +0100
@@ -841,7 +841,7 @@ CONFIG_I2C_ALGOPCF=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/m32r/configs/m32104ut_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/m32r/configs/m32104ut_defconfig	2009-01-21 15:45:10.000000000 +0100
@@ -621,7 +621,7 @@ CONFIG_I2C_ELEKTOR=m
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/mips/configs/bigsur_defconfig	2009-01-06 20:21:04.000000000 +0100
+++ linux-2.6.29-rc2/arch/mips/configs/bigsur_defconfig	2009-01-21 15:45:13.000000000 +0100
@@ -959,7 +959,7 @@ CONFIG_I2C_SIBYTE=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_EEPROM_LEGACY=y
 CONFIG_SENSORS_PCF8574=y
 # CONFIG_PCF8575 is not set
 CONFIG_SENSORS_PCF8591=y
--- linux-2.6.29-rc2.orig/arch/mips/configs/emma2rh_defconfig	2009-01-06 20:21:04.000000000 +0100
+++ linux-2.6.29-rc2/arch/mips/configs/emma2rh_defconfig	2009-01-21 15:45:11.000000000 +0100
@@ -996,7 +996,7 @@ CONFIG_I2C_CHARDEV=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_SENSORS_PCA9539 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/mips/configs/fulong_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/mips/configs/fulong_defconfig	2009-01-21 15:45:12.000000000 +0100
@@ -1006,8 +1006,8 @@ CONFIG_I2C_VIAPRO=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/mips/configs/msp71xx_defconfig	2009-01-06 20:21:04.000000000 +0100
+++ linux-2.6.29-rc2/arch/mips/configs/msp71xx_defconfig	2009-01-21 15:45:13.000000000 +0100
@@ -929,7 +929,7 @@ CONFIG_I2C_PMCMSP=y
 #
 # CONFIG_SENSORS_DS1337 is not set
 # CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 CONFIG_PMCTWILED=y
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/mips/configs/mtx1_defconfig	2009-01-06 20:21:04.000000000 +0100
+++ linux-2.6.29-rc2/arch/mips/configs/mtx1_defconfig	2009-01-21 15:58:23.000000000 +0100
@@ -1845,7 +1845,7 @@ CONFIG_I2C_VOODOO3=m
 CONFIG_SENSORS_DS1337=m
 CONFIG_SENSORS_DS1374=m
 # CONFIG_DS1682 is not set
-CONFIG_SENSORS_EEPROM=m
+CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 CONFIG_SENSORS_PCA9539=m
 CONFIG_SENSORS_PCF8591=m
@@ -1872,7 +1872,7 @@ CONFIG_SPI_BUTTERFLY=m
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_W1=m
--- linux-2.6.29-rc2.orig/arch/mips/configs/pnx8335-stb225_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/mips/configs/pnx8335-stb225_defconfig	2009-01-21 15:45:11.000000000 +0100
@@ -640,8 +640,8 @@ CONFIG_I2C_CHARDEV=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/mips/configs/rbtx49xx_defconfig	2009-01-06 20:21:04.000000000 +0100
+++ linux-2.6.29-rc2/arch/mips/configs/rbtx49xx_defconfig	2009-01-21 15:58:23.000000000 +0100
@@ -522,7 +522,7 @@ CONFIG_SPI_TXX9=y
 #
 # SPI Protocol Masters
 #
-CONFIG_SPI_AT25=y
+CONFIG_EEPROM_AT25=y
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_HAVE_GPIO_LIB=y
 
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/44x/sam440ep_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/44x/sam440ep_defconfig	2009-01-21 15:44:39.000000000 +0100
@@ -730,8 +730,8 @@ CONFIG_I2C_IBM_IIC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/44x/warp_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/44x/warp_defconfig	2009-01-21 15:44:39.000000000 +0100
@@ -660,8 +660,8 @@ CONFIG_I2C_HELPER_AUTO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/52xx/cm5200_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/52xx/cm5200_defconfig	2009-01-21 15:44:35.000000000 +0100
@@ -629,8 +629,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/52xx/lite5200b_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/52xx/lite5200b_defconfig	2009-01-21 15:44:34.000000000 +0100
@@ -762,8 +762,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/52xx/motionpro_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/52xx/motionpro_defconfig	2009-01-21 15:44:34.000000000 +0100
@@ -629,8 +629,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/52xx/pcm030_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/52xx/pcm030_defconfig	2009-01-21 15:44:35.000000000 +0100
@@ -740,8 +740,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=m
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/52xx/tqm5200_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/52xx/tqm5200_defconfig	2009-01-21 15:44:35.000000000 +0100
@@ -645,8 +645,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/asp8347_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/asp8347_defconfig	2009-01-21 15:44:41.000000000 +0100
@@ -732,8 +732,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig	2009-01-21 15:58:15.000000000 +0100
@@ -858,8 +858,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -884,7 +884,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig	2009-01-21 15:58:14.000000000 +0100
@@ -919,8 +919,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -945,7 +945,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc832x_mds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc832x_mds_defconfig	2009-01-21 15:44:45.000000000 +0100
@@ -730,8 +730,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig	2009-01-21 15:58:16.000000000 +0100
@@ -745,8 +745,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -770,7 +770,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc834x_itx_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc834x_itx_defconfig	2009-01-21 15:58:15.000000000 +0100
@@ -898,8 +898,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 CONFIG_SENSORS_PCF8574=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -923,7 +923,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig	2009-01-21 15:58:15.000000000 +0100
@@ -778,8 +778,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 CONFIG_SENSORS_PCF8574=y
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -803,7 +803,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc834x_mds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc834x_mds_defconfig	2009-01-21 15:44:42.000000000 +0100
@@ -673,8 +673,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc836x_mds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc836x_mds_defconfig	2009-01-21 15:44:42.000000000 +0100
@@ -805,8 +805,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig	2009-01-21 15:58:15.000000000 +0100
@@ -723,8 +723,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -749,7 +749,7 @@ CONFIG_SPI_MPC83xx=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 CONFIG_SPI_SPIDEV=y
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc837x_mds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc837x_mds_defconfig	2009-01-21 15:44:41.000000000 +0100
@@ -787,8 +787,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig	2009-01-21 15:44:44.000000000 +0100
@@ -789,8 +789,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/83xx/sbc834x_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/83xx/sbc834x_defconfig	2009-01-21 15:44:43.000000000 +0100
@@ -640,8 +640,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/mpc8536_ds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/mpc8536_ds_defconfig	2009-01-21 15:44:33.000000000 +0100
@@ -849,8 +849,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/mpc8544_ds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/mpc8544_ds_defconfig	2009-01-21 15:44:32.000000000 +0100
@@ -848,8 +848,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/mpc8568mds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/mpc8568mds_defconfig	2009-01-21 15:44:33.000000000 +0100
@@ -723,8 +723,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/mpc8572_ds_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/mpc8572_ds_defconfig	2009-01-21 15:44:34.000000000 +0100
@@ -861,8 +861,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/stx_gp3_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/stx_gp3_defconfig	2009-01-21 15:44:31.000000000 +0100
@@ -877,8 +877,8 @@ CONFIG_I2C_HELPER_AUTO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/tqm8540_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/tqm8540_defconfig	2009-01-21 15:44:33.000000000 +0100
@@ -787,8 +787,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/tqm8541_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/tqm8541_defconfig	2009-01-21 15:44:30.000000000 +0100
@@ -796,8 +796,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/tqm8548_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/tqm8548_defconfig	2009-01-21 15:44:31.000000000 +0100
@@ -806,8 +806,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/tqm8555_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/tqm8555_defconfig	2009-01-21 15:44:31.000000000 +0100
@@ -796,8 +796,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/85xx/tqm8560_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/85xx/tqm8560_defconfig	2009-01-21 15:44:32.000000000 +0100
@@ -796,8 +796,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/86xx/gef_sbc610_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/86xx/gef_sbc610_defconfig	2009-01-21 15:44:46.000000000 +0100
@@ -1081,8 +1081,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 CONFIG_DS1682=y
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig	2009-01-21 15:44:46.000000000 +0100
@@ -905,8 +905,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig	2009-01-21 15:44:46.000000000 +0100
@@ -851,8 +851,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/86xx/sbc8641d_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/86xx/sbc8641d_defconfig	2009-01-21 15:44:47.000000000 +0100
@@ -958,8 +958,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/c2k_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/c2k_defconfig	2009-01-21 15:44:45.000000000 +0100
@@ -1124,8 +1124,8 @@ CONFIG_I2C_MV64XXX=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=m
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/cell_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/powerpc/configs/cell_defconfig	2009-01-21 15:44:40.000000000 +0100
@@ -1012,7 +1012,7 @@ CONFIG_I2C_ALGOBIT=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/celleb_defconfig	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/arch/powerpc/configs/celleb_defconfig	2009-01-21 15:44:37.000000000 +0100
@@ -834,7 +834,7 @@ CONFIG_I2C_ALGOBIT=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/chrp32_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/chrp32_defconfig	2009-01-21 15:44:29.000000000 +0100
@@ -941,8 +941,8 @@ CONFIG_I2C_ALGOBIT=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/g5_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/g5_defconfig	2009-01-21 15:44:48.000000000 +0100
@@ -994,8 +994,8 @@ CONFIG_I2C_POWERMAC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/linkstation_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/linkstation_defconfig	2009-01-21 15:44:38.000000000 +0100
@@ -1015,8 +1015,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=m
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=m
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/maple_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/maple_defconfig	2009-01-21 15:44:30.000000000 +0100
@@ -866,8 +866,8 @@ CONFIG_I2C_AMD8111=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/mpc5200_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/mpc5200_defconfig	2009-01-21 15:44:47.000000000 +0100
@@ -844,8 +844,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/mpc83xx_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/mpc83xx_defconfig	2009-01-21 15:44:48.000000000 +0100
@@ -902,8 +902,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/mpc85xx_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/mpc85xx_defconfig	2009-01-21 15:44:37.000000000 +0100
@@ -860,8 +860,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/mpc86xx_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/mpc86xx_defconfig	2009-01-21 15:44:36.000000000 +0100
@@ -852,8 +852,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-CONFIG_SENSORS_EEPROM=y
+# CONFIG_EEPROM_AT24 is not set
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/pasemi_defconfig	2009-01-06 20:13:59.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/pasemi_defconfig	2009-01-21 15:44:37.000000000 +0100
@@ -984,7 +984,7 @@ CONFIG_I2C_PASEMI=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_SENSORS_EEPROM=y
+CONFIG_EEPROM_LEGACY=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/pmac32_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/pmac32_defconfig	2009-01-21 15:44:38.000000000 +0100
@@ -1232,8 +1232,8 @@ CONFIG_I2C_POWERMAC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/ppc40x_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/ppc40x_defconfig	2009-01-21 15:44:39.000000000 +0100
@@ -745,8 +745,8 @@ CONFIG_I2C_IBM_IIC=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/ppc44x_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/ppc44x_defconfig	2009-01-21 15:44:48.000000000 +0100
@@ -794,8 +794,8 @@ CONFIG_I2C_IBM_IIC=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/ppc64_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/ppc64_defconfig	2009-01-21 15:44:49.000000000 +0100
@@ -1261,8 +1261,8 @@ CONFIG_I2C_PASEMI=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/ppc6xx_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/ppc6xx_defconfig	2009-01-21 15:44:38.000000000 +0100
@@ -1801,8 +1801,8 @@ CONFIG_I2C_STUB=m
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-CONFIG_AT24=m
-CONFIG_SENSORS_EEPROM=m
+CONFIG_EEPROM_AT24=m
+CONFIG_EEPROM_LEGACY=m
 CONFIG_SENSORS_PCF8574=m
 CONFIG_PCF8575=m
 CONFIG_SENSORS_PCA9539=m
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/prpmc2800_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/prpmc2800_defconfig	2009-01-21 15:44:36.000000000 +0100
@@ -943,8 +943,8 @@ CONFIG_I2C_MV64XXX=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/pseries_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/pseries_defconfig	2009-01-21 15:44:40.000000000 +0100
@@ -1055,8 +1055,8 @@ CONFIG_I2C_ALGOBIT=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/powerpc/configs/storcenter_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/powerpc/configs/storcenter_defconfig	2009-01-21 15:44:30.000000000 +0100
@@ -795,8 +795,8 @@ CONFIG_I2C_MPC=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/cayman_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/cayman_defconfig	2009-01-21 15:44:20.000000000 +0100
@@ -700,8 +700,8 @@ CONFIG_I2C_HELPER_AUTO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/edosk7760_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/edosk7760_defconfig	2009-01-21 15:44:19.000000000 +0100
@@ -632,8 +632,8 @@ CONFIG_I2C_SH7760=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/migor_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/migor_defconfig	2009-01-21 15:44:20.000000000 +0100
@@ -684,8 +684,8 @@ CONFIG_I2C_SH_MOBILE=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/r7780mp_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/r7780mp_defconfig	2009-01-21 15:44:19.000000000 +0100
@@ -836,8 +836,8 @@ CONFIG_I2C_HIGHLANDER=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/r7785rp_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/r7785rp_defconfig	2009-01-21 15:44:18.000000000 +0100
@@ -838,8 +838,8 @@ CONFIG_I2C_HIGHLANDER=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/rts7751r2d1_defconfig	2009-01-06 20:24:35.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/rts7751r2d1_defconfig	2009-01-21 15:58:08.000000000 +0100
@@ -777,7 +777,7 @@ CONFIG_SPI_SH_SCI=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/rts7751r2dplus_defconfig	2009-01-06 20:24:35.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/rts7751r2dplus_defconfig	2009-01-21 15:58:07.000000000 +0100
@@ -777,7 +777,7 @@ CONFIG_SPI_SH_SCI=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/se7343_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/se7343_defconfig	2009-01-21 15:44:18.000000000 +0100
@@ -661,8 +661,8 @@ CONFIG_I2C_SH_MOBILE=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/sh7785lcr_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/sh7785lcr_defconfig	2009-01-21 15:44:19.000000000 +0100
@@ -823,8 +823,8 @@ CONFIG_I2C_PCA_PLATFORM=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/sh/configs/shx3_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sh/configs/shx3_defconfig	2009-01-21 15:58:08.000000000 +0100
@@ -653,8 +653,8 @@ CONFIG_I2C_HELPER_AUTO=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
@@ -678,7 +678,7 @@ CONFIG_SPI_MASTER=y
 #
 # SPI Protocol Masters
 #
-# CONFIG_SPI_AT25 is not set
+# CONFIG_EEPROM_AT25 is not set
 # CONFIG_SPI_SPIDEV is not set
 # CONFIG_SPI_TLE62X0 is not set
 # CONFIG_W1 is not set
--- linux-2.6.29-rc2.orig/arch/sparc/configs/sparc64_defconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/arch/sparc/configs/sparc64_defconfig	2009-01-21 15:44:16.000000000 +0100
@@ -867,8 +867,8 @@ CONFIG_I2C_ALGOBIT=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/x86/configs/i386_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/x86/configs/i386_defconfig	2009-01-21 15:45:10.000000000 +0100
@@ -1331,8 +1331,8 @@ CONFIG_I2C_I801=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/arch/x86/configs/x86_64_defconfig	2009-01-21 15:38:48.000000000 +0100
+++ linux-2.6.29-rc2/arch/x86/configs/x86_64_defconfig	2009-01-21 15:45:11.000000000 +0100
@@ -1311,8 +1311,8 @@ CONFIG_I2C_I801=y
 # Miscellaneous I2C Chip support
 #
 # CONFIG_DS1682 is not set
-# CONFIG_AT24 is not set
-# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_EEPROM_AT24 is not set
+# CONFIG_EEPROM_LEGACY is not set
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCA9539 is not set
--- linux-2.6.29-rc2.orig/drivers/misc/eeprom/Kconfig	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/drivers/misc/eeprom/Kconfig	2009-01-21 15:39:13.000000000 +0100
@@ -1,6 +1,6 @@
 menu "EEPROM support"
 
-config AT24
+config EEPROM_AT24
 	tristate "I2C EEPROMs from most vendors"
 	depends on I2C && SYSFS && EXPERIMENTAL
 	help
@@ -26,7 +26,7 @@ config AT24
 	  This driver can also be built as a module.  If so, the module
 	  will be called at24.
 
-config SPI_AT25
+config EEPROM_AT25
 	tristate "SPI EEPROMs from most vendors"
 	depends on SPI && SYSFS
 	help
@@ -37,9 +37,9 @@ config SPI_AT25
 	  This driver can also be built as a module.  If so, the module
 	  will be called at25.
 
-config SENSORS_EEPROM
+config EEPROM_LEGACY
 	tristate "Old I2C EEPROM reader"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C && SYSFS
 	help
 	  If you say yes here you get read-only access to the EEPROM data
 	  available on modern memory DIMMs and Sony Vaio laptops via I2C. Such
--- linux-2.6.29-rc2.orig/drivers/misc/eeprom/Makefile	2009-01-21 15:38:49.000000000 +0100
+++ linux-2.6.29-rc2/drivers/misc/eeprom/Makefile	2009-01-21 15:39:13.000000000 +0100
@@ -1,4 +1,4 @@
-obj-$(CONFIG_AT24)		+= at24.o
-obj-$(CONFIG_SPI_AT25)		+= at25.o
-obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
+obj-$(CONFIG_EEPROM_AT24)	+= at24.o
+obj-$(CONFIG_EEPROM_AT25)	+= at25.o
+obj-$(CONFIG_EEPROM_LEGACY)	+= eeprom.o
 obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o


-- 
Jean Delvare
