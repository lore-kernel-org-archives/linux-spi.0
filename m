From: Gary Jennejohn <gary.jennejohn-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>
Subject: [PATCH] SPI: driver for the 400EPx
Date: Mon, 14 Jan 2008 14:58:37 +0100
Message-ID: <20080114145837.16331f9d@peedub.jennejohn.org>
Reply-To: gary.jennejohn-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



From: Gary Jennejohn <garyj-ynQEQJNshbs@public.gmane.org>

commit d8af1d29fdbd0a6614c01582ea09115b7c51e773
Author: Gary Jennejohn <garyj-ynQEQJNshbs@public.gmane.org>
Date:   Thu Jan 10 13:25:48 2008 +0100

    Add a driver for the SPI controller in the 440EPx. The driver works
    with both arch/ppc and arch/powerpc.
    
    Add hardware resources for SPI and GPIO (GPIO for powerpc only).
    
    Block use of IIC1 when the SPI controller is used because they share
    a configuration register.
    
    Signed-off-by: Gary Jennejohn <garyj-ynQEQJNshbs@public.gmane.org>
---

diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 27837ed..3316231 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -294,6 +294,29 @@
 				interrupts = <7 4>;
 			};
 
+			SPI0: spi@ef600900 {
+				device_type = "spi";
+				compatible = "ibm,spi-440epx", "ibm,spi";
+				reg = <ef600900 7>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <8 4>;
+			};
+  			
+  
+			GPIO0: gpio@ef600b00 {
+				compatible = "ibm,gpio-440epx", "ibm,gpio";
+				#address-cells = <0>;
+				#size-cells = <0>;
+				reg = <ef600b00 44>;
+			};
+
+			GPIO1: gpio@ef600c00 {
+				compatible = "ibm,gpio-440epx", "ibm,gpio";
+				#address-cells = <0>;
+				#size-cells = <0>;
+				reg = <ef600c00 44>;
+			};
+
 			ZMII0: emac-zmii@ef600d00 {
 				device_type = "zmii-interface";
 				compatible = "ibm,zmii-440epx", "ibm,zmii";
diff --git a/arch/ppc/platforms/4xx/ppc440epx.c b/arch/ppc/platforms/4xx/ppc440epx.c
index 597bc79..a8e1566 100644
--- a/arch/ppc/platforms/4xx/ppc440epx.c
+++ b/arch/ppc/platforms/4xx/ppc440epx.c
@@ -69,9 +69,12 @@ static struct ocp_func_iic_data ppc440ep
 	.fast_mode	= 0,		/* Use standad mode (100Khz) */
 };
 
+/* either IIC1 or SPI! */
+#if !defined(CONFIG_SPI_PPC4xx) && !defined(CONFIG_SPI_PPC4xx_MODULE)
 static struct ocp_func_iic_data ppc440epx_iic1_def = {
 	.fast_mode	= 0,		/* Use standad mode (100Khz) */
 };
