From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] beagle-daq: Initial commit of board devices setup
Date: Sun, 13 Feb 2011 17:10:34 -0500
Message-ID: <1297635034-24504-2-git-send-email-bgamari.foss@gmail.com>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

---
 arch/arm/mach-omap2/board-omap3beagle.c |  204 ++++++++++++++++++++++++++++++-
 1 files changed, 201 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..ad72685 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -29,8 +29,10 @@
 #include <linux/mtd/nand.h>
 #include <linux/mmc/host.h>
 
+#include <linux/spi/spi.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
+#include <linux/i2c/pca953x.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -44,6 +46,7 @@
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
+#include <plat/mcspi.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -413,10 +416,18 @@ static struct i2c_board_info __initdata beagle_i2c_boardinfo[] = {
 	},
 };
 
+static struct pca953x_platform_data beagledaq_gpio_expander_info = {
+	.gpio_base = OMAP_MAX_GPIO_LINES,
+};
+
 static struct i2c_board_info __initdata beagle_i2c_eeprom[] = {
-       {
-               I2C_BOARD_INFO("eeprom", 0x50),
-       },
+	{
+		I2C_BOARD_INFO("eeprom", 0x50),
+	},
+	{
+		I2C_BOARD_INFO("tca6416", 0x21),
+		.platform_data = &beagledaq_gpio_expander_info,
+	},
 };
 
 static int __init omap3_beagle_i2c_init(void)
@@ -425,6 +436,9 @@ static int __init omap3_beagle_i2c_init(void)
 			ARRAY_SIZE(beagle_i2c_boardinfo));
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
+	gpio_request(139, "GPIO-IRQ");
+	gpio_direction_input(139);
+	beagledaq_gpio_expander_info.irq_base = gpio_to_irq(139);
 	omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
 	return 0;
 }
@@ -499,6 +513,188 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&beagle_dss_device,
 };
 
