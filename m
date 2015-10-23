From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 2/2] Drop owner assignment from spi_drivers
Date: Fri, 23 Oct 2015 08:59:11 -0500
Message-ID: <1445608751-8432-3-git-send-email-afd@ti.com>
References: <1445608751-8432-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Andrew F. Davis" <afd@ti.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445608751-8432-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

An spi_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-u300/dummyspichip.c                                 | 1 -
 arch/mips/txx9/generic/spi_eeprom.c                               | 1 -
 drivers/char/tpm/st33zp24/spi.c                                   | 1 -
 drivers/gpio/gpio-74x164.c                                        | 1 -
 drivers/gpio/gpio-max7301.c                                       | 1 -
 drivers/gpio/gpio-mc33880.c                                       | 1 -
 drivers/gpio/gpio-mcp23s08.c                                      | 2 --
 drivers/gpu/drm/panel/panel-lg-lg4573.c                           | 1 -
 drivers/gpu/drm/panel/panel-samsung-ld9040.c                      | 1 -
 drivers/hwmon/ad7314.c                                            | 1 -
 drivers/hwmon/adcxx.c                                             | 1 -
 drivers/hwmon/ads7871.c                                           | 1 -
 drivers/hwmon/adt7310.c                                           | 1 -
 drivers/hwmon/lm70.c                                              | 1 -
 drivers/hwmon/max1111.c                                           | 1 -
 drivers/iio/accel/kxsd9.c                                         | 1 -
 drivers/iio/accel/st_accel_spi.c                                  | 1 -
 drivers/iio/adc/ad7266.c                                          | 1 -
 drivers/iio/adc/ad7298.c                                          | 1 -
 drivers/iio/adc/ad7476.c                                          | 1 -
 drivers/iio/adc/ad7791.c                                          | 1 -
 drivers/iio/adc/ad7793.c                                          | 1 -
 drivers/iio/adc/ad7887.c                                          | 1 -
 drivers/iio/adc/ad7923.c                                          | 1 -
 drivers/iio/adc/max1027.c                                         | 1 -
 drivers/iio/adc/mcp320x.c                                         | 1 -
 drivers/iio/adc/ti-adc128s052.c                                   | 1 -
 drivers/iio/amplifiers/ad8366.c                                   | 1 -
 drivers/iio/common/ssp_sensors/ssp_dev.c                          | 1 -
 drivers/iio/dac/ad5064.c                                          | 1 -
 drivers/iio/dac/ad5360.c                                          | 1 -
 drivers/iio/dac/ad5380.c                                          | 1 -
 drivers/iio/dac/ad5421.c                                          | 1 -
 drivers/iio/dac/ad5446.c                                          | 1 -
 drivers/iio/dac/ad5449.c                                          | 1 -
 drivers/iio/dac/ad5504.c                                          | 1 -
 drivers/iio/dac/ad5624r_spi.c                                     | 1 -
 drivers/iio/dac/ad5686.c                                          | 1 -
 drivers/iio/dac/ad5755.c                                          | 1 -
 drivers/iio/dac/ad5764.c                                          | 1 -
 drivers/iio/dac/ad5791.c                                          | 1 -
 drivers/iio/dac/ad7303.c                                          | 1 -
 drivers/iio/dac/mcp4922.c                                         | 1 -
 drivers/iio/frequency/ad9523.c                                    | 1 -
 drivers/iio/frequency/adf4350.c                                   | 1 -
 drivers/iio/gyro/adis16080.c                                      | 1 -
 drivers/iio/gyro/adis16130.c                                      | 1 -
 drivers/iio/gyro/adis16136.c                                      | 1 -
 drivers/iio/gyro/adis16260.c                                      | 1 -
 drivers/iio/gyro/adxrs450.c                                       | 1 -
 drivers/iio/gyro/st_gyro_spi.c                                    | 1 -
 drivers/iio/imu/adis16400_core.c                                  | 1 -
 drivers/iio/imu/adis16480.c                                       | 1 -
 drivers/iio/magnetometer/st_magn_spi.c                            | 1 -
 drivers/iio/pressure/ms5611_spi.c                                 | 1 -
 drivers/iio/pressure/st_pressure_spi.c                            | 1 -
 drivers/iio/proximity/as3935.c                                    | 1 -
 drivers/input/misc/ad714x-spi.c                                   | 1 -
 drivers/input/misc/adxl34x-spi.c                                  | 1 -
 drivers/input/touchscreen/ad7877.c                                | 1 -
 drivers/input/touchscreen/ad7879-spi.c                            | 1 -
 drivers/input/touchscreen/ads7846.c                               | 1 -
 drivers/input/touchscreen/cyttsp4_spi.c                           | 1 -
 drivers/input/touchscreen/cyttsp_spi.c                            | 1 -
 drivers/input/touchscreen/tsc2005.c                               | 1 -
 drivers/leds/leds-dac124s085.c                                    | 1 -
 drivers/media/i2c/s5c73m3/s5c73m3-spi.c                           | 1 -
 drivers/media/tuners/msi001.c                                     | 1 -
 drivers/mfd/arizona-spi.c                                         | 1 -
 drivers/mfd/cros_ec_spi.c                                         | 1 -
 drivers/mfd/da9052-spi.c                                          | 1 -
 drivers/mfd/ezx-pcap.c                                            | 1 -
 drivers/mfd/mc13xxx-spi.c                                         | 1 -
 drivers/mfd/stmpe-spi.c                                           | 1 -
 drivers/mfd/tps65912-spi.c                                        | 1 -
 drivers/mfd/wm831x-spi.c                                          | 1 -
 drivers/misc/ad525x_dpot-spi.c                                    | 1 -
 drivers/misc/bmp085-spi.c                                         | 1 -
 drivers/misc/eeprom/at25.c                                        | 1 -
 drivers/misc/eeprom/eeprom_93xx46.c                               | 1 -
 drivers/misc/lattice-ecp3-config.c                                | 1 -
 drivers/misc/lis3lv02d/lis3lv02d_spi.c                            | 1 -
 drivers/misc/ti_dac7512.c                                         | 1 -
 drivers/mmc/host/mmc_spi.c                                        | 1 -
 drivers/mtd/devices/m25p80.c                                      | 1 -
 drivers/mtd/devices/mtd_dataflash.c                               | 1 -
 drivers/mtd/devices/sst25l.c                                      | 1 -
 drivers/net/can/spi/mcp251x.c                                     | 1 -
 drivers/net/ethernet/micrel/ks8851.c                              | 1 -
 drivers/net/ethernet/microchip/enc28j60.c                         | 1 -
 drivers/net/ethernet/qualcomm/qca_spi.c                           | 1 -
 drivers/net/ieee802154/at86rf230.c                                | 1 -
 drivers/net/ieee802154/cc2520.c                                   | 1 -
 drivers/net/ieee802154/mrf24j40.c                                 | 1 -
 drivers/net/phy/spi_ks8995.c                                      | 1 -
 drivers/net/wireless/cw1200/cw1200_spi.c                          | 1 -
 drivers/net/wireless/libertas/if_spi.c                            | 1 -
 drivers/net/wireless/p54/p54spi.c                                 | 1 -
 drivers/net/wireless/ti/wl1251/spi.c                              | 1 -
 drivers/net/wireless/ti/wlcore/spi.c                              | 1 -
 drivers/nfc/st-nci/spi.c                                          | 1 -
 drivers/nfc/trf7970a.c                                            | 1 -
 drivers/regulator/tps6524x-regulator.c                            | 1 -
 drivers/rtc/rtc-ds1305.c                                          | 1 -
 drivers/rtc/rtc-ds1343.c                                          | 1 -
 drivers/rtc/rtc-ds1347.c                                          | 1 -
 drivers/rtc/rtc-ds1390.c                                          | 1 -
 drivers/rtc/rtc-ds3234.c                                          | 1 -
 drivers/rtc/rtc-m41t93.c                                          | 1 -
 drivers/rtc/rtc-m41t94.c                                          | 1 -
 drivers/rtc/rtc-max6902.c                                         | 1 -
 drivers/rtc/rtc-mcp795.c                                          | 1 -
 drivers/rtc/rtc-pcf2123.c                                         | 1 -
 drivers/rtc/rtc-r9701.c                                           | 1 -
 drivers/rtc/rtc-rs5c348.c                                         | 1 -
 drivers/rtc/rtc-rx4581.c                                          | 1 -
 drivers/spi/spi-tle62x0.c                                         | 1 -
 drivers/spi/spidev.c                                              | 1 -
 drivers/staging/fbtft/fbtft.h                                     | 1 -
 drivers/staging/fbtft/flexfb.c                                    | 1 -
 drivers/staging/iio/accel/adis16201_core.c                        | 1 -
 drivers/staging/iio/accel/adis16203_core.c                        | 1 -
 drivers/staging/iio/accel/adis16204_core.c                        | 1 -
 drivers/staging/iio/accel/adis16209_core.c                        | 1 -
 drivers/staging/iio/accel/adis16220_core.c                        | 1 -
 drivers/staging/iio/accel/adis16240_core.c                        | 1 -
 drivers/staging/iio/accel/lis3l02dq_core.c                        | 1 -
 drivers/staging/iio/accel/sca3000_core.c                          | 1 -
 drivers/staging/iio/adc/ad7192.c                                  | 1 -
 drivers/staging/iio/adc/ad7280a.c                                 | 1 -
 drivers/staging/iio/adc/ad7606_spi.c                              | 1 -
 drivers/staging/iio/adc/ad7780.c                                  | 1 -
 drivers/staging/iio/adc/ad7816.c                                  | 1 -
 drivers/staging/iio/addac/adt7316-spi.c                           | 1 -
 drivers/staging/iio/frequency/ad9832.c                            | 1 -
 drivers/staging/iio/frequency/ad9834.c                            | 1 -
 drivers/staging/iio/gyro/adis16060_core.c                         | 2 --
 drivers/staging/iio/magnetometer/hmc5843_spi.c                    | 1 -
 drivers/staging/iio/meter/ade7753.c                               | 1 -
 drivers/staging/iio/meter/ade7754.c                               | 1 -
 drivers/staging/iio/meter/ade7758_core.c                          | 1 -
 drivers/staging/iio/meter/ade7759.c                               | 1 -
 drivers/staging/iio/meter/ade7854-spi.c                           | 1 -
 drivers/staging/iio/resolver/ad2s1200.c                           | 1 -
 drivers/staging/iio/resolver/ad2s1210.c                           | 1 -
 drivers/staging/iio/resolver/ad2s90.c                             | 1 -
 drivers/staging/mt29f_spinand/mt29f_spinand.c                     | 1 -
 drivers/tty/serial/ifx6x60.c                                      | 2 +-
 drivers/tty/serial/max3100.c                                      | 1 -
 drivers/tty/serial/max310x.c                                      | 1 -
 drivers/tty/serial/sc16is7xx.c                                    | 1 -
 drivers/usb/host/max3421-hcd.c                                    | 1 -
 drivers/video/backlight/ams369fg06.c                              | 1 -
 drivers/video/backlight/corgi_lcd.c                               | 1 -
 drivers/video/backlight/ili922x.c                                 | 1 -
 drivers/video/backlight/l4f00242t03.c                             | 1 -
 drivers/video/backlight/ld9040.c                                  | 1 -
 drivers/video/backlight/lms283gf05.c                              | 1 -
 drivers/video/backlight/lms501kf03.c                              | 1 -
 drivers/video/backlight/ltv350qv.c                                | 1 -
 drivers/video/backlight/s6e63m0.c                                 | 1 -
 drivers/video/backlight/tdo24m.c                                  | 1 -
 drivers/video/backlight/tosa_lcd.c                                | 1 -
 drivers/video/backlight/vgg2432a4.c                               | 1 -
 drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c                   | 1 -
 drivers/video/fbdev/omap/lcd_mipid.c                              | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c     | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c     | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c     | 1 -
 drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c     | 1 -
 sound/soc/codecs/ad1836.c                                         | 1 -
 sound/soc/codecs/ad193x-spi.c                                     | 1 -
 sound/soc/codecs/adau1761-spi.c                                   | 1 -
 sound/soc/codecs/adau1781-spi.c                                   | 1 -
 sound/soc/codecs/adau1977-spi.c                                   | 1 -
 sound/soc/codecs/adav801.c                                        | 1 -
 sound/soc/codecs/ak4104.c                                         | 1 -
 sound/soc/codecs/cs4271-spi.c                                     | 1 -
 sound/soc/codecs/da7210.c                                         | 1 -
 sound/soc/codecs/pcm1792a.c                                       | 1 -
 sound/soc/codecs/pcm512x-spi.c                                    | 1 -
 sound/soc/codecs/rt5677-spi.c                                     | 1 -
 sound/soc/codecs/ssm2602-spi.c                                    | 1 -
 sound/soc/codecs/tlv320aic23-spi.c                                | 1 -
 sound/soc/codecs/tlv320aic26.c                                    | 1 -
 sound/soc/codecs/wm0010.c                                         | 1 -
 sound/soc/codecs/wm8510.c                                         | 1 -
 sound/soc/codecs/wm8711.c                                         | 1 -
 sound/soc/codecs/wm8728.c                                         | 1 -
 sound/soc/codecs/wm8731.c                                         | 1 -
 sound/soc/codecs/wm8737.c                                         | 1 -
 sound/soc/codecs/wm8741.c                                         | 1 -
 sound/soc/codecs/wm8750.c                                         | 1 -
 sound/soc/codecs/wm8753.c                                         | 1 -
 sound/soc/codecs/wm8770.c                                         | 1 -
 sound/soc/codecs/wm8776.c                                         | 1 -
 sound/soc/codecs/wm8804-spi.c                                     | 1 -
 sound/soc/codecs/wm8900.c                                         | 1 -
 sound/soc/codecs/wm8983.c                                         | 1 -
 sound/soc/codecs/wm8985.c                                         | 1 -
 sound/soc/codecs/wm8988.c                                         | 1 -
 sound/soc/codecs/wm8995.c                                         | 1 -
 203 files changed, 1 insertion(+), 205 deletions(-)

diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 1319968..68fe986 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -264,7 +264,6 @@ static const struct of_device_id pl022_dummy_dt_match[] = {
 static struct spi_driver pl022_dummy_driver = {
 	.driver = {
 		.name	= "spi-dummy",
-		.owner	= THIS_MODULE,
 		.of_match_table = pl022_dummy_dt_match,
 	},
 	.probe	= pl022_dummy_probe,
diff --git a/arch/mips/txx9/generic/spi_eeprom.c b/arch/mips/txx9/generic/spi_eeprom.c
index 3dbad99..d833dd2 100644
--- a/arch/mips/txx9/generic/spi_eeprom.c
+++ b/arch/mips/txx9/generic/spi_eeprom.c
@@ -80,7 +80,6 @@ static int __init early_seeprom_probe(struct spi_device *spi)
 static struct spi_driver early_seeprom_driver __initdata = {
 	.driver = {
 		.name	= "at25",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= early_seeprom_probe,
 };
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index f0184a1..f974c94 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -381,7 +381,6 @@ static SIMPLE_DEV_PM_OPS(st33zp24_spi_ops, st33zp24_pm_suspend,
 
 static struct spi_driver tpm_st33_spi_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = TPM_ST33_SPI,
 		.pm = &st33zp24_spi_ops,
 		.of_match_table = of_match_ptr(of_st33zp24_spi_match),
diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index e3d968f..60172f8 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -183,7 +183,6 @@ MODULE_DEVICE_TABLE(of, gen_74x164_dt_ids);
 static struct spi_driver gen_74x164_driver = {
 	.driver = {
 		.name		= "74x164",
-		.owner		= THIS_MODULE,
 		.of_match_table	= gen_74x164_dt_ids,
 	},
 	.probe		= gen_74x164_probe,
diff --git a/drivers/gpio/gpio-max7301.c b/drivers/gpio/gpio-max7301.c
index 6e1c984..05813fb 100644
--- a/drivers/gpio/gpio-max7301.c
+++ b/drivers/gpio/gpio-max7301.c
@@ -87,7 +87,6 @@ MODULE_DEVICE_TABLE(spi, max7301_id);
 static struct spi_driver max7301_driver = {
 	.driver = {
 		.name = "max7301",
-		.owner = THIS_MODULE,
 	},
 	.probe = max7301_probe,
 	.remove = max7301_remove,
diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
index a431604..2853731 100644
--- a/drivers/gpio/gpio-mc33880.c
+++ b/drivers/gpio/gpio-mc33880.c
@@ -163,7 +163,6 @@ static int mc33880_remove(struct spi_device *spi)
 static struct spi_driver mc33880_driver = {
 	.driver = {
 		.name		= DRIVER_NAME,
-		.owner		= THIS_MODULE,
 	},
 	.probe		= mc33880_probe,
 	.remove		= mc33880_remove,
diff --git a/drivers/gpio/gpio-mcp23s08.c b/drivers/gpio/gpio-mcp23s08.c
index 73db7ec..4a41694 100644
--- a/drivers/gpio/gpio-mcp23s08.c
+++ b/drivers/gpio/gpio-mcp23s08.c
@@ -848,7 +848,6 @@ MODULE_DEVICE_TABLE(i2c, mcp230xx_id);
 static struct i2c_driver mcp230xx_driver = {
 	.driver = {
 		.name	= "mcp230xx",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(mcp23s08_i2c_of_match),
 	},
 	.probe		= mcp230xx_probe,
@@ -1021,7 +1020,6 @@ static struct spi_driver mcp23s08_driver = {
 	.id_table	= mcp23s08_ids,
 	.driver = {
 		.name	= "mcp23s08",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(mcp23s08_spi_of_match),
 	},
 };
diff --git a/drivers/gpu/drm/panel/panel-lg-lg4573.c b/drivers/gpu/drm/panel/panel-lg-lg4573.c
index a7b4939..6989238 100644
--- a/drivers/gpu/drm/panel/panel-lg-lg4573.c
+++ b/drivers/gpu/drm/panel/panel-lg-lg4573.c
@@ -287,7 +287,6 @@ static struct spi_driver lg4573_driver = {
 	.remove = lg4573_remove,
 	.driver = {
 		.name = "lg4573",
-		.owner = THIS_MODULE,
 		.of_match_table = lg4573_of_match,
 	},
 };
diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index b202377..3cf4cf6 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -378,7 +378,6 @@ static struct spi_driver ld9040_driver = {
 	.remove = ld9040_remove,
 	.driver = {
 		.name = "panel-samsung-ld9040",
-		.owner = THIS_MODULE,
 		.of_match_table = ld9040_of_match,
 	},
 };
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 1195546..202c1fbb 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -157,7 +157,6 @@ MODULE_DEVICE_TABLE(spi, ad7314_id);
 static struct spi_driver ad7314_driver = {
 	.driver = {
 		.name = "ad7314",
-		.owner = THIS_MODULE,
 	},
 	.probe = ad7314_probe,
 	.remove = ad7314_remove,
diff --git a/drivers/hwmon/adcxx.c b/drivers/hwmon/adcxx.c
index 04c08c2..69e0bb9 100644
--- a/drivers/hwmon/adcxx.c
+++ b/drivers/hwmon/adcxx.c
@@ -234,7 +234,6 @@ MODULE_DEVICE_TABLE(spi, adcxx_ids);
 static struct spi_driver adcxx_driver = {
 	.driver = {
 		.name	= "adcxx",
-		.owner	= THIS_MODULE,
 	},
 	.id_table = adcxx_ids,
 	.probe	= adcxx_probe,
diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 3eff73b..4fd9e4d 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -237,7 +237,6 @@ static int ads7871_remove(struct spi_device *spi)
 static struct spi_driver ads7871_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
-		.owner = THIS_MODULE,
 	},
 
 	.probe = ads7871_probe,
diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
index 5994cf6..ec02f4f 100644
--- a/drivers/hwmon/adt7310.c
+++ b/drivers/hwmon/adt7310.c
@@ -104,7 +104,6 @@ MODULE_DEVICE_TABLE(spi, adt7310_id);
 static struct spi_driver adt7310_driver = {
 	.driver = {
 		.name	= "adt7310",
-		.owner	= THIS_MODULE,
 		.pm	= ADT7X10_DEV_PM_OPS,
 	},
 	.probe		= adt7310_spi_probe,
diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 9296e9d..583f883 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -199,7 +199,6 @@ MODULE_DEVICE_TABLE(spi, lm70_ids);
 static struct spi_driver lm70_driver = {
 	.driver = {
 		.name	= "lm70",
-		.owner	= THIS_MODULE,
 		.of_match_table	= of_match_ptr(lm70_of_ids),
 	},
 	.id_table = lm70_ids,
diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index f67d71e..36544c4 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -277,7 +277,6 @@ MODULE_DEVICE_TABLE(spi, max1111_ids);
 static struct spi_driver max1111_driver = {
 	.driver		= {
 		.name	= "max1111",
-		.owner	= THIS_MODULE,
 	},
 	.id_table	= max1111_ids,
 	.probe		= max1111_probe,
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 98ba761..923f565 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -263,7 +263,6 @@ MODULE_DEVICE_TABLE(spi, kxsd9_id);
 static struct spi_driver kxsd9_driver = {
 	.driver = {
 		.name = "kxsd9",
-		.owner = THIS_MODULE,
 	},
 	.probe = kxsd9_probe,
 	.remove = kxsd9_remove,
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 54b61a3..f71b0d3 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -64,7 +64,6 @@ MODULE_DEVICE_TABLE(spi, st_accel_id_table);
 
 static struct spi_driver st_accel_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-accel-spi",
 	},
 	.probe = st_accel_spi_probe,
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 70f78c3..21e19b6 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -509,7 +509,6 @@ MODULE_DEVICE_TABLE(spi, ad7266_id);
 static struct spi_driver ad7266_driver = {
 	.driver = {
 		.name	= "ad7266",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7266_probe,
 	.remove		= ad7266_remove,
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 4a8c0a2..62bb8f7 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -378,7 +378,6 @@ MODULE_DEVICE_TABLE(spi, ad7298_id);
 static struct spi_driver ad7298_driver = {
 	.driver = {
 		.name	= "ad7298",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7298_probe,
 	.remove		= ad7298_remove,
diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index ce400ec..be85c2a 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -302,7 +302,6 @@ MODULE_DEVICE_TABLE(spi, ad7476_id);
 static struct spi_driver ad7476_driver = {
 	.driver = {
 		.name	= "ad7476",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7476_probe,
 	.remove		= ad7476_remove,
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index c19f8fd..cf172d58 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -440,7 +440,6 @@ MODULE_DEVICE_TABLE(spi, ad7791_spi_ids);
 static struct spi_driver ad7791_driver = {
 	.driver = {
 		.name	= "ad7791",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7791_probe,
 	.remove		= ad7791_remove,
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b84922a..eea0c79 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -852,7 +852,6 @@ MODULE_DEVICE_TABLE(spi, ad7793_id);
 static struct spi_driver ad7793_driver = {
 	.driver = {
 		.name	= "ad7793",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7793_probe,
 	.remove		= ad7793_remove,
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 2fd012e..2d3c397 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -356,7 +356,6 @@ MODULE_DEVICE_TABLE(spi, ad7887_id);
 static struct spi_driver ad7887_driver = {
 	.driver = {
 		.name	= "ad7887",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7887_probe,
 	.remove		= ad7887_remove,
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 28732c2..45e29cc 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -357,7 +357,6 @@ MODULE_DEVICE_TABLE(spi, ad7923_id);
 static struct spi_driver ad7923_driver = {
 	.driver = {
 		.name	= "ad7923",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7923_probe,
 	.remove		= ad7923_remove,
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 44bf815..3bc059c 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -508,7 +508,6 @@ static int max1027_remove(struct spi_device *spi)
 static struct spi_driver max1027_driver = {
 	.driver = {
 		.name	= "max1027",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= max1027_probe,
 	.remove		= max1027_remove,
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index b19e4f9..d5d8b41 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -404,7 +404,6 @@ MODULE_DEVICE_TABLE(spi, mcp320x_id);
 static struct spi_driver mcp320x_driver = {
 	.driver = {
 		.name = "mcp320x",
-		.owner = THIS_MODULE,
 	},
 	.probe = mcp320x_probe,
 	.remove = mcp320x_remove,
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 915be6b..76b6196 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -184,7 +184,6 @@ MODULE_DEVICE_TABLE(spi, adc128_id);
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
-		.owner = THIS_MODULE,
 	},
 	.probe = adc128_probe,
 	.remove = adc128_remove,
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index c0d364e..6da31e4 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -199,7 +199,6 @@ static const struct spi_device_id ad8366_id[] = {
 static struct spi_driver ad8366_driver = {
 	.driver = {
 		.name	= KBUILD_MODNAME,
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad8366_probe,
 	.remove		= ad8366_remove,
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index d338bb5..ea7adb6 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -700,7 +700,6 @@ static struct spi_driver ssp_driver = {
 	.remove = ssp_remove,
 	.driver = {
 		.pm = &ssp_pm_ops,
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(ssp_of_match),
 		.name = "sensorhub"
 	},
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index c067e68..9e4d2c1 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -568,7 +568,6 @@ MODULE_DEVICE_TABLE(spi, ad5064_spi_ids);
 static struct spi_driver ad5064_spi_driver = {
 	.driver = {
 		   .name = "ad5064",
-		   .owner = THIS_MODULE,
 	},
 	.probe = ad5064_spi_probe,
 	.remove = ad5064_spi_remove,
diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 64634d7..8ba0e9c 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -549,7 +549,6 @@ MODULE_DEVICE_TABLE(spi, ad5360_ids);
 static struct spi_driver ad5360_driver = {
 	.driver = {
 		   .name = "ad5360",
-		   .owner = THIS_MODULE,
 	},
 	.probe = ad5360_probe,
 	.remove = ad5360_remove,
diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 130de9b..97d2c51 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -519,7 +519,6 @@ MODULE_DEVICE_TABLE(spi, ad5380_spi_ids);
 static struct spi_driver ad5380_spi_driver = {
 	.driver = {
 		   .name = "ad5380",
-		   .owner = THIS_MODULE,
 	},
 	.probe = ad5380_spi_probe,
 	.remove = ad5380_spi_remove,
diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 787ef1d..968712b 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -524,7 +524,6 @@ static int ad5421_probe(struct spi_device *spi)
 static struct spi_driver ad5421_driver = {
 	.driver = {
 		   .name = "ad5421",
-		   .owner = THIS_MODULE,
 	},
 	.probe = ad5421_probe,
 };
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 07e17d7..b555552 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -481,7 +481,6 @@ static int ad5446_spi_remove(struct spi_device *spi)
 static struct spi_driver ad5446_spi_driver = {
 	.driver = {
 		.name	= "ad5446",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad5446_spi_probe,
 	.remove		= ad5446_spi_remove,
diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index 64d7256..5f32023 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -356,7 +356,6 @@ MODULE_DEVICE_TABLE(spi, ad5449_spi_ids);
 static struct spi_driver ad5449_spi_driver = {
 	.driver = {
 		.name = "ad5449",
-		.owner = THIS_MODULE,
 	},
 	.probe = ad5449_spi_probe,
 	.remove = ad5449_spi_remove,
diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 581ec14..88b2c92 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -364,7 +364,6 @@ MODULE_DEVICE_TABLE(spi, ad5504_id);
 static struct spi_driver ad5504_driver = {
 	.driver = {
 		   .name = "ad5504",
-		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5504_probe,
 	.remove = ad5504_remove,
diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index e98428d..5489ec4 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -306,7 +306,6 @@ MODULE_DEVICE_TABLE(spi, ad5624r_id);
 static struct spi_driver ad5624r_driver = {
 	.driver = {
 		   .name = "ad5624r",
-		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5624r_probe,
 	.remove = ad5624r_remove,
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 15c73e2..d1d8450 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -395,7 +395,6 @@ MODULE_DEVICE_TABLE(spi, ad5686_id);
 static struct spi_driver ad5686_driver = {
 	.driver = {
 		   .name = "ad5686",
-		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5686_probe,
 	.remove = ad5686_remove,
diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index a7c851f..bfb350a 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -610,7 +610,6 @@ MODULE_DEVICE_TABLE(spi, ad5755_id);
 static struct spi_driver ad5755_driver = {
 	.driver = {
 		.name = "ad5755",
-		.owner = THIS_MODULE,
 	},
 	.probe = ad5755_probe,
 	.id_table = ad5755_id,
diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index d0d3816..9a547bb 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -357,7 +357,6 @@ MODULE_DEVICE_TABLE(spi, ad5764_ids);
 static struct spi_driver ad5764_driver = {
 	.driver = {
 		.name = "ad5764",
-		.owner = THIS_MODULE,
 	},
 	.probe = ad5764_probe,
 	.remove = ad5764_remove,
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 5ba785f..33e4ae5 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -461,7 +461,6 @@ MODULE_DEVICE_TABLE(spi, ad5791_id);
 static struct spi_driver ad5791_driver = {
 	.driver = {
 		   .name = "ad5791",
-		   .owner = THIS_MODULE,
 		   },
 	.probe = ad5791_probe,
 	.remove = ad5791_remove,
diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index fa28100..399de2c 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -290,7 +290,6 @@ MODULE_DEVICE_TABLE(spi, ad7303_spi_ids);
 static struct spi_driver ad7303_driver = {
 	.driver = {
 		.name = "ad7303",
-		.owner = THIS_MODULE,
 	},
 	.probe = ad7303_probe,
 	.remove = ad7303_remove,
diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index 92cf4ca..3854d20 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -203,7 +203,6 @@ MODULE_DEVICE_TABLE(spi, mcp4922_id);
 static struct spi_driver mcp4922_driver = {
 	.driver = {
 		   .name = "mcp4922",
-		   .owner = THIS_MODULE,
 		   },
 	.probe = mcp4922_probe,
 	.remove = mcp4922_remove,
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 50ed8d1..44a30f2 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -1027,7 +1027,6 @@ MODULE_DEVICE_TABLE(spi, ad9523_id);
 static struct spi_driver ad9523_driver = {
 	.driver = {
 		.name	= "ad9523",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9523_probe,
 	.remove		= ad9523_remove,
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 9890c81..b83534c 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -625,7 +625,6 @@ static const struct spi_device_id adf4350_id[] = {
 static struct spi_driver adf4350_driver = {
 	.driver = {
 		.name	= "adf4350",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= adf4350_probe,
 	.remove		= adf4350_remove,
diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
index add5098..ad31a13 100644
--- a/drivers/iio/gyro/adis16080.c
+++ b/drivers/iio/gyro/adis16080.c
@@ -228,7 +228,6 @@ MODULE_DEVICE_TABLE(spi, adis16080_ids);
 static struct spi_driver adis16080_driver = {
 	.driver = {
 		.name = "adis16080",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16080_probe,
 	.remove = adis16080_remove,
diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index 8d08c7e..e5241f4 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -167,7 +167,6 @@ static int adis16130_probe(struct spi_device *spi)
 static struct spi_driver adis16130_driver = {
 	.driver = {
 		.name = "adis16130",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16130_probe,
 };
diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 26de876..f8d1c22 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -570,7 +570,6 @@ MODULE_DEVICE_TABLE(spi, adis16136_ids);
 static struct spi_driver adis16136_driver = {
 	.driver = {
 		.name = "adis16136",
-		.owner = THIS_MODULE,
 	},
 	.id_table = adis16136_ids,
 	.probe = adis16136_probe,
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 00c6ad9..7da8825 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -435,7 +435,6 @@ MODULE_DEVICE_TABLE(spi, adis16260_id);
 static struct spi_driver adis16260_driver = {
 	.driver = {
 		.name = "adis16260",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16260_probe,
 	.remove = adis16260_remove,
diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index eb0e08e..a330d42 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -456,7 +456,6 @@ MODULE_DEVICE_TABLE(spi, adxrs450_id);
 static struct spi_driver adxrs450_driver = {
 	.driver = {
 		.name = "adxrs450",
-		.owner = THIS_MODULE,
 	},
 	.probe = adxrs450_probe,
 	.id_table	= adxrs450_id,
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index e59bead..d2b7a5f 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -60,7 +60,6 @@ MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
 
 static struct spi_driver st_gyro_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-gyro-spi",
 	},
 	.probe = st_gyro_spi_probe,
diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index abc4c50..0618f83 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -986,7 +986,6 @@ MODULE_DEVICE_TABLE(spi, adis16400_id);
 static struct spi_driver adis16400_driver = {
 	.driver = {
 		.name = "adis16400",
-		.owner = THIS_MODULE,
 	},
 	.id_table = adis16400_id,
 	.probe = adis16400_probe,
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b94bfd3..2485b88 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -896,7 +896,6 @@ MODULE_DEVICE_TABLE(spi, adis16480_ids);
 static struct spi_driver adis16480_driver = {
 	.driver = {
 		.name = "adis16480",
-		.owner = THIS_MODULE,
 	},
 	.id_table = adis16480_ids,
 	.probe = adis16480_probe,
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 0abca2c..6325e7d 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -58,7 +58,6 @@ MODULE_DEVICE_TABLE(spi, st_magn_id_table);
 
 static struct spi_driver st_magn_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-magn-spi",
 	},
 	.probe = st_magn_spi_probe,
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 08ee6e8..aaa0c4b 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -117,7 +117,6 @@ MODULE_DEVICE_TABLE(spi, ms5611_id);
 static struct spi_driver ms5611_driver = {
 	.driver = {
 		.name = "ms5611",
-		.owner = THIS_MODULE,
 	},
 	.id_table = ms5611_id,
 	.probe = ms5611_spi_probe,
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 1ffa6d4..40c0692 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -56,7 +56,6 @@ MODULE_DEVICE_TABLE(spi, st_press_id_table);
 
 static struct spi_driver st_press_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "st-press-spi",
 	},
 	.probe = st_press_spi_probe,
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index bc0d68e..2865aa6 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -443,7 +443,6 @@ MODULE_DEVICE_TABLE(spi, as3935_id);
 static struct spi_driver as3935_driver = {
 	.driver = {
 		.name	= "as3935",
-		.owner	= THIS_MODULE,
 		.pm	= AS3935_PM_OPS,
 	},
 	.probe		= as3935_probe,
diff --git a/drivers/input/misc/ad714x-spi.c b/drivers/input/misc/ad714x-spi.c
index a79e50b..fea315e 100644
--- a/drivers/input/misc/ad714x-spi.c
+++ b/drivers/input/misc/ad714x-spi.c
@@ -113,7 +113,6 @@ static int ad714x_spi_remove(struct spi_device *spi)
 static struct spi_driver ad714x_spi_driver = {
 	.driver = {
 		.name	= "ad714x_captouch",
-		.owner	= THIS_MODULE,
 		.pm	= &ad714x_spi_pm,
 	},
 	.probe		= ad714x_spi_probe,
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
index da6e76b..3ec03ad 100644
--- a/drivers/input/misc/adxl34x-spi.c
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -120,7 +120,6 @@ static SIMPLE_DEV_PM_OPS(adxl34x_spi_pm, adxl34x_spi_suspend,
 static struct spi_driver adxl34x_driver = {
 	.driver = {
 		.name = "adxl34x",
-		.owner = THIS_MODULE,
 		.pm = &adxl34x_spi_pm,
 	},
 	.probe   = adxl34x_spi_probe,
diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index da4e5bb..9c250ae 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -843,7 +843,6 @@ static SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_resume);
 static struct spi_driver ad7877_driver = {
 	.driver = {
 		.name	= "ad7877",
-		.owner	= THIS_MODULE,
 		.pm	= &ad7877_pm,
 	},
 	.probe		= ad7877_probe,
diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
index 1a7b114..48033c2 100644
--- a/drivers/input/touchscreen/ad7879-spi.c
+++ b/drivers/input/touchscreen/ad7879-spi.c
@@ -149,7 +149,6 @@ static int ad7879_spi_remove(struct spi_device *spi)
 static struct spi_driver ad7879_spi_driver = {
 	.driver = {
 		.name	= "ad7879",
-		.owner	= THIS_MODULE,
 		.pm	= &ad7879_pm_ops,
 	},
 	.probe		= ad7879_spi_probe,
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 0f5f968..7f268cd 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1496,7 +1496,6 @@ static int ads7846_remove(struct spi_device *spi)
 static struct spi_driver ads7846_driver = {
 	.driver = {
 		.name	= "ads7846",
-		.owner	= THIS_MODULE,
 		.pm	= &ads7846_pm,
 		.of_match_table = of_match_ptr(ads7846_dt_ids),
 	},
diff --git a/drivers/input/touchscreen/cyttsp4_spi.c b/drivers/input/touchscreen/cyttsp4_spi.c
index b19434c..ec5f7c7 100644
--- a/drivers/input/touchscreen/cyttsp4_spi.c
+++ b/drivers/input/touchscreen/cyttsp4_spi.c
@@ -185,7 +185,6 @@ static int cyttsp4_spi_remove(struct spi_device *spi)
 static struct spi_driver cyttsp4_spi_driver = {
 	.driver = {
 		.name	= CYTTSP4_SPI_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &cyttsp4_pm_ops,
 	},
 	.probe  = cyttsp4_spi_probe,
diff --git a/drivers/input/touchscreen/cyttsp_spi.c b/drivers/input/touchscreen/cyttsp_spi.c
index 4728bcb..bbeeb24 100644
--- a/drivers/input/touchscreen/cyttsp_spi.c
+++ b/drivers/input/touchscreen/cyttsp_spi.c
@@ -182,7 +182,6 @@ static int cyttsp_spi_remove(struct spi_device *spi)
 static struct spi_driver cyttsp_spi_driver = {
 	.driver = {
 		.name	= CY_SPI_NAME,
-		.owner	= THIS_MODULE,
 		.pm	= &cyttsp_pm_ops,
 	},
 	.probe  = cyttsp_spi_probe,
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 0f65d02..f41f233 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -752,7 +752,6 @@ static SIMPLE_DEV_PM_OPS(tsc2005_pm_ops, tsc2005_suspend, tsc2005_resume);
 static struct spi_driver tsc2005_driver = {
 	.driver	= {
 		.name	= "tsc2005",
-		.owner	= THIS_MODULE,
 		.pm	= &tsc2005_pm_ops,
 	},
 	.probe	= tsc2005_probe,
diff --git a/drivers/leds/leds-dac124s085.c b/drivers/leds/leds-dac124s085.c
index db3ba8b..3141596 100644
--- a/drivers/leds/leds-dac124s085.c
+++ b/drivers/leds/leds-dac124s085.c
@@ -122,7 +122,6 @@ static struct spi_driver dac124s085_driver = {
 	.remove		= dac124s085_remove,
 	.driver = {
 		.name	= "dac124s085",
-		.owner	= THIS_MODULE,
 	},
 };
 
diff --git a/drivers/media/i2c/s5c73m3/s5c73m3-spi.c b/drivers/media/i2c/s5c73m3/s5c73m3-spi.c
index fa4a5eb..d744b17 100644
--- a/drivers/media/i2c/s5c73m3/s5c73m3-spi.c
+++ b/drivers/media/i2c/s5c73m3/s5c73m3-spi.c
@@ -149,7 +149,6 @@ int s5c73m3_register_spi_driver(struct s5c73m3 *state)
 	spidrv->remove = s5c73m3_spi_remove;
 	spidrv->probe = s5c73m3_spi_probe;
 	spidrv->driver.name = S5C73M3_SPI_DRV_NAME;
-	spidrv->driver.owner = THIS_MODULE;
 	spidrv->driver.of_match_table = s5c73m3_spi_ids;
 
 	return spi_register_driver(spidrv);
diff --git a/drivers/media/tuners/msi001.c b/drivers/media/tuners/msi001.c
index b533240..3a12ef3 100644
--- a/drivers/media/tuners/msi001.c
+++ b/drivers/media/tuners/msi001.c
@@ -513,7 +513,6 @@ MODULE_DEVICE_TABLE(spi, msi001_id_table);
 static struct spi_driver msi001_driver = {
 	.driver = {
 		.name	= "msi001",
-		.owner	= THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= msi001_probe,
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 1e845f6..03d62f7 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -93,7 +93,6 @@ MODULE_DEVICE_TABLE(spi, arizona_spi_ids);
 static struct spi_driver arizona_spi_driver = {
 	.driver = {
 		.name	= "arizona",
-		.owner	= THIS_MODULE,
 		.pm	= &arizona_pm_ops,
 		.of_match_table	= of_match_ptr(arizona_of_match),
 	},
diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 30a296b..6a0f6ec 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -717,7 +717,6 @@ static struct spi_driver cros_ec_driver_spi = {
 	.driver	= {
 		.name	= "cros-ec-spi",
 		.of_match_table = of_match_ptr(cros_ec_spi_of_match),
-		.owner	= THIS_MODULE,
 		.pm	= &cros_ec_spi_pm_ops,
 	},
 	.probe		= cros_ec_spi_probe,
diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
index b5de8a6..71b89dd 100644
--- a/drivers/mfd/da9052-spi.c
+++ b/drivers/mfd/da9052-spi.c
@@ -86,7 +86,6 @@ static struct spi_driver da9052_spi_driver = {
 	.id_table = da9052_spi_id,
 	.driver = {
 		.name = "da9052",
-		.owner = THIS_MODULE,
 	},
 };
 
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index a76eb6e..7841a20 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -513,7 +513,6 @@ static struct spi_driver ezxpcap_driver = {
 	.remove = ezx_pcap_remove,
 	.driver = {
 		.name	= "ezx-pcap",
-		.owner	= THIS_MODULE,
 	},
 };
 
diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 58a170e..cbc1e5e 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -177,7 +177,6 @@ static struct spi_driver mc13xxx_spi_driver = {
 	.id_table = mc13xxx_device_id,
 	.driver = {
 		.name = "mc13xxx",
-		.owner = THIS_MODULE,
 		.of_match_table = mc13xxx_dt_ids,
 	},
 	.probe = mc13xxx_spi_probe,
diff --git a/drivers/mfd/stmpe-spi.c b/drivers/mfd/stmpe-spi.c
index 618ba24..f8b14ab 100644
--- a/drivers/mfd/stmpe-spi.c
+++ b/drivers/mfd/stmpe-spi.c
@@ -135,7 +135,6 @@ static struct spi_driver stmpe_spi_driver = {
 	.driver = {
 		.name	= "stmpe-spi",
 		.of_match_table = of_match_ptr(stmpe_spi_of_match),
-		.owner	= THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &stmpe_dev_pm_ops,
 #endif
diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index de60ad9..d59aa55 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -111,7 +111,6 @@ static int tps65912_spi_remove(struct spi_device *spi)
 static struct spi_driver tps65912_spi_driver = {
 	.driver = {
 		.name = "tps65912",
-		.owner = THIS_MODULE,
 	},
 	.probe	= tps65912_spi_probe,
 	.remove = tps65912_spi_remove,
diff --git a/drivers/mfd/wm831x-spi.c b/drivers/mfd/wm831x-spi.c
index b8a5e3b..80482ae 100644
--- a/drivers/mfd/wm831x-spi.c
+++ b/drivers/mfd/wm831x-spi.c
@@ -96,7 +96,6 @@ MODULE_DEVICE_TABLE(spi, wm831x_spi_ids);
 static struct spi_driver wm831x_spi_driver = {
 	.driver = {
 		.name	= "wm831x",
-		.owner	= THIS_MODULE,
 		.pm	= &wm831x_spi_pm,
 	},
 	.id_table	= wm831x_spi_ids,
diff --git a/drivers/misc/ad525x_dpot-spi.c b/drivers/misc/ad525x_dpot-spi.c
index f4c82ea..39a7f51 100644
--- a/drivers/misc/ad525x_dpot-spi.c
+++ b/drivers/misc/ad525x_dpot-spi.c
@@ -132,7 +132,6 @@ MODULE_DEVICE_TABLE(spi, ad_dpot_spi_id);
 static struct spi_driver ad_dpot_spi_driver = {
 	.driver = {
 		.name	= "ad_dpot",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad_dpot_spi_probe,
 	.remove		= ad_dpot_spi_remove,
diff --git a/drivers/misc/bmp085-spi.c b/drivers/misc/bmp085-spi.c
index 864ecac..17ecbf9 100644
--- a/drivers/misc/bmp085-spi.c
+++ b/drivers/misc/bmp085-spi.c
@@ -64,7 +64,6 @@ MODULE_DEVICE_TABLE(spi, bmp085_id);
 
 static struct spi_driver bmp085_spi_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= BMP085_NAME,
 		.of_match_table = bmp085_of_match
 	},
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 0a1af93..f850ef5 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -462,7 +462,6 @@ MODULE_DEVICE_TABLE(of, at25_of_match);
 static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
-		.owner		= THIS_MODULE,
 		.of_match_table = at25_of_match,
 	},
 	.probe		= at25_probe,
diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index a6bd9e3..ff63f05 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -370,7 +370,6 @@ static int eeprom_93xx46_remove(struct spi_device *spi)
 static struct spi_driver eeprom_93xx46_driver = {
 	.driver = {
 		.name	= "93xx46",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= eeprom_93xx46_probe,
 	.remove		= eeprom_93xx46_remove,
diff --git a/drivers/misc/lattice-ecp3-config.c b/drivers/misc/lattice-ecp3-config.c
index c544f1f..626fdca 100644
--- a/drivers/misc/lattice-ecp3-config.c
+++ b/drivers/misc/lattice-ecp3-config.c
@@ -235,7 +235,6 @@ MODULE_DEVICE_TABLE(spi, lattice_ecp3_id);
 static struct spi_driver lattice_ecp3_driver = {
 	.driver = {
 		.name = "lattice-ecp3",
-		.owner = THIS_MODULE,
 	},
 	.probe = lattice_ecp3_probe,
 	.remove = lattice_ecp3_remove,
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
index b2f6e16..e575475 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
@@ -138,7 +138,6 @@ static SIMPLE_DEV_PM_OPS(lis3lv02d_spi_pm, lis3lv02d_spi_suspend,
 static struct spi_driver lis302dl_spi_driver = {
 	.driver	 = {
 		.name   = DRV_NAME,
-		.owner  = THIS_MODULE,
 		.pm	= &lis3lv02d_spi_pm,
 		.of_match_table = of_match_ptr(lis302dl_spi_dt_ids),
 	},
diff --git a/drivers/misc/ti_dac7512.c b/drivers/misc/ti_dac7512.c
index cb0289b..f5456fb 100644
--- a/drivers/misc/ti_dac7512.c
+++ b/drivers/misc/ti_dac7512.c
@@ -89,7 +89,6 @@ MODULE_DEVICE_TABLE(of, dac7512_of_match);
 static struct spi_driver dac7512_driver = {
 	.driver = {
 		.name	= "dac7512",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(dac7512_of_match),
 	},
 	.probe	= dac7512_probe,
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index ae19d83..8c79831 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1515,7 +1515,6 @@ static const struct of_device_id mmc_spi_of_match_table[] = {
 static struct spi_driver mmc_spi_driver = {
 	.driver = {
 		.name =		"mmc_spi",
-		.owner =	THIS_MODULE,
 		.of_match_table = mmc_spi_of_match_table,
 	},
 	.probe =	mmc_spi_probe,
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 9cd3631..fcf171a 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -304,7 +304,6 @@ MODULE_DEVICE_TABLE(of, m25p_of_table);
 static struct spi_driver m25p80_driver = {
 	.driver = {
 		.name	= "m25p80",
-		.owner	= THIS_MODULE,
 		.of_match_table = m25p_of_table,
 	},
 	.id_table	= m25p_ids,
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index df6f611..70c1639 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -911,7 +911,6 @@ static int dataflash_remove(struct spi_device *spi)
 static struct spi_driver dataflash_driver = {
 	.driver = {
 		.name		= "mtd_dataflash",
-		.owner		= THIS_MODULE,
 		.of_match_table = of_match_ptr(dataflash_dt_ids),
 	},
 
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index c63ecbc..18febf7 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -417,7 +417,6 @@ static int sst25l_remove(struct spi_device *spi)
 static struct spi_driver sst25l_driver = {
 	.driver = {
 		.name	= "sst25l",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= sst25l_probe,
 	.remove		= sst25l_remove,
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index b7e83c2..575790e 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1243,7 +1243,6 @@ static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
 static struct spi_driver mcp251x_can_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
-		.owner = THIS_MODULE,
 		.of_match_table = mcp251x_of_match,
 		.pm = &mcp251x_can_pm_ops,
 	},
diff --git a/drivers/net/ethernet/micrel/ks8851.c b/drivers/net/ethernet/micrel/ks8851.c
index 66d4ab7..37b466a 100644
--- a/drivers/net/ethernet/micrel/ks8851.c
+++ b/drivers/net/ethernet/micrel/ks8851.c
@@ -1606,7 +1606,6 @@ static struct spi_driver ks8851_driver = {
 	.driver = {
 		.name = "ks8851",
 		.of_match_table = ks8851_match_table,
-		.owner = THIS_MODULE,
 		.pm = &ks8851_pm_ops,
 	},
 	.probe = ks8851_probe,
diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index b1b5f66..86ea17e 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -1633,7 +1633,6 @@ static int enc28j60_remove(struct spi_device *spi)
 static struct spi_driver enc28j60_driver = {
 	.driver = {
 		   .name = DRV_NAME,
-		   .owner = THIS_MODULE,
 	 },
 	.probe = enc28j60_probe,
 	.remove = enc28j60_remove,
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 2f87909..ddb2c6c 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -974,7 +974,6 @@ MODULE_DEVICE_TABLE(spi, qca_spi_id);
 static struct spi_driver qca_spi_driver = {
 	.driver	= {
 		.name	= QCASPI_DRV_NAME,
-		.owner	= THIS_MODULE,
 		.of_match_table = qca_spi_of_match,
 	},
 	.id_table = qca_spi_id,
diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6422caa..46805ab 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1763,7 +1763,6 @@ static struct spi_driver at86rf230_driver = {
 	.driver = {
 		.of_match_table = of_match_ptr(at86rf230_of_match),
 		.name	= "at86rf230",
-		.owner	= THIS_MODULE,
 	},
 	.probe      = at86rf230_probe,
 	.remove     = at86rf230_remove,
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index c5b54a1..e65b605 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -1152,7 +1152,6 @@ MODULE_DEVICE_TABLE(of, cc2520_of_ids);
 static struct spi_driver cc2520_driver = {
 	.driver = {
 		.name = "cc2520",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(cc2520_of_ids),
 	},
 	.id_table = cc2520_ids,
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 997724b..e4c37d4 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -812,7 +812,6 @@ MODULE_DEVICE_TABLE(spi, mrf24j40_ids);
 static struct spi_driver mrf24j40_driver = {
 	.driver = {
 		.name = "mrf24j40",
-		.owner = THIS_MODULE,
 	},
 	.id_table = mrf24j40_ids,
 	.probe = mrf24j40_probe,
diff --git a/drivers/net/phy/spi_ks8995.c b/drivers/net/phy/spi_ks8995.c
index f091d69..c72c422 100644
--- a/drivers/net/phy/spi_ks8995.c
+++ b/drivers/net/phy/spi_ks8995.c
@@ -343,7 +343,6 @@ static int ks8995_remove(struct spi_device *spi)
 static struct spi_driver ks8995_driver = {
 	.driver = {
 		.name	    = "spi-ks8995",
-		.owner	   = THIS_MODULE,
 	},
 	.probe	  = ks8995_probe,
 	.remove	  = ks8995_remove,
diff --git a/drivers/net/wireless/cw1200/cw1200_spi.c b/drivers/net/wireless/cw1200/cw1200_spi.c
index 29185ae..a740083 100644
--- a/drivers/net/wireless/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/cw1200/cw1200_spi.c
@@ -467,7 +467,6 @@ static struct spi_driver spi_driver = {
 	.remove		= cw1200_spi_disconnect,
 	.driver = {
 		.name		= "cw1200_wlan_spi",
-		.owner          = THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm		= &cw1200_pm_ops,
 #endif
diff --git a/drivers/net/wireless/libertas/if_spi.c b/drivers/net/wireless/libertas/if_spi.c
index f11728a..82c0796 100644
--- a/drivers/net/wireless/libertas/if_spi.c
+++ b/drivers/net/wireless/libertas/if_spi.c
@@ -1283,7 +1283,6 @@ static struct spi_driver libertas_spi_driver = {
 	.remove = libertas_spi_remove,
 	.driver = {
 		.name	= "libertas_spi",
-		.owner	= THIS_MODULE,
 		.pm	= &if_spi_pm_ops,
 	},
 };
diff --git a/drivers/net/wireless/p54/p54spi.c b/drivers/net/wireless/p54/p54spi.c
index 63de5ee..7ab2f43 100644
--- a/drivers/net/wireless/p54/p54spi.c
+++ b/drivers/net/wireless/p54/p54spi.c
@@ -705,7 +705,6 @@ static int p54spi_remove(struct spi_device *spi)
 static struct spi_driver p54spi_driver = {
 	.driver = {
 		.name		= "p54spi",
-		.owner		= THIS_MODULE,
 	},
 
 	.probe		= p54spi_probe,
diff --git a/drivers/net/wireless/ti/wl1251/spi.c b/drivers/net/wireless/ti/wl1251/spi.c
index 735be53..8de9d44 100644
--- a/drivers/net/wireless/ti/wl1251/spi.c
+++ b/drivers/net/wireless/ti/wl1251/spi.c
@@ -354,7 +354,6 @@ static int wl1251_spi_remove(struct spi_device *spi)
 static struct spi_driver wl1251_spi_driver = {
 	.driver = {
 		.name		= DRIVER_NAME,
-		.owner		= THIS_MODULE,
 	},
 
 	.probe		= wl1251_spi_probe,
diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index f1ac283..236b410 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -408,7 +408,6 @@ static int wl1271_remove(struct spi_device *spi)
 static struct spi_driver wl1271_spi_driver = {
 	.driver = {
 		.name		= "wl1271_spi",
-		.owner		= THIS_MODULE,
 	},
 
 	.probe		= wl1271_probe,
diff --git a/drivers/nfc/st-nci/spi.c b/drivers/nfc/st-nci/spi.c
index 598a58c..2bb5851 100644
--- a/drivers/nfc/st-nci/spi.c
+++ b/drivers/nfc/st-nci/spi.c
@@ -377,7 +377,6 @@ MODULE_DEVICE_TABLE(of, of_st_nci_spi_match);
 
 static struct spi_driver st_nci_spi_driver = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = ST_NCI_SPI_DRIVER_NAME,
 		.of_match_table = of_match_ptr(of_st_nci_spi_match),
 	},
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 70b0707..4036788 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -2223,7 +2223,6 @@ static struct spi_driver trf7970a_spi_driver = {
 	.id_table	= trf7970a_id_table,
 	.driver		= {
 		.name	= "trf7970a",
-		.owner	= THIS_MODULE,
 		.pm	= &trf7970a_pm_ops,
 	},
 };
diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 5b494db..9d6ea3a 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -629,7 +629,6 @@ static struct spi_driver pmic_driver = {
 	.probe		= pmic_probe,
 	.driver		= {
 		.name	= "tps6524x",
-		.owner	= THIS_MODULE,
 	},
 };
 
diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index baa5d04..85706a9 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -772,7 +772,6 @@ static int ds1305_remove(struct spi_device *spi)
 
 static struct spi_driver ds1305_driver = {
 	.driver.name	= "rtc-ds1305",
-	.driver.owner	= THIS_MODULE,
 	.probe		= ds1305_probe,
 	.remove		= ds1305_remove,
 	/* REVISIT add suspend/resume */
diff --git a/drivers/rtc/rtc-ds1343.c b/drivers/rtc/rtc-ds1343.c
index 79a06dd..07371a9 100644
--- a/drivers/rtc/rtc-ds1343.c
+++ b/drivers/rtc/rtc-ds1343.c
@@ -731,7 +731,6 @@ static SIMPLE_DEV_PM_OPS(ds1343_pm, ds1343_suspend, ds1343_resume);
 static struct spi_driver ds1343_driver = {
 	.driver = {
 		.name = "ds1343",
-		.owner = THIS_MODULE,
 		.pm = &ds1343_pm,
 	},
 	.probe = ds1343_probe,
diff --git a/drivers/rtc/rtc-ds1347.c b/drivers/rtc/rtc-ds1347.c
index c82b4c0..641e8e8 100644
--- a/drivers/rtc/rtc-ds1347.c
+++ b/drivers/rtc/rtc-ds1347.c
@@ -154,7 +154,6 @@ static int ds1347_probe(struct spi_device *spi)
 static struct spi_driver ds1347_driver = {
 	.driver = {
 		.name = "ds1347",
-		.owner = THIS_MODULE,
 	},
 	.probe = ds1347_probe,
 };
diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index e67bfcb..4c229c9 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -156,7 +156,6 @@ static int ds1390_probe(struct spi_device *spi)
 static struct spi_driver ds1390_driver = {
 	.driver = {
 		.name	= "rtc-ds1390",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= ds1390_probe,
 };
diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
index 4c9ba53..570ab28 100644
--- a/drivers/rtc/rtc-ds3234.c
+++ b/drivers/rtc/rtc-ds3234.c
@@ -159,7 +159,6 @@ static int ds3234_probe(struct spi_device *spi)
 static struct spi_driver ds3234_driver = {
 	.driver = {
 		.name	 = "ds3234",
-		.owner	= THIS_MODULE,
 	},
 	.probe	 = ds3234_probe,
 };
diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index 4698c7e..5ac45fc 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -197,7 +197,6 @@ static int m41t93_probe(struct spi_device *spi)
 static struct spi_driver m41t93_driver = {
 	.driver = {
 		.name	= "rtc-m41t93",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= m41t93_probe,
 };
diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
index 8d800b1..1f0eb79 100644
--- a/drivers/rtc/rtc-m41t94.c
+++ b/drivers/rtc/rtc-m41t94.c
@@ -137,7 +137,6 @@ static int m41t94_probe(struct spi_device *spi)
 static struct spi_driver m41t94_driver = {
 	.driver = {
 		.name	= "rtc-m41t94",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= m41t94_probe,
 };
diff --git a/drivers/rtc/rtc-max6902.c b/drivers/rtc/rtc-max6902.c
index ac3f419..315d09e 100644
--- a/drivers/rtc/rtc-max6902.c
+++ b/drivers/rtc/rtc-max6902.c
@@ -146,7 +146,6 @@ static int max6902_probe(struct spi_device *spi)
 static struct spi_driver max6902_driver = {
 	.driver = {
 		.name	= "rtc-max6902",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= max6902_probe,
 };
diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 34295bf..1c91ce8 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -186,7 +186,6 @@ static int mcp795_probe(struct spi_device *spi)
 static struct spi_driver mcp795_driver = {
 		.driver = {
 				.name = "rtc-mcp795",
-				.owner = THIS_MODULE,
 		},
 		.probe = mcp795_probe,
 };
diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
index 1c47650..ea8a31c 100644
--- a/drivers/rtc/rtc-pcf2123.c
+++ b/drivers/rtc/rtc-pcf2123.c
@@ -346,7 +346,6 @@ MODULE_DEVICE_TABLE(of, pcf2123_dt_ids);
 static struct spi_driver pcf2123_driver = {
 	.driver	= {
 			.name	= "rtc-pcf2123",
-			.owner	= THIS_MODULE,
 			.of_match_table = of_match_ptr(pcf2123_dt_ids),
 	},
 	.probe	= pcf2123_probe,
diff --git a/drivers/rtc/rtc-r9701.c b/drivers/rtc/rtc-r9701.c
index feeedbd..83d2bcc 100644
--- a/drivers/rtc/rtc-r9701.c
+++ b/drivers/rtc/rtc-r9701.c
@@ -172,7 +172,6 @@ static int r9701_remove(struct spi_device *spi)
 static struct spi_driver r9701_driver = {
 	.driver = {
 		.name	= "rtc-r9701",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= r9701_probe,
 	.remove = r9701_remove,
diff --git a/drivers/rtc/rtc-rs5c348.c b/drivers/rtc/rtc-rs5c348.c
index 090a101..1162fec 100644
--- a/drivers/rtc/rtc-rs5c348.c
+++ b/drivers/rtc/rtc-rs5c348.c
@@ -221,7 +221,6 @@ static int rs5c348_probe(struct spi_device *spi)
 static struct spi_driver rs5c348_driver = {
 	.driver = {
 		.name	= "rtc-rs5c348",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= rs5c348_probe,
 };
diff --git a/drivers/rtc/rtc-rx4581.c b/drivers/rtc/rtc-rx4581.c
index 6889222..de3fe4f8 100644
--- a/drivers/rtc/rtc-rx4581.c
+++ b/drivers/rtc/rtc-rx4581.c
@@ -291,7 +291,6 @@ MODULE_DEVICE_TABLE(spi, rx4581_id);
 static struct spi_driver rx4581_driver = {
 	.driver = {
 		.name	= "rtc-rx4581",
-		.owner	= THIS_MODULE,
 	},
 	.probe	= rx4581_probe,
 	.id_table = rx4581_id,
diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index daf5aa1..c6ae775 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -307,7 +307,6 @@ static int tle62x0_remove(struct spi_device *spi)
 static struct spi_driver tle62x0_driver = {
 	.driver = {
 		.name	= "tle62x0",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= tle62x0_probe,
 	.remove		= tle62x0_remove,
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index fba92a5..8462241 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -787,7 +787,6 @@ static int spidev_remove(struct spi_device *spi)
 static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
-		.owner =	THIS_MODULE,
 		.of_match_table = of_match_ptr(spidev_dt_ids),
 	},
 	.probe =	spidev_probe,
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 7e9a506..0d27daf 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -333,7 +333,6 @@ MODULE_DEVICE_TABLE(of, dt_ids);                                           \
 static struct spi_driver fbtft_driver_spi_driver = {                       \
 	.driver = {                                                        \
 		.name   = _name,                                           \
-		.owner  = THIS_MODULE,                                     \
 		.of_match_table = of_match_ptr(dt_ids),                    \
 	},                                                                 \
 	.probe  = fbtft_driver_probe_spi,                                  \
diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexfb.c
index c763efc..17e031f 100644
--- a/drivers/staging/fbtft/flexfb.c
+++ b/drivers/staging/fbtft/flexfb.c
@@ -586,7 +586,6 @@ static int flexfb_remove_pdev(struct platform_device *pdev)
 static struct spi_driver flexfb_spi_driver = {
 	.driver = {
 		.name   = DRVNAME,
-		.owner  = THIS_MODULE,
 	},
 	.probe  = flexfb_probe_spi,
 	.remove = flexfb_remove_spi,
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 10db685..06c0b75 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -235,7 +235,6 @@ static int adis16201_remove(struct spi_device *spi)
 static struct spi_driver adis16201_driver = {
 	.driver = {
 		.name = "adis16201",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16201_probe,
 	.remove = adis16201_remove,
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index fb593d2..de5b84a 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -203,7 +203,6 @@ static int adis16203_remove(struct spi_device *spi)
 static struct spi_driver adis16203_driver = {
 	.driver = {
 		.name = "adis16203",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16203_probe,
 	.remove = adis16203_remove,
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index ea0ac24..20a9df6 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -241,7 +241,6 @@ static int adis16204_remove(struct spi_device *spi)
 static struct spi_driver adis16204_driver = {
 	.driver = {
 		.name = "adis16204",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16204_probe,
 	.remove = adis16204_remove,
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index d1dc1a3..8b42bf8 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -235,7 +235,6 @@ static int adis16209_remove(struct spi_device *spi)
 static struct spi_driver adis16209_driver = {
 	.driver = {
 		.name = "adis16209",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16209_probe,
 	.remove = adis16209_remove,
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index e46a91c..d016521 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -482,7 +482,6 @@ static int adis16220_remove(struct spi_device *spi)
 static struct spi_driver adis16220_driver = {
 	.driver = {
 		.name = "adis16220",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16220_probe,
 	.remove = adis16220_remove,
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index cb074e8..1b5b685 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -288,7 +288,6 @@ static int adis16240_remove(struct spi_device *spi)
 static struct spi_driver adis16240_driver = {
 	.driver = {
 		.name = "adis16240",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16240_probe,
 	.remove = adis16240_remove,
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index ebcab56..24d90b3 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -800,7 +800,6 @@ static int lis3l02dq_remove(struct spi_device *spi)
 static struct spi_driver lis3l02dq_driver = {
 	.driver = {
 		.name = "lis3l02dq",
-		.owner = THIS_MODULE,
 	},
 	.probe = lis3l02dq_probe,
 	.remove = lis3l02dq_remove,
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index b614f27..fda6462 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1196,7 +1196,6 @@ MODULE_DEVICE_TABLE(spi, sca3000_id);
 static struct spi_driver sca3000_driver = {
 	.driver = {
 		.name = "sca3000",
-		.owner = THIS_MODULE,
 	},
 	.probe = sca3000_probe,
 	.remove = sca3000_remove,
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index fe56fb6..a3b7655 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -707,7 +707,6 @@ MODULE_DEVICE_TABLE(spi, ad7192_id);
 static struct spi_driver ad7192_driver = {
 	.driver = {
 		.name	= "ad7192",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7192_probe,
 	.remove		= ad7192_remove,
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d98e229..8a7c873 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -972,7 +972,6 @@ MODULE_DEVICE_TABLE(spi, ad7280_id);
 static struct spi_driver ad7280_driver = {
 	.driver = {
 		.name	= "ad7280",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7280_probe,
 	.remove		= ad7280_remove,
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 7303983..06b59cb 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -102,7 +102,6 @@ MODULE_DEVICE_TABLE(spi, ad7606_id);
 static struct spi_driver ad7606_driver = {
 	.driver = {
 		.name = "ad7606",
-		.owner = THIS_MODULE,
 		.pm    = AD7606_SPI_PM_OPS,
 	},
 	.probe = ad7606_spi_probe,
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 9f03fe3..b76dd15 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -263,7 +263,6 @@ MODULE_DEVICE_TABLE(spi, ad7780_id);
 static struct spi_driver ad7780_driver = {
 	.driver = {
 		.name	= "ad7780",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7780_probe,
 	.remove		= ad7780_remove,
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 48b1c37..f3bbb38 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -434,7 +434,6 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
 static struct spi_driver ad7816_driver = {
 	.driver = {
 		.name = "ad7816",
-		.owner = THIS_MODULE,
 	},
 	.probe = ad7816_probe,
 	.id_table = ad7816_id,
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index e480abb..5cd2274 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -132,7 +132,6 @@ static struct spi_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
 		.pm = ADT7316_PM_OPS,
-		.owner = THIS_MODULE,
 	},
 	.probe = adt7316_spi_probe,
 	.id_table = adt7316_spi_id,
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index a861fe0..2b65faa 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -339,7 +339,6 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
 static struct spi_driver ad9832_driver = {
 	.driver = {
 		.name	= "ad9832",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9832_probe,
 	.remove		= ad9832_remove,
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d02bb44..15f0cc3 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -446,7 +446,6 @@ MODULE_DEVICE_TABLE(spi, ad9834_id);
 static struct spi_driver ad9834_driver = {
 	.driver = {
 		.name	= "ad9834",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9834_probe,
 	.remove		= ad9834_remove,
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 4c5869d..b8776d6 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -202,7 +202,6 @@ static int adis16060_w_remove(struct spi_device *spi)
 static struct spi_driver adis16060_r_driver = {
 	.driver = {
 		.name = "adis16060_r",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16060_r_probe,
 };
@@ -210,7 +209,6 @@ static struct spi_driver adis16060_r_driver = {
 static struct spi_driver adis16060_w_driver = {
 	.driver = {
 		.name = "adis16060_w",
-		.owner = THIS_MODULE,
 	},
 	.probe = adis16060_w_probe,
 	.remove = adis16060_w_remove,
diff --git a/drivers/staging/iio/magnetometer/hmc5843_spi.c b/drivers/staging/iio/magnetometer/hmc5843_spi.c
index 8e658f7..070c918 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_spi.c
@@ -86,7 +86,6 @@ static struct spi_driver hmc5843_driver = {
 		.driver = {
 				.name = "hmc5843",
 				.pm = HMC5843_PM_OPS,
-				.owner = THIS_MODULE,
 		},
 		.id_table = hmc5843_id,
 		.probe = hmc5843_spi_probe,
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index ffc7f0d..9ca9fef 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -534,7 +534,6 @@ static int ade7753_remove(struct spi_device *spi)
 static struct spi_driver ade7753_driver = {
 	.driver = {
 		.name = "ade7753",
-		.owner = THIS_MODULE,
 	},
 	.probe = ade7753_probe,
 	.remove = ade7753_remove,
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index f12b2e5..5609872 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -575,7 +575,6 @@ static int ade7754_remove(struct spi_device *spi)
 static struct spi_driver ade7754_driver = {
 	.driver = {
 		.name = "ade7754",
-		.owner = THIS_MODULE,
 	},
 	.probe = ade7754_probe,
 	.remove = ade7754_remove,
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 77141ae..d348e16 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -904,7 +904,6 @@ MODULE_DEVICE_TABLE(spi, ade7758_id);
 static struct spi_driver ade7758_driver = {
 	.driver = {
 		.name = "ade7758",
-		.owner = THIS_MODULE,
 	},
 	.probe = ade7758_probe,
 	.remove = ade7758_remove,
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index dbceda1..f774a62 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -490,7 +490,6 @@ static int ade7759_remove(struct spi_device *spi)
 static struct spi_driver ade7759_driver = {
 	.driver = {
 		.name = "ade7759",
-		.owner = THIS_MODULE,
 	},
 	.probe = ade7759_probe,
 	.remove = ade7759_remove,
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 9b255a5..16f288d 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -314,7 +314,6 @@ MODULE_DEVICE_TABLE(spi, ade7854_id);
 static struct spi_driver ade7854_driver = {
 	.driver = {
 		.name = "ade7854",
-		.owner = THIS_MODULE,
 	},
 	.probe = ade7854_spi_probe,
 	.remove = ade7854_spi_remove,
diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index c17893b..595e711 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -155,7 +155,6 @@ MODULE_DEVICE_TABLE(spi, ad2s1200_id);
 static struct spi_driver ad2s1200_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 	},
 	.probe = ad2s1200_probe,
 	.id_table = ad2s1200_id,
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 7bc3e4a..95f5426 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -735,7 +735,6 @@ MODULE_DEVICE_TABLE(spi, ad2s1210_id);
 static struct spi_driver ad2s1210_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.owner = THIS_MODULE,
 	},
 	.probe = ad2s1210_probe,
 	.remove = ad2s1210_remove,
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index e24c589..cfeedfb 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -107,7 +107,6 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
 static struct spi_driver ad2s90_driver = {
 	.driver = {
 		.name = "ad2s90",
-		.owner = THIS_MODULE,
 	},
 	.probe = ad2s90_probe,
 	.remove = ad2s90_remove,
diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index ad30ce4..5a0e773 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -948,7 +948,6 @@ static const struct of_device_id spinand_dt[] = {
 static struct spi_driver spinand_driver = {
 	.driver = {
 		.name		= "mt29f",
-		.owner		= THIS_MODULE,
 		.of_match_table	= spinand_dt,
 	},
 	.probe		= spinand_probe,
diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 536a33b..88246f7 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1362,7 +1362,7 @@ static struct spi_driver ifx_spi_driver = {
 	.driver = {
 		.name = DRVNAME,
 		.pm = &ifx_spi_pm,
-		.owner = THIS_MODULE},
+	},
 	.probe = ifx_spi_spi_probe,
 	.shutdown = ifx_spi_spi_shutdown,
 	.remove = ifx_spi_spi_remove,
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 0773772..5c4c280 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -904,7 +904,6 @@ static SIMPLE_DEV_PM_OPS(max3100_pm_ops, max3100_suspend, max3100_resume);
 static struct spi_driver max3100_driver = {
 	.driver = {
 		.name		= "max3100",
-		.owner		= THIS_MODULE,
 		.pm		= MAX3100_PM_OPS,
 	},
 	.probe		= max3100_probe,
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 182549f..d451330 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1338,7 +1338,6 @@ MODULE_DEVICE_TABLE(spi, max310x_id_table);
 static struct spi_driver max310x_uart_driver = {
 	.driver = {
 		.name		= MAX310X_NAME,
-		.owner		= THIS_MODULE,
 		.of_match_table	= of_match_ptr(max310x_dt_ids),
 		.pm		= &max310x_pm_ops,
 	},
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 72ffd0dc..55b61d7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1357,7 +1357,6 @@ MODULE_DEVICE_TABLE(spi, sc16is7xx_spi_id_table);
 static struct spi_driver sc16is7xx_spi_uart_driver = {
 	.driver = {
 		.name		= SC16IS7XX_NAME,
-		.owner		= THIS_MODULE,
 		.of_match_table	= of_match_ptr(sc16is7xx_dt_ids),
 	},
 	.probe		= sc16is7xx_spi_probe,
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index fc1fd40..bd98706 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1944,7 +1944,6 @@ static struct spi_driver max3421_driver = {
 	.remove		= max3421_remove,
 	.driver		= {
 		.name	= "max3421-hcd",
-		.owner	= THIS_MODULE,
 	},
 };
 
diff --git a/drivers/video/backlight/ams369fg06.c b/drivers/video/backlight/ams369fg06.c
index 5f897f9..5cca8ce 100644
--- a/drivers/video/backlight/ams369fg06.c
+++ b/drivers/video/backlight/ams369fg06.c
@@ -556,7 +556,6 @@ static void ams369fg06_shutdown(struct spi_device *spi)
 static struct spi_driver ams369fg06_driver = {
 	.driver = {
 		.name	= "ams369fg06",
-		.owner	= THIS_MODULE,
 		.pm	= &ams369fg06_pm_ops,
 	},
 	.probe		= ams369fg06_probe,
diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
index d7c37a8..d7c239e 100644
--- a/drivers/video/backlight/corgi_lcd.c
+++ b/drivers/video/backlight/corgi_lcd.c
@@ -598,7 +598,6 @@ static int corgi_lcd_remove(struct spi_device *spi)
 static struct spi_driver corgi_lcd_driver = {
 	.driver		= {
 		.name	= "corgi-lcd",
-		.owner	= THIS_MODULE,
 		.pm	= &corgi_lcd_pm_ops,
 	},
 	.probe		= corgi_lcd_probe,
diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index e7f0890..a9e9cef 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -536,7 +536,6 @@ static int ili922x_remove(struct spi_device *spi)
 static struct spi_driver ili922x_driver = {
 	.driver = {
 		.name = "ili922x",
-		.owner = THIS_MODULE,
 	},
 	.probe = ili922x_probe,
 	.remove = ili922x_remove,
diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 5fa2649..e6054e2 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -255,7 +255,6 @@ static void l4f00242t03_shutdown(struct spi_device *spi)
 static struct spi_driver l4f00242t03_driver = {
 	.driver = {
 		.name	= "l4f00242t03",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= l4f00242t03_probe,
 	.remove		= l4f00242t03_remove,
diff --git a/drivers/video/backlight/ld9040.c b/drivers/video/backlight/ld9040.c
index f71eaf1..677f8ab 100644
--- a/drivers/video/backlight/ld9040.c
+++ b/drivers/video/backlight/ld9040.c
@@ -797,7 +797,6 @@ static void ld9040_shutdown(struct spi_device *spi)
 static struct spi_driver ld9040_driver = {
 	.driver = {
 		.name	= "ld9040",
-		.owner	= THIS_MODULE,
 		.pm	= &ld9040_pm_ops,
 	},
 	.probe		= ld9040_probe,
diff --git a/drivers/video/backlight/lms283gf05.c b/drivers/video/backlight/lms283gf05.c
index 14590c5..4237aaa 100644
--- a/drivers/video/backlight/lms283gf05.c
+++ b/drivers/video/backlight/lms283gf05.c
@@ -192,7 +192,6 @@ static int lms283gf05_probe(struct spi_device *spi)
 static struct spi_driver lms283gf05_driver = {
 	.driver = {
 		.name	= "lms283gf05",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= lms283gf05_probe,
 };
diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
index 7e38103..8aa3e76 100644
--- a/drivers/video/backlight/lms501kf03.c
+++ b/drivers/video/backlight/lms501kf03.c
@@ -422,7 +422,6 @@ static void lms501kf03_shutdown(struct spi_device *spi)
 static struct spi_driver lms501kf03_driver = {
 	.driver = {
 		.name	= "lms501kf03",
-		.owner	= THIS_MODULE,
 		.pm	= &lms501kf03_pm_ops,
 	},
 	.probe		= lms501kf03_probe,
diff --git a/drivers/video/backlight/ltv350qv.c b/drivers/video/backlight/ltv350qv.c
index 383f550..885612c 100644
--- a/drivers/video/backlight/ltv350qv.c
+++ b/drivers/video/backlight/ltv350qv.c
@@ -295,7 +295,6 @@ static void ltv350qv_shutdown(struct spi_device *spi)
 static struct spi_driver ltv350qv_driver = {
 	.driver = {
 		.name		= "ltv350qv",
-		.owner		= THIS_MODULE,
 		.pm		= &ltv350qv_pm_ops,
 	},
 
diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 28bfa12..3c4a22a 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -842,7 +842,6 @@ static void s6e63m0_shutdown(struct spi_device *spi)
 static struct spi_driver s6e63m0_driver = {
 	.driver = {
 		.name	= "s6e63m0",
-		.owner	= THIS_MODULE,
 		.pm	= &s6e63m0_pm_ops,
 	},
 	.probe		= s6e63m0_probe,
diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
index 30afce3..eab1f84 100644
--- a/drivers/video/backlight/tdo24m.c
+++ b/drivers/video/backlight/tdo24m.c
@@ -437,7 +437,6 @@ static void tdo24m_shutdown(struct spi_device *spi)
 static struct spi_driver tdo24m_driver = {
 	.driver = {
 		.name		= "tdo24m",
-		.owner		= THIS_MODULE,
 		.pm		= &tdo24m_pm_ops,
 	},
 	.probe		= tdo24m_probe,
diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
index f08d641..6a41ea9 100644
--- a/drivers/video/backlight/tosa_lcd.c
+++ b/drivers/video/backlight/tosa_lcd.c
@@ -263,7 +263,6 @@ static SIMPLE_DEV_PM_OPS(tosa_lcd_pm_ops, tosa_lcd_suspend, tosa_lcd_resume);
 static struct spi_driver tosa_lcd_driver = {
 	.driver = {
 		.name		= "tosa-lcd",
-		.owner		= THIS_MODULE,
 		.pm		= &tosa_lcd_pm_ops,
 	},
 	.probe		= tosa_lcd_probe,
diff --git a/drivers/video/backlight/vgg2432a4.c b/drivers/video/backlight/vgg2432a4.c
index d538947..242a994 100644
--- a/drivers/video/backlight/vgg2432a4.c
+++ b/drivers/video/backlight/vgg2432a4.c
@@ -251,7 +251,6 @@ static SIMPLE_DEV_PM_OPS(vgg2432a4_pm_ops, vgg2432a4_suspend, vgg2432a4_resume);
 static struct spi_driver vgg2432a4_driver = {
 	.driver = {
 		.name		= "VGG2432A4",
-		.owner		= THIS_MODULE,
 		.pm		= &vgg2432a4_pm_ops,
 	},
 	.probe		= vgg2432a4_probe,
diff --git a/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c b/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
index 998978b..f7e85d1 100644
--- a/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
+++ b/drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
@@ -175,7 +175,6 @@ static int tpohvga_probe(struct spi_device *spi)
 static struct spi_driver panel_tpohvga_driver = {
 	.driver		= {
 		.name	= "tpo-hvga",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= tpohvga_probe,
 };
diff --git a/drivers/video/fbdev/omap/lcd_mipid.c b/drivers/video/fbdev/omap/lcd_mipid.c
index 803fee6..0e4cee9 100644
--- a/drivers/video/fbdev/omap/lcd_mipid.c
+++ b/drivers/video/fbdev/omap/lcd_mipid.c
@@ -603,7 +603,6 @@ static int mipid_spi_remove(struct spi_device *spi)
 static struct spi_driver mipid_spi_driver = {
 	.driver = {
 		.name	= MIPID_MODULE_NAME,
-		.owner	= THIS_MODULE,
 	},
 	.probe	= mipid_spi_probe,
 	.remove	= mipid_spi_remove,
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
index 6a1b6a8..18eb60e 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
@@ -391,7 +391,6 @@ static struct spi_driver lb035q02_spi_driver = {
 	.remove		= lb035q02_panel_spi_remove,
 	.driver		= {
 		.name	= "panel_lgphilips_lb035q02",
-		.owner	= THIS_MODULE,
 		.of_match_table = lb035q02_of_match,
 		.suppress_bind_attrs = true,
 	},
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c b/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
index ccf3f4f..8a928c9 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
@@ -421,7 +421,6 @@ MODULE_DEVICE_TABLE(of, nec_8048_of_match);
 static struct spi_driver nec_8048_driver = {
 	.driver = {
 		.name	= "panel-nec-nl8048hl11",
-		.owner	= THIS_MODULE,
 		.pm	= NEC_8048_PM_OPS,
 		.of_match_table = nec_8048_of_match,
 		.suppress_bind_attrs = true,
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
index 90cbc4c..14c3283 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
@@ -902,7 +902,6 @@ static const struct of_device_id acx565akm_of_match[] = {
 static struct spi_driver acx565akm_driver = {
 	.driver = {
 		.name	= "acx565akm",
-		.owner	= THIS_MODULE,
 		.of_match_table = acx565akm_of_match,
 		.suppress_bind_attrs = true,
 	},
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
index 9edc511..4d657f3 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
@@ -498,7 +498,6 @@ static struct spi_driver td028ttec1_spi_driver = {
 
 	.driver         = {
 		.name   = "panel-tpo-td028ttec1",
-		.owner  = THIS_MODULE,
 		.of_match_table = td028ttec1_of_match,
 		.suppress_bind_attrs = true,
 	},
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
index 79e4a02..68e3b68 100644
--- a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
@@ -670,7 +670,6 @@ MODULE_DEVICE_TABLE(of, tpo_td043_of_match);
 static struct spi_driver tpo_td043_spi_driver = {
 	.driver = {
 		.name	= "panel-tpo-td043mtea1",
-		.owner	= THIS_MODULE,
 		.pm	= &tpo_td043_spi_pm,
 		.of_match_table = tpo_td043_of_match,
 		.suppress_bind_attrs = true,
diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 95f0bec..e2ce6c4 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -404,7 +404,6 @@ MODULE_DEVICE_TABLE(spi, ad1836_ids);
 static struct spi_driver ad1836_spi_driver = {
 	.driver = {
 		.name	= "ad1836",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad1836_spi_probe,
 	.remove		= ad1836_spi_remove,
diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
index 390cef9..8199a3d 100644
--- a/sound/soc/codecs/ad193x-spi.c
+++ b/sound/soc/codecs/ad193x-spi.c
@@ -36,7 +36,6 @@ static int ad193x_spi_remove(struct spi_device *spi)
 static struct spi_driver ad193x_spi_driver = {
 	.driver = {
 		.name	= "ad193x",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= ad193x_spi_probe,
 	.remove		= ad193x_spi_remove,
diff --git a/sound/soc/codecs/adau1761-spi.c b/sound/soc/codecs/adau1761-spi.c
index cce2f11..8bc1fbd 100644
--- a/sound/soc/codecs/adau1761-spi.c
+++ b/sound/soc/codecs/adau1761-spi.c
@@ -64,7 +64,6 @@ MODULE_DEVICE_TABLE(spi, adau1761_spi_id);
 static struct spi_driver adau1761_spi_driver = {
 	.driver = {
 		.name = "adau1761",
-		.owner = THIS_MODULE,
 	},
 	.probe = adau1761_spi_probe,
 	.remove = adau1761_spi_remove,
diff --git a/sound/soc/codecs/adau1781-spi.c b/sound/soc/codecs/adau1781-spi.c
index 1946867..33a73ff 100644
--- a/sound/soc/codecs/adau1781-spi.c
+++ b/sound/soc/codecs/adau1781-spi.c
@@ -62,7 +62,6 @@ MODULE_DEVICE_TABLE(spi, adau1781_spi_id);
 static struct spi_driver adau1781_spi_driver = {
 	.driver = {
 		.name = "adau1781",
-		.owner = THIS_MODULE,
 	},
 	.probe = adau1781_spi_probe,
 	.remove = adau1781_spi_remove,
diff --git a/sound/soc/codecs/adau1977-spi.c b/sound/soc/codecs/adau1977-spi.c
index b05cf5d..0b46d88b 100644
--- a/sound/soc/codecs/adau1977-spi.c
+++ b/sound/soc/codecs/adau1977-spi.c
@@ -63,7 +63,6 @@ MODULE_DEVICE_TABLE(spi, adau1977_spi_ids);
 static struct spi_driver adau1977_spi_driver = {
 	.driver = {
 		.name = "adau1977",
-		.owner = THIS_MODULE,
 	},
 	.probe = adau1977_spi_probe,
 	.remove = adau1977_spi_remove,
diff --git a/sound/soc/codecs/adav801.c b/sound/soc/codecs/adav801.c
index 790fce3..055f122 100644
--- a/sound/soc/codecs/adav801.c
+++ b/sound/soc/codecs/adav801.c
@@ -39,7 +39,6 @@ static int adav80x_spi_remove(struct spi_device *spi)
 static struct spi_driver adav80x_spi_driver = {
 	.driver = {
 		.name	= "adav801",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= adav80x_spi_probe,
 	.remove		= adav80x_spi_remove,
diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 1fd7f72..595d02d 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -344,7 +344,6 @@ MODULE_DEVICE_TABLE(spi, ak4104_id_table);
 static struct spi_driver ak4104_spi_driver = {
 	.driver  = {
 		.name   = "ak4104",
-		.owner  = THIS_MODULE,
 		.of_match_table = ak4104_of_match,
 	},
 	.id_table = ak4104_id_table,
diff --git a/sound/soc/codecs/cs4271-spi.c b/sound/soc/codecs/cs4271-spi.c
index acd49d8..1ff5f52 100644
--- a/sound/soc/codecs/cs4271-spi.c
+++ b/sound/soc/codecs/cs4271-spi.c
@@ -42,7 +42,6 @@ static int cs4271_spi_remove(struct spi_device *spi)
 static struct spi_driver cs4271_spi_driver = {
 	.driver = {
 		.name	= "cs4271",
-		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(cs4271_dt_ids),
 	},
 	.probe		= cs4271_spi_probe,
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 7dc52fe..af23a61 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -1339,7 +1339,6 @@ static int da7210_spi_remove(struct spi_device *spi)
 static struct spi_driver da7210_spi_driver = {
 	.driver = {
 		.name = "da7210",
-		.owner = THIS_MODULE,
 	},
 	.probe = da7210_spi_probe,
 	.remove = da7210_spi_remove
diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index 57b0c94..08bb486 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -257,7 +257,6 @@ MODULE_DEVICE_TABLE(spi, pcm1792a_spi_ids);
 static struct spi_driver pcm1792a_codec_driver = {
 	.driver = {
 		.name = "pcm1792a",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(pcm1792a_of_match),
 	},
 	.id_table = pcm1792a_spi_ids,
diff --git a/sound/soc/codecs/pcm512x-spi.c b/sound/soc/codecs/pcm512x-spi.c
index 7b64a9c..712ed65 100644
--- a/sound/soc/codecs/pcm512x-spi.c
+++ b/sound/soc/codecs/pcm512x-spi.c
@@ -64,7 +64,6 @@ static struct spi_driver pcm512x_spi_driver = {
 	.id_table	= pcm512x_spi_id,
 	.driver = {
 		.name	= "pcm512x",
-		.owner	= THIS_MODULE,
 		.of_match_table = pcm512x_of_match,
 		.pm     = &pcm512x_pm_ops,
 	},
diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 3505aaf..91879ea 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -232,7 +232,6 @@ static int rt5677_spi_probe(struct spi_device *spi)
 static struct spi_driver rt5677_spi_driver = {
 	.driver = {
 		.name = "rt5677",
-		.owner = THIS_MODULE,
 	},
 	.probe = rt5677_spi_probe,
 };
diff --git a/sound/soc/codecs/ssm2602-spi.c b/sound/soc/codecs/ssm2602-spi.c
index b5df14f..842f373 100644
--- a/sound/soc/codecs/ssm2602-spi.c
+++ b/sound/soc/codecs/ssm2602-spi.c
@@ -35,7 +35,6 @@ MODULE_DEVICE_TABLE(of, ssm2602_of_match);
 static struct spi_driver ssm2602_spi_driver = {
 	.driver = {
 		.name	= "ssm2602",
-		.owner	= THIS_MODULE,
 		.of_match_table = ssm2602_of_match,
 	},
 	.probe		= ssm2602_spi_probe,
diff --git a/sound/soc/codecs/tlv320aic23-spi.c b/sound/soc/codecs/tlv320aic23-spi.c
index 3b387e4..f801ae0 100644
--- a/sound/soc/codecs/tlv320aic23-spi.c
+++ b/sound/soc/codecs/tlv320aic23-spi.c
@@ -43,7 +43,6 @@ static int aic23_spi_remove(struct spi_device *spi)
 static struct spi_driver aic23_spi = {
 	.driver = {
 		.name = "tlv320aic23",
-		.owner = THIS_MODULE,
 	},
 	.probe = aic23_spi_probe,
 	.remove = aic23_spi_remove,
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 620ab9e..2c904d7 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -373,7 +373,6 @@ static int aic26_spi_remove(struct spi_device *spi)
 static struct spi_driver aic26_spi = {
 	.driver = {
 		.name = "tlv320aic26-codec",
-		.owner = THIS_MODULE,
 	},
 	.probe = aic26_spi_probe,
 	.remove = aic26_spi_remove,
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index f2c6ad4..9cf4a0d 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -1003,7 +1003,6 @@ static int wm0010_spi_remove(struct spi_device *spi)
 static struct spi_driver wm0010_spi_driver = {
 	.driver = {
 		.name	= "wm0010",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= wm0010_spi_probe,
 	.remove		= wm0010_spi_remove,
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index b098a83..99e40e6 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -644,7 +644,6 @@ static int wm8510_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8510_spi_driver = {
 	.driver = {
 		.name	= "wm8510",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8510_of_match,
 	},
 	.probe		= wm8510_spi_probe,
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 44b9e0a..c759ec0 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -431,7 +431,6 @@ static int wm8711_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8711_spi_driver = {
 	.driver = {
 		.name	= "wm8711",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8711_of_match,
 	},
 	.probe		= wm8711_spi_probe,
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index cd7b024..1564e69 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -272,7 +272,6 @@ static int wm8728_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8728_spi_driver = {
 	.driver = {
 		.name	= "wm8728",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8728_of_match,
 	},
 	.probe		= wm8728_spi_probe,
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index ace8645..15bd547 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -718,7 +718,6 @@ static int wm8731_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8731_spi_driver = {
 	.driver = {
 		.name	= "wm8731",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8731_of_match,
 	},
 	.probe		= wm8731_spi_probe,
diff --git a/sound/soc/codecs/wm8737.c b/sound/soc/codecs/wm8737.c
index e4a03d9..e780760 100644
--- a/sound/soc/codecs/wm8737.c
+++ b/sound/soc/codecs/wm8737.c
@@ -707,7 +707,6 @@ static int wm8737_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8737_spi_driver = {
 	.driver = {
 		.name	= "wm8737",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8737_of_match,
 	},
 	.probe		= wm8737_spi_probe,
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index de42c03..36ef91f 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -657,7 +657,6 @@ static int wm8741_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8741_spi_driver = {
 	.driver = {
 		.name	= "wm8741",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8741_of_match,
 	},
 	.probe		= wm8741_spi_probe,
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 873933a..bd9dcd2 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -777,7 +777,6 @@ MODULE_DEVICE_TABLE(spi, wm8750_spi_ids);
 static struct spi_driver wm8750_spi_driver = {
 	.driver = {
 		.name	= "wm8750",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8750_of_match,
 	},
 	.id_table	= wm8750_spi_ids,
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index a801c6d..61299ca 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1549,7 +1549,6 @@ static int wm8753_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8753_spi_driver = {
 	.driver = {
 		.name	= "wm8753",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8753_of_match,
 	},
 	.probe		= wm8753_spi_probe,
diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 66c1f15..df61784 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -703,7 +703,6 @@ static int wm8770_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8770_spi_driver = {
 	.driver = {
 		.name = "wm8770",
-		.owner = THIS_MODULE,
 		.of_match_table = wm8770_of_match,
 	},
 	.probe = wm8770_spi_probe,
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 183c9a4..5af44f9 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -488,7 +488,6 @@ static int wm8776_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8776_spi_driver = {
 	.driver = {
 		.name	= "wm8776",
-		.owner	= THIS_MODULE,
 		.of_match_table = wm8776_of_match,
 	},
 	.probe		= wm8776_spi_probe,
diff --git a/sound/soc/codecs/wm8804-spi.c b/sound/soc/codecs/wm8804-spi.c
index 407a3cf..9998c78 100644
--- a/sound/soc/codecs/wm8804-spi.c
+++ b/sound/soc/codecs/wm8804-spi.c
@@ -42,7 +42,6 @@ MODULE_DEVICE_TABLE(of, wm8804_of_match);
 static struct spi_driver wm8804_spi_driver = {
 	.driver = {
 		.name = "wm8804",
-		.owner = THIS_MODULE,
 		.pm = &wm8804_pm,
 		.of_match_table = wm8804_of_match,
 	},
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 98900aa..5d8dca88 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1266,7 +1266,6 @@ static int wm8900_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8900_spi_driver = {
 	.driver = {
 		.name	= "wm8900",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8900_spi_probe,
 	.remove		= wm8900_spi_remove,
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index f3193fb..7350ff6 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -1033,7 +1033,6 @@ static int wm8983_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8983_spi_driver = {
 	.driver = {
 		.name = "wm8983",
-		.owner = THIS_MODULE,
 	},
 	.probe = wm8983_spi_probe,
 	.remove = wm8983_spi_remove
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 9c3c151..9918152 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1096,7 +1096,6 @@ static int wm8985_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8985_spi_driver = {
 	.driver = {
 		.name = "wm8985",
-		.owner = THIS_MODULE,
 	},
 	.probe = wm8985_spi_probe,
 	.remove = wm8985_spi_remove
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index c88ce99..895721a2 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -871,7 +871,6 @@ static int wm8988_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8988_spi_driver = {
 	.driver = {
 		.name	= "wm8988",
-		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8988_spi_probe,
 	.remove		= wm8988_spi_remove,
diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index eda52a9..24500ba 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -2246,7 +2246,6 @@ static int wm8995_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8995_spi_driver = {
 	.driver = {
 		.name = "wm8995",
-		.owner = THIS_MODULE,
 	},
 	.probe = wm8995_spi_probe,
 	.remove = wm8995_spi_remove
-- 
1.9.1