+#endif
 OCP_SYSFS_IIC_DATA()
 
 struct ocp_def core_ocp[] = {
@@ -119,6 +122,8 @@ struct ocp_def core_ocp[] = {
 	  .additions	= &ppc440epx_iic0_def,
 	  .show		= &ocp_show_iic_data
 	},
+/* either IIC1 or SPI! */
+#if !defined(CONFIG_SPI_PPC4xx) && !defined(CONFIG_SPI_PPC4xx_MODULE)
 	{ .vendor	= OCP_VENDOR_IBM,
 	  .function	= OCP_FUNC_IIC,
 	  .index	= 1,
@@ -128,6 +133,7 @@ struct ocp_def core_ocp[] = {
 	  .additions	= &ppc440epx_iic1_def,
 	  .show		= &ocp_show_iic_data
 	},
+#endif
 	{ .vendor	= OCP_VENDOR_IBM,
 	  .function	= OCP_FUNC_GPIO,
 	  .index	= 0,
@@ -241,6 +247,19 @@ static struct resource ehci_usb_resource
 	},
 };
 
+static struct resource spi_resources[] = {
+	[0] = {
+		.start	= 0x0EF600900,
+		.end	= 0x0EF600906,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static u64 dma_mask = 0xffffffffULL;
 
 static struct platform_device ohci_usb_device = {
@@ -276,10 +295,19 @@ static struct platform_device ehci_usb_d
 	}
 };
 
+static struct platform_device ppc4xx_spi_device = {
+	/* this must agree with driver.name  used in the SPI driver! */
+	.name		= "spi_ppc4xx",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(spi_resources),
+	.resource	= spi_resources,
+};
+
 static struct platform_device *ppc440epx_devs[] __initdata = {
 	&ohci_usb_device,
 	&ehci_usb_device,
 	&usb_gadget_device,
+	&ppc4xx_spi_device,
 };
 
 static int __init ppc440epx_platform_add_devices(void)
diff --git a/drivers/i2c/busses/i2c-ibm_of.c b/drivers/i2c/busses/i2c-ibm_of.c
index 5fc6594..f2ea0ef 100644
--- a/drivers/i2c/busses/i2c-ibm_of.c
+++ b/drivers/i2c/busses/i2c-ibm_of.c
@@ -1,5 +1,5 @@
 /*
- * drivers/i2c/busses/i2c-ibm_iic.c
+ * drivers/i2c/busses/i2c-ibm_of.c
  *
  * Support for the IIC peripheral on IBM PPC 4xx
  *
@@ -703,6 +703,15 @@ static int __devinit iic_probe (struct o
 	}
 	dev->paddr = res.start;
 
+#if (defined(CONFIG_SPI_PPC4xx) || defined(CONFIG_SPI_PPC4xx_MODULE)) \
+	&& defined(CONFIG_440EPX)
+	/*
+	 * Hack, but on the 440EPx we can have either IIC1 or SPI.
+	 */
+	if (dev->paddr == 0x1ef600800ULL)
+		goto fail1;
+#endif
+
 	if (!request_mem_region(dev->paddr, sizeof(struct iic_regs),
 				"ibm_iic")) {
 		ret = -EBUSY;
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b2c8d53..088b3af 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -160,6 +160,13 @@ config SPI_OMAP24XX
 	  SPI master controller for OMAP24xx Multichannel SPI
 	  (McSPI) modules.
 
+config SPI_PPC4xx
+	tristate "PPC4xx SPI Controller"
+	depends on 440EPX && SPI_MASTER
+	select SPI_BITBANG
+	help
+	  This selects a driver for the 440EPx SPI Controller.
+
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
 	depends on SPI_MASTER && ARCH_PXA && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index dd1b39a..dfd6720 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
+obj-$(CONFIG_SPI_PPC4xx)		+= spi_ppc4xx.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/spi_ppc4xx.c b/drivers/spi/spi_ppc4xx.c
new file mode 100644
index 0000000..d5235c6
--- /dev/null
+++ b/drivers/spi/spi_ppc4xx.c
@@ -0,0 +1,880 @@
+/*
+ * SPI_PPC4XX SPI controller driver.
+ * Copyright (C) 2008 Gary Jenneohn <garyj-ynQEQJNshbs@public.gmane.org>
+ *
+ * Based in part on drivers/spi/spi_s3c24xx.c
+ *
+ * Copyright (c) 2006 Ben Dooks
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#undef DEBUG
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#ifdef CONFIG_PPC_OF
+#include <asm/of_platform.h>
+#else
+#include <asm/ocp.h> /* deprecated */
+#include <linux/platform_device.h>
+#endif
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <asm/io.h>
+#include <asm/dcr-native.h>
+
+/* Attention! These may be 440EPx specific. */
+struct spi_ppc4xx_regs {
+	u8	mode;
+	u8	rxd;
+	u8	txd;
+	u8	cr;
+	u8	sr;
+	u8	dummy;
+	/*
+	 * Clock divisor modulus register
+	 * This uses the follwing formula:
+	 *    SCPClkOut = OPBCLK/(4(CDM + 1))
+	 * or
+	 *    CDM = (OPBCLK/4*SCPClkOut) - 1
+	 */
+	u8	cdm;
+};
+
+/* bits in mode register - bit 0 ist MSb */
+/* data latched on leading edge of clock, else trailing edge */
+#define SPI_PPC4XX_MODE_SCP	(0x80 >> 3)
+/* port enabled */
+#define SPI_PPC4XX_MODE_SPE	(0x80 >> 4)
+/* MSB first, else LSB first */
+#define SPI_PPC4XX_MODE_RD	(0x80 >> 5)
+/* clock invert - idle clock = 1, active clock = 0; else reversed */
+#define SPI_PPC4XX_MODE_CI	(0x80 >> 6)
+/* loopback enable */
+#define SPI_PPC4XX_MODE_IL	(0x80 >> 7)
+/* bits in control register */
+/* starts a transfer when set */
+#define SPI_PPC4XX_CR_STR	(0x80 >> 7)
+/* bits in status register */
+/* port is busy with a transfer */
+#define SPI_PPC4XX_SR_BSY	(0x80 >> 6)
+/* RxD ready */
+#define SPI_PPC4XX_SR_RBR	(0x80 >> 7)
+
+/* the spi->mode bits understood by this driver */
+#define MODEBITS (SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
+
+/* clock settings (SCP and CI) for various SPI modes */
+#define SPI_CLK_MODE0		SPI_PPC4XX_MODE_SCP
+#define SPI_CLK_MODE1		0
+#define SPI_CLK_MODE2		SPI_PPC4XX_MODE_CI
+#define SPI_CLK_MODE3		(SPI_PPC4XX_MODE_SCP | SPI_PPC4XX_MODE_CI)
+
+#ifdef CONFIG_PPC_OF
+#define DRIVER_NAME		"spi_ppc4xx_of"
+static struct device_node *gpio0np;
+#else
+#define DRIVER_NAME		"spi_ppc4xx"
+#ifndef GPIO0_BASE
+#define GPIO0_BASE		0x1EF600B00ULL
+#define GPIO1_BASE		0x1EF600C00ULL
+#define GPIOx_SIZE		0x44
+#endif
+#endif
+
+#ifndef SDR0_CFGADDR
+#define SDR0_CFGADDR		0x00E
+#define SDR0_CFGDATA		0x00F
+#endif
+#define SDR0_PFC1		0x4101
+
+/*
+ * Offsets - these don't seem to be in any standard header,
+ * but these values may be true only for 440EPx.
+ */
+#define GPIOx_TCR		0x04
+#define GPIOx_OSRL		0x08
+#define GPIOx_OSRH		0x0C
+#define GPIOx_TSRL		0x10
+#define GPIOx_TSRH		0x14
+#define GPIOx_ODR		0x18
+
+/* may be true only for 440EPx */
+/* number of pins per GPIO controller */
+#define GPIO_NUMPINS		32
+/* total number of pins in all GPIO controllers */
+#define GPIO_TOTPINS		64
+
+struct ppc4xx_spi {
+	/* bitbang has to be first */
+	struct spi_bitbang	bitbang;
+	struct completion	done;
+
+	void __iomem		*gpio0;
+	void __iomem		*gpio1;
+	u64			mapbase;
+	u64			mapsize;
+	int			irqnum;
+	/* need this to set the SPI clock */
+	unsigned int		opb_freq;
+
+	/* for transfers */
+	int			len;
+	int			count;
+	/* data buffers */
+	const unsigned char	*tx;
+	unsigned char		*rx;
+	/* pointer to the registers */
+	struct spi_ppc4xx_regs __iomem *regs;
+	struct spi_master	*master;
+	struct device		*dev;
+
+	/* flags to record whether a GPIO pin has been set up as an output */
+	u8			gpio0_flags[GPIO_NUMPINS];
+	u8			gpio1_flags[GPIO_NUMPINS];
+};
+
+/* need this so we can set the clock in the chipselect routine */
+struct spi_ppc4xx_cs {
+	/* speed in hertz */
+	u32	speed_hz;
+	/* bits per word - must be 8! */
+	u8	bpw;
+};
+
+static int spi_ppc4xx_txrx(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct ppc4xx_spi *hw;
+	u8 data;
+
+	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
+		t->tx_buf, t->rx_buf, t->len);
+
+	hw = spi_master_get_devdata(spi->master);
+
+	hw->tx = t->tx_buf;
+	hw->rx = t->rx_buf;
+	hw->len = t->len;
+	hw->count = 0;
+
+	/* send the first byte */
+	data = hw->tx ? hw->tx[0] : 0;
+	out_8(&hw->regs->txd, data);
+	out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
+	wait_for_completion(&hw->done);
+
+	return hw->count;
+}
+
+static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct ppc4xx_spi *hw;
+	struct spi_ppc4xx_cs *cs = spi->controller_state;
+
+	hw = spi_master_get_devdata(spi->master);
+
+	cs->bpw = t ? t->bits_per_word : spi->bits_per_word;
+	cs->speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
+
+	if (cs->bpw != 8) {
+		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", cs->bpw);
+		return -EINVAL;
+	}
+
+	spin_lock(&hw->bitbang.lock);
+	if (!hw->bitbang.busy)
+		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
+	spin_unlock(&hw->bitbang.lock);
+
+	return 0;
+}
+
+static int spi_ppc4xx_setup(struct spi_device *spi)
+{
+	int ret;
+	struct spi_ppc4xx_cs *cs = spi->controller_state;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
+	if (cs == NULL) {
+		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		spi->controller_state = cs;
+	}
+	cs->speed_hz = spi->max_speed_hz;
+	cs->bpw = spi->bits_per_word;
+
+	ret = spi_ppc4xx_setupxfer(spi, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev, "setupxfer returned %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
+		__FUNCTION__, spi->mode, spi->bits_per_word,
+		spi->max_speed_hz);
+
+	return 0;
+}
+
+/*
+ * The next two routines are very 440EPx specific!
+ * They should really be in a platform-specific file or be handled by
+ * generic GPIO handlers. They can go away once gnereic GPIO support is
+ * available for 4xx.
+ * NOTE: chipsel must be zero-based.
+ */
+
+/*
+ * Check whether a GPIO pin (used as chip select) is set up as an output.
+ * If not, set it up and note it in the appropriate flags array.
+ *
+ * NOTE: this assumes that the specified pin is really not needed for one
+ * of the alternate configurations and just blasts it.
+ */
+static void spi_ppc4xx_gpio_check(struct ppc4xx_spi *hw, u8 pin)
+{
+	u8 *flags;
+	void __iomem *gpio = hw->gpio0;
+	/*
+	 * Most of this code lifted from u-boot.
+	 * Thanks go to Stefan Roese.
+	 */
+	u32 mask;
+	u32 mask2;
+	u32 val;
+	u32 offs = 0;
+	u32 offs2 = 0;
+	int pin2 = pin << 1;
+
+	flags = hw->gpio0_flags;
+	if (pin >= GPIO_NUMPINS) {
+		offs = 0x100;
+		pin -= GPIO_NUMPINS;
+		flags = hw->gpio1_flags;
+	}
+	/* already set up for output */
+	if (flags[pin])
+		return;
+
+	if (pin >= GPIO_NUMPINS/2) {
+		/* point at OSRH/TSRH */
+		offs2 = 0x04;
+		pin2 = (pin - GPIO_NUMPINS/2) << 1;
+	}
+
+	mask = 0x80000000 >> pin;
+	mask2 = 0xc0000000 >> (pin2 << 1);
+
+	/* first set TCR to 0 */
+	val = in_be32(gpio + GPIOx_TCR + offs) & ~mask;
+	out_be32(gpio + GPIOx_TCR + offs, val);
+
+	/* always want to set up the pin for output */
+	/* clear GPIOx_OSRL/H */
+	val = in_be32(gpio + GPIOx_OSRL + offs + offs2) & ~mask2;
+	out_be32(gpio + GPIOx_OSRL + offs + offs2, val);
+	/* clear GPIOx_TSRL/H */
+	val = in_be32(gpio + GPIOx_TSRL + offs + offs2) & ~mask2;
+	out_be32(gpio + GPIOx_TSRL + offs + offs2, val);
+	/* clear GPIOx_ODR */
+	val = in_be32(gpio + GPIOx_ODR + offs) & ~mask;
+	out_be32(gpio + GPIOx_ODR + offs, val);
+
+	/* now configure TCR to drive output if selected */
+	val = in_be32(gpio + GPIOx_TCR + offs) | mask;
+	out_be32(gpio + GPIOx_TCR + offs, val);
+
+	flags[pin] = 1;
+}
+
+/*
+ * Set the chip select as a GPIO.
+ */
+static void spi_ppc4xx_gpio(struct ppc4xx_spi *hw, u8 chipsel, u8 pol)
+{
+	void __iomem *gpio = hw->gpio0;
+	u32 val;
+
+	/* check whether the pin is set up for output */
+	spi_ppc4xx_gpio_check(hw, chipsel);
+
+	if (chipsel >= GPIO_NUMPINS) {
+		gpio = hw->gpio1;
+		chipsel -= GPIO_NUMPINS;
+	}
+
+	val = in_be32(gpio);
+	if (pol)
+		val |= (0x80000000 >> chipsel);
+	else
+		val &= ~(0x80000000 >> chipsel);
+	out_be32(gpio, val);
+}
+
+static void spi_ppc4xx_chipsel(struct spi_device *spi, int value)
+{
+	struct ppc4xx_spi *hw;
+	struct spi_ppc4xx_cs *cs = spi->controller_state;
+	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+	unsigned char mode;
+	unsigned char cdm, oldcdm;
+	int scr;
+
+	hw = spi_master_get_devdata(spi->master);
+
+	/* disable the controller here? */
+
+	switch (value) {
+	case BITBANG_CS_INACTIVE:
+		spi_ppc4xx_gpio(hw, spi->chip_select, cspol^1);
+		break;
+
+	case BITBANG_CS_ACTIVE:
+		mode = in_8(&hw->regs->mode);
+
+		/* clear the CLK bits */
+		mode &= ~SPI_CLK_MODE3;
+		switch (spi->mode & (SPI_CPHA|SPI_CPOL)) {
+		case SPI_MODE_0:
+			mode |= SPI_CLK_MODE0;
+			break;
+		case SPI_MODE_1:
+			mode |= SPI_CLK_MODE1;
+			break;
+		case SPI_MODE_2:
+			mode |= SPI_CLK_MODE2;
+			break;
+		case SPI_MODE_3:
+			mode |= SPI_CLK_MODE3;
+			break;
+		}
+
+		if (spi->mode & SPI_LSB_FIRST)
+			mode |= SPI_PPC4XX_MODE_RD;
+		else
+			mode &= ~SPI_PPC4XX_MODE_RD;
+
+		mode |= SPI_PPC4XX_MODE_SPE;
+
+		/* set the clock */
+		cdm = 0;
+		/* opb_freq was already divided by 4 */
+		scr = (hw->opb_freq/cs->speed_hz) - 1;
+
+		if (scr <= 0)
+			goto cdm_done;
+
+		cdm = scr & 0xff;
+
+cdm_done:
+		dev_dbg(&spi->dev, "setting pre-scaler to %d (hz %d)\n", cdm,
+			cs->speed_hz);
+		oldcdm = in_8(&hw->regs->cdm);
+		if (oldcdm != cdm)
+			out_8(&hw->regs->cdm, cdm);
+		/* write new configration */
+		out_8(&hw->regs->mode, mode);
+
+		spi_ppc4xx_gpio(hw, spi->chip_select, cspol);
+
+		break;
+	}
+}
+
+static irqreturn_t spi_ppc4xx_int(int irq, void *dev_id)
+{
+	struct ppc4xx_spi *hw;
+	u8 status;
+	u8 data;
+	unsigned int count;
+
+	hw = dev_id;
+
+	if (irq != hw->irqnum) {
+		printk(KERN_WARNING
+		       "spi_ppc4xx_int : "
+		       "Received wrong int %d. Waiting for %d\n", irq,
+			hw->irqnum);
+		return IRQ_NONE;
+	}
+
+	status = in_8(&hw->regs->sr);
+
+	/* should never happen but check anyway */
+	if (status & SPI_PPC4XX_SR_BSY) {
+		dev_dbg(hw->dev, "got interrupt but spi still busy?\n");
+		complete(&hw->done);
+		return IRQ_HANDLED;
+	}
+
+	count = hw->count;
+	hw->count++;
+
+	if (status & SPI_PPC4XX_SR_RBR) {
+		/* Data Ready */
+		data = in_8(&hw->regs->rxd);
+		if (hw->rx)
+			hw->rx[count] = data;
+	}
+
+	count++;
+
+	if (count < hw->len) {
+		data = hw->tx ? hw->tx[count] : 0;
+		out_8(&hw->regs->txd, data);
+		out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);
+	} else {
+		complete(&hw->done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void spi_ppc4xx_cleanup(struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
+static void spi_ppc4xx_enable(struct ppc4xx_spi *hw)
+{
+	unsigned long pfc1;
+	uint osrh, tsrh;
+
+	mtdcr(SDR0_CFGADDR, SDR0_PFC1);
+	pfc1 = mfdcr(SDR0_CFGDATA);
+	/* need to clear bit 14 to enable SPC */
+	pfc1 &= ~(1 << 17);
+	mtdcr(SDR0_CFGADDR, SDR0_PFC1);
+	mtdcr(SDR0_CFGDATA, pfc1);
+
+	/* enable SPCDO */
+	osrh = in_be32((void *)((u32)hw->gpio0 + GPIOx_OSRH));
+	tsrh = in_be32((void *)((u32)hw->gpio0 + GPIOx_TSRH));
+	/* need to set bits 14:15 in OSRH to 0x01 */
+	osrh &= ~(0x03 << 16);
+	osrh |= (0x01 << 16);
+	out_be32((void *)((u32)hw->gpio0 + GPIOx_OSRH), osrh);
+
+	/* need to set bits 14:15 in TSRH to 0x01 */
+	tsrh &= ~(0x03 << 16);
+	tsrh |= (0x01 << 16);
+	out_be32((void *)((u32)hw->gpio0 + GPIOx_TSRH), tsrh);
+}
+
+#ifdef CONFIG_PPC_OF
+static int __init spi_ppc4xx_of_probe(struct of_device *op,
+	const struct of_device_id *match)
+{
+	struct ppc4xx_spi *hw;
+	struct spi_master *master;
+	struct spi_bitbang *bbp;
+	struct resource resource;
+	struct device_node *np = op->node;
+	struct device *dev = &op->dev;
+	struct device_node *gpionp;
+	const u32 *regaddr;
+	u64 addr64, size64;
+	int ret;
+	const unsigned int *clk;
+
+	master = spi_alloc_master(dev, sizeof(*hw));
+	if (master == NULL)
+		return -ENOMEM;
+	dev_set_drvdata(dev, master);
+	hw = spi_master_get_devdata(master);
+	memset(hw, 0, sizeof(*hw));
+
+	hw->master = spi_master_get(master);
+	hw->dev = dev;
+
+	init_completion(&hw->done);
+
+	/* setup the state for the bitbang driver */
+	bbp = &hw->bitbang;
+	bbp->master = hw->master;
+	bbp->setup_transfer = spi_ppc4xx_setupxfer;
+	bbp->chipselect = spi_ppc4xx_chipsel;
+	bbp->txrx_bufs = spi_ppc4xx_txrx;
+	bbp->use_dma = 0;
+	bbp->master->setup = spi_ppc4xx_setup;
+	bbp->master->cleanup = spi_ppc4xx_cleanup;
+	/* only one SPI controller */
+	bbp->master->bus_num = 0;
+	if (bbp->master->num_chipselect == 0)
+		bbp->master->num_chipselect = GPIO_TOTPINS;
+
+	dev_dbg(dev, "bitbang at %p\n", bbp);
+
+	/* get the clock for the OPB */
+	gpionp = of_find_compatible_node(NULL, NULL, "ibm,opb");
+	if (gpionp == NULL) {
+		dev_warn(dev, "OPB: cannot find node\n");
+		ret = -ENODEV;
+		goto free_master;
+	}
+	/* get the clock (Hz) for the OPB */
+	clk = of_get_property(gpionp, "clock-frequency", NULL);
+	if (clk == NULL) {
+		dev_warn(dev, "OPB: no clock-frequency property set\n");
+		of_node_put(gpionp);
+		ret = -ENODEV;
+		goto free_master;
+	}
+	hw->opb_freq = *clk;
+	hw->opb_freq >>= 2;
+	of_node_put(gpionp);
+
+	ret = of_address_to_resource(np, 0, &resource);
+	if (ret) {
+		printk(KERN_ERR "Error while parsing device node resource\n");
+		goto free_master;
+	}
+	hw->mapbase = resource.start;
+	hw->mapsize = resource.end - resource.start + 1;
+
+	/* sanity check */
+	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
+		dev_warn(dev, "too small to map registers\n");
+		/* XXXX */
+		ret = -EINVAL;
+		goto free_master;
+	}
+
+	hw->irqnum = irq_of_parse_and_map(np, 0);
+	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
+			  IRQF_DISABLED, "spi_ppc4xx_of", (void *)hw);
+	if (ret) {
+		dev_warn(dev, "unable to allocate interrupt\n");
+		goto free_master;
+	}
+
+	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
+		dev_warn(dev, "resource unavailable\n");
+		ret = -EBUSY;
+		goto request_mem_error;
+	}
+
+	hw->regs = ioremap(hw->mapbase, sizeof(struct spi_ppc4xx_regs));
+
+	if (!hw->regs) {
+		dev_warn(dev, "unable to memory map registers\n");
+		ret = -ENXIO;
+		goto map_io_error;
+	}
+
+	/* since there's no GPIO driver we have to do it ourselves */
+	/* find the entry for GPIO0 */
+	gpionp = of_find_compatible_node(NULL, NULL, "ibm,gpio");
+	if (gpionp == NULL) {
+		dev_warn(dev, "unable to find node for GPIO0\n");
+		ret = -ENODEV;
+		goto unmap_regs;
+	}
+	regaddr = of_get_address(gpionp, 0, &size64, NULL);
+	if (regaddr == NULL) {
+		dev_warn(dev, "unable to get address for GPIO0\n");
+		of_node_put(gpionp);
+		ret = -ENODEV;
+		goto unmap_regs;
+	}
+	addr64 = of_translate_address(gpionp, regaddr);
+
+	hw->gpio0 = ioremap(addr64, size64);
+	if (!hw->gpio0) {
+		dev_warn(dev, "unable to memory map gpio0\n");
+		of_node_put(gpionp);
+		ret = -ENOMEM;
+		goto unmap_regs;
+	}
+	gpio0np = gpionp;
+
+	/* find the entry for GPIO1 */
+	/* note that this will of_node_put gpio0np! */
+	gpionp = of_find_compatible_node(gpio0np, NULL, "ibm,gpio");
+	if (gpionp == NULL) {
+		dev_warn(dev, "unable to find node for GPIO1\n");
+		ret = -ENODEV;
+		goto unmap_gpio0;
+	}
+	regaddr = of_get_address(gpionp, 0, &size64, NULL);
+	if (regaddr == NULL) {
+		dev_warn(dev, "unable to get address for GPIO1\n");
+		of_node_put(gpionp);
+		ret = -ENODEV;
+		goto unmap_gpio0;
+	}
+	addr64 = of_translate_address(gpionp, regaddr);
+
+	/* possibly needed for CS */
+	hw->gpio1 = ioremap(addr64, size64);
+	if (!hw->gpio1) {
+		dev_warn(dev, "unable to memory map gpio1\n");
+		of_node_put(gpionp);
+		ret = -ENOMEM;
+		goto unmap_gpio0;
+	}
+	of_node_put(gpionp);
+
+	spi_ppc4xx_enable(hw);
+
+	/* register our spi controller */
+	ret = spi_bitbang_start(bbp);
+	if (ret) {
+		dev_err(dev, "Failed to register SPI master\n");
+		goto unmap_gpio0;
+	}
+
+	printk(KERN_INFO "SPI: SPI_PPC4XX OF SPI driver\n");
+
+	return 0;
+
+unmap_gpio0:
+	iounmap(hw->gpio0);
+unmap_regs:
+	iounmap(hw->regs);
+map_io_error:
+	release_mem_region(hw->mapbase, hw->mapsize);
+request_mem_error:
+	free_irq(hw->irqnum, hw);
+free_master:
+	dev_set_drvdata(dev, NULL);
+	spi_master_put(master);
+
+	dev_err(dev, "initialization failed\n");
+	return ret;
+}
+
+static int __exit spi_ppc4xx_of_remove(struct of_device *op)
+{
+	struct spi_master *master = dev_get_drvdata(&op->dev);
+	struct ppc4xx_spi *hw;
+
+	hw = spi_master_get_devdata(master);
+	spi_bitbang_stop(&hw->bitbang);
+	spi_unregister_master(hw->master);
+	dev_set_drvdata(&op->dev, NULL);
+	release_mem_region(hw->mapbase, hw->mapsize);
+	free_irq(hw->irqnum, hw);
+	iounmap(hw->regs);
+	iounmap(hw->gpio0);
+	iounmap(hw->gpio1);
+
+	return 0;
+}
+
+static struct of_device_id spi_ppc4xx_of_match[] = {
+	{ .type = "spi", .compatible = "ibm,spi", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
+
+static struct of_platform_driver spi_ppc4xx_of_driver = {
+	.owner = THIS_MODULE,
+	.name = DRIVER_NAME,
+	.match_table = spi_ppc4xx_of_match,
+	.probe = spi_ppc4xx_of_probe,
+	.remove = __exit_p(spi_ppc4xx_of_remove),
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init spi_ppc4xx_init(void)
+{
+	return of_register_platform_driver(&spi_ppc4xx_of_driver);
+}
+
+static void __exit spi_ppc4xx_exit(void)
+{
+	of_unregister_platform_driver(&spi_ppc4xx_of_driver);
+}
+
+#else /* not OF-type probe */
+
+static int __devinit spi_ppc4xx_probe(struct platform_device *pdev)
+{
+	struct ppc4xx_spi *hw;
+	struct spi_master *master;
+	struct spi_bitbang *bbp;
+	struct device *dev = &pdev->dev;
+	struct resource *mem_io, *irqres;
+	int ret = -ENODEV;
+
+	master = spi_alloc_master(dev, sizeof(*hw));
+	if (master == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, master);
+	hw = spi_master_get_devdata(master);
+	memset(hw, 0, sizeof(*hw));
+
+	hw->master = spi_master_get(master);
+	hw->dev = dev;
+
+	platform_set_drvdata(pdev, hw);
+	init_completion(&hw->done);
+
+	/* setup the state for the bitbang driver */
+	bbp = &hw->bitbang;
+	bbp->master = hw->master;
+	bbp->setup_transfer = spi_ppc4xx_setupxfer;
+	bbp->chipselect = spi_ppc4xx_chipsel;
+	bbp->txrx_bufs = spi_ppc4xx_txrx;
+	bbp->use_dma = 0;
+	bbp->master->setup = spi_ppc4xx_setup;
+	bbp->master->cleanup = spi_ppc4xx_cleanup;
+	/* only one SPI controller */
+	bbp->master->bus_num = 0;
+	if (bbp->master->num_chipselect == 0)
+		bbp->master->num_chipselect = GPIO_TOTPINS;
+
+	dev_dbg(dev, "bitbang at %p\n", bbp);
+
+	/* get the clock (Hz) for the OPB. Set in sequoia_setup_arch() */
+	hw->opb_freq = ocp_sys_info.opb_bus_freq >> 2;
+
+	/* needed to set SCPD0 */
+	hw->gpio0 = ioremap(GPIO0_BASE, GPIOx_SIZE);
+	if (hw->gpio0 == NULL) {
+		printk(KERN_ERR DRIVER_NAME " unable to ioremap GPIO0\n");
+		ret = -ENOMEM;
+		goto free_master;
+	}
+	/* possibly needed for CS */
+	hw->gpio1 = ioremap(GPIO1_BASE, GPIOx_SIZE);
+	if (hw->gpio1 == NULL) {
+		printk(KERN_ERR DRIVER_NAME " unable to ioremap GPIO1\n");
+		iounmap(hw->gpio0);
+		ret = -ENOMEM;
+		goto free_master;
+	}
+
+	mem_io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irqres = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+
+	if ((!mem_io) | (!irqres))
+		goto out_err;
+	/* save value for release_mem_region use */
+	hw->mapbase = mem_io->start;
+	hw->mapsize = mem_io->end - mem_io->start + 1;
+	/* sanity check */
+	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
+		dev_warn(dev, "too small to map registers\n");
+		/* XXXX */
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	hw->irqnum = irqres->start;
+	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
+			  IRQF_DISABLED, "spi_ppc4xx", (void *)hw);
+	if (ret)
+		goto out_err;
+
+	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
+		printk(KERN_ERR DRIVER_NAME " - resource unavailable\n");
+		ret = -EBUSY;
+		goto request_mem_error;
+	}
+
+	hw->regs = ioremap(hw->mapbase, sizeof(struct spi_ppc4xx_regs));
+
+	if (!hw->regs) {
+		printk(KERN_ERR DRIVER_NAME " - failed to map spi regs\n");
+		ret = -ENXIO;
+		goto map_io_error;
+	}
+
+	spi_ppc4xx_enable(hw);
+
+	/* register our spi controller */
+	ret = spi_bitbang_start(bbp);
+	if (ret) {
+		dev_err(dev, "Failed to register SPI master\n");
+		goto map_io_error;
+	}
+
+	return 0;
+
+map_io_error:
+	release_mem_region(hw->mapbase, hw->mapsize);
+request_mem_error:
+	free_irq(hw->irqnum, hw);
+out_err:
+	iounmap(hw->gpio0);
+	iounmap(hw->gpio1);
+free_master:
+	platform_set_drvdata(pdev, NULL);
+	dev_set_drvdata(dev, NULL);
+	spi_master_put(master);
+
+	printk(KERN_ERR "SPI: SPI_PPC4XX SPI init FAILED !!!\n");
+	return ret;
+}
+
+static int __devexit spi_ppc4xx_remove(struct platform_device *dev)
+{
+	struct ppc4xx_spi *hw;
+
+	hw = platform_get_drvdata(dev);
+	spi_bitbang_stop(&hw->bitbang);
+	spi_unregister_master(hw->master);
+	dev_set_drvdata(&dev->dev, NULL);
+	platform_set_drvdata(dev, NULL);
+	release_mem_region(hw->mapbase, hw->mapsize);
+	free_irq(hw->irqnum, hw);
+	iounmap(hw->regs);
+	iounmap(hw->gpio0);
+	iounmap(hw->gpio1);
+
+	return 0;
+}
+
+static struct platform_driver spi_ppc4xx_platform_driver = {
+	.probe = spi_ppc4xx_probe,
+	.remove = __exit_p(spi_ppc4xx_remove),
+	.driver = {
+		   .name = "spi_ppc4xx",
+		   .owner = THIS_MODULE,
+	},
+};
+
+static int __init spi_ppc4xx_init(void)
+{
+	printk(KERN_INFO "SPI: SPI_PPC4XX SPI driver\n");
+	return platform_driver_register(&spi_ppc4xx_platform_driver);
+}
+
+static void __exit spi_ppc4xx_exit(void)
+{
+	platform_driver_unregister(&spi_ppc4xx_platform_driver);
+}
+#endif /* CONFIG_PPC_OF */
+
+module_init(spi_ppc4xx_init);
+module_exit(spi_ppc4xx_exit);
+
+MODULE_LICENSE("GPL");

-- 
Gary Jennejohn
*********************************************************************
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
*********************************************************************

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