+int csmux_set_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return -ENOSYS;
+}
+
+int csmux_set_direction_output(struct gpio_chip *chip, unsigned offset, int value)
+{
+	return -ENOSYS;
+}
+
+static int csmux_get(struct gpio_chip *chip, unsigned offset)
+{
+	return -ENOSYS;
+}
+
+#define BEAGLEDAQ_CONVSTART    145
+#define BEAGLEDAQ_ADC_CS_EN	135
+#define BEAGLEDAQ_ADC_CS_MUX0	134
+#define BEAGLEDAQ_ADC_CS_MUX1	133
+#define BEAGLEDAQ_DAC_CS_EN	161
+#define BEAGLEDAQ_DAC_CS_MUX0	157
+#define BEAGLEDAQ_DAC_CS_MUX1	162
+
+static void adc_csmux_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	gpio_set_value(BEAGLEDAQ_ADC_CS_EN, 0);
+	gpio_set_value(BEAGLEDAQ_ADC_CS_MUX0, (offset & 0x1) != 0);
+	gpio_set_value(BEAGLEDAQ_ADC_CS_MUX1, (offset & 0x2) != 0);
+	if (value) gpio_set_value(BEAGLEDAQ_ADC_CS_EN, 1);
+}
+
+static const char* adc_csmux_names[] = { "adc1", "adc2", "adc3", "adc4" };
+
+static struct gpio_chip adc_csmux_chip = {
+	.label = "BeagleDAQ ADC chip selects",
+	.direction_input = csmux_set_direction_input,
+	.get = csmux_get,
+	.direction_output = csmux_set_direction_output,
+	.set = adc_csmux_set,
+	.base = -1,
+	.ngpio = 4,
+	.names = adc_csmux_names,
+};
+
+void dac_csmux_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	gpio_set_value(BEAGLEDAQ_DAC_CS_EN, 0);
+	gpio_set_value(BEAGLEDAQ_DAC_CS_MUX0, (offset & 0x1) != 0);
+	gpio_set_value(BEAGLEDAQ_DAC_CS_MUX1, (offset & 0x2) != 0);
+	if (value) gpio_set_value(BEAGLEDAQ_DAC_CS_EN, 1);
+};
+
+static const char* dac_csmux_names[] = { "dac1", "dac2", "dac3", "dac4" };
+
+static struct gpio_chip dac_csmux_chip = {
+	.label = "BeagleDAQ DAC chip selects",
+	.dev = NULL,
+	.direction_input = csmux_set_direction_input,
+	.get = csmux_get,
+	.direction_output = csmux_set_direction_output,
+	.set = dac_csmux_set,
+	.base = -1,
+	.ngpio = 4,
+	.names = dac_csmux_names,
+};
+
+#define MBIT_SEC 1000000
+static struct spi_board_info beagle_mcspi_board_info[] = {
+	// spi 3.0
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 3,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_1,
+	},
+	// spi 3.1
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 3,
+		.chip_select	= 1,
+		.mode		= SPI_MODE_1,
+	},
+	// spi 3.2
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 3,
+		.chip_select	= 2,
+		.mode		= SPI_MODE_1,
+	},
+	// spi 3.3
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 3,
+		.chip_select	= 3,
+		.mode		= SPI_MODE_1,
+	},
+
+	// spi 4.0
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 4,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_1,
+	},
+	// spi 4.1
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 4,
+		.chip_select	= 1,
+		.mode		= SPI_MODE_1,
+	},
+	// spi 4.2
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 4,
+		.chip_select	= 2,
+		.mode		= SPI_MODE_1,
+	},
+	// spi 4.3
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 20*MBIT_SEC,
+		.bus_num	= 4,
+		.chip_select	= 3,
+		.mode		= SPI_MODE_1,
+	},
+};
+
+static void __init omap3_beagle_config_mcspi3_pins(void)
+{
+	// NOTE: Clock pins need to be in input mode
+	omap_mux_init_signal("sdmmc2_clk.mcspi3_clk", OMAP_PIN_INPUT);
+	omap_mux_init_signal("sdmmc2_cmd.mcspi3_simo", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdmmc2_dat0.mcspi3_somi", OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("sdmmc2_dat3.gpio135", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdmmc2_dat2.gpio134", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("sdmmc2_dat1.gpio133", OMAP_PIN_OUTPUT);
+}
+
+static void __init omap3_beagle_config_mcspi4_pins(void)
+{
+	// NOTE: Clock pins need to be in input mode
+	omap_mux_init_signal("mcbsp1_clkr.mcspi4_clk", OMAP_PIN_INPUT);
+	omap_mux_init_signal("mcbsp1_dx.mcspi4_simo", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("mcbsp1_dr.mcspi4_somi", OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("mcbsp1_fsx.gpio161", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("mcbsp1_fsr.gpio157", OMAP_PIN_OUTPUT);
+	omap_mux_init_signal("mcbsp1_clkx.gpio162", OMAP_PIN_OUTPUT);
+}
+
+static void __init omap3_beagledaq_init(void)
+{
+	gpio_request_one(BEAGLEDAQ_CONVSTART, GPIOF_OUT_INIT_LOW, "BeagleDAQ conversion trigger");
+	gpio_export(BEAGLEDAQ_CONVSTART, false);
+
+	omap3_beagle_config_mcspi3_pins();
+	omap3_beagle_config_mcspi4_pins();
+
+	gpiochip_add(&adc_csmux_chip);
+	gpiochip_add(&dac_csmux_chip);
+
+	beagle_mcspi_board_info[0].controller_data = (void*) adc_csmux_chip.base + 0;
+	beagle_mcspi_board_info[1].controller_data = (void*) adc_csmux_chip.base + 1;
+	beagle_mcspi_board_info[2].controller_data = (void*) adc_csmux_chip.base + 2;
+	beagle_mcspi_board_info[3].controller_data = (void*) adc_csmux_chip.base + 3;
+
+	beagle_mcspi_board_info[4].controller_data = (void*) dac_csmux_chip.base + 0;
+	beagle_mcspi_board_info[5].controller_data = (void*) dac_csmux_chip.base + 1;
+	beagle_mcspi_board_info[6].controller_data = (void*) dac_csmux_chip.base + 2;
+	beagle_mcspi_board_info[7].controller_data = (void*) dac_csmux_chip.base + 3;
+
+	spi_register_board_info(beagle_mcspi_board_info,
+			ARRAY_SIZE(beagle_mcspi_board_info));
+}
+
 static void __init omap3beagle_flash_init(void)
 {
 	u8 cs = 0;
@@ -567,6 +763,8 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();
 
+	omap3_beagledaq_init();
+
 	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
 	gpio_request(170, "DVI_nPD");
 	/* REVISIT leave DVI powered down until it's needed ... */
-- 
1.7.0.4


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
