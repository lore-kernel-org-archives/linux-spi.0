From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 6/9] S3C24XX: Common ADC driver for
	S3C24XX archs
Date: Fri, 10 Oct 2008 11:03:50 +0100
Message-ID: <20081010100406.152428602@fluff.org.uk>
References: <20081010100344.572052114@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=simtec/simtec-s3c24xx-adc-common.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

A common ADC driver to allow the hwmon and touchscreen
drivers to share the ADC block.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/Kconfig
===================================================================
--- linux-2.6.27-rc9-s3c64xx-2.orig/arch/arm/plat-s3c24xx/Kconfig	2008-10-08 15:00:20.000000000 +0100
+++ linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/Kconfig	2008-10-10 10:39:51.000000000 +0100
@@ -49,6 +49,13 @@ config S3C2410_DMA_DEBUG
 	  Enable debugging output for the DMA code. This option sends info
 	  to the kernel log, at priority KERN_DEBUG.
 
+config S3C24XX_ADC
+	bool "ADC common driver support"
+	help
+	  Core support for the ADC block found in the S3C24XX SoC systems
+	  for drivers such as the touchscreen and hwmon to use to share
+	  this resource.
+
 # SPI default pin configuration code
 
 config S3C24XX_SPI_BUS0_GPE11_GPE12_GPE13
Index: linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/Makefile
===================================================================
--- linux-2.6.27-rc9-s3c64xx-2.orig/arch/arm/plat-s3c24xx/Makefile	2008-10-08 15:00:20.000000000 +0100
+++ linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/Makefile	2008-10-10 10:39:51.000000000 +0100
@@ -31,6 +31,7 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_HAVE_PWM)		+= pwm.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma.o
+obj-$(CONFIG_S3C24XX_ADC)	+= adc.o
 
 # SPI gpio central GPIO functions
 
Index: linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/adc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/adc.c	2008-10-10 10:41:11.000000000 +0100
@@ -0,0 +1,372 @@
+/* arch/arm/plat-s3c24xx/adc.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>, <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
+ *
+ * S3C24XX ADC device core
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <plat/regs-adc.h>
+#include <plat/adc.h>
+
+/* This driver is designed to control the usage of the ADC block between
+ * the touchscreen and any other drivers that may need to use it, such as
+ * the hwmon driver.
+ *
+ * Priority will be given to the touchscreen driver, but as this itself is
+ * rate limited it should not starve other requests which are processed in
+ * order that they are received.
+ *
+ * Each user registers to get a client block which uniquely identifies it
+ * and stores information such as the necessary functions to callback when
+ * action is required.
+ */
+
+struct s3c_adc_client {
+	struct platform_device	*pdev;
+	struct list_head	 pend;
+
+	unsigned int		 nr_samples;
+	unsigned char		 is_ts;
+	unsigned char		 channel;
+
+	void	(*select_cb)(unsigned selected);
+	void	(*convert_cb)(unsigned val1, unsigned val2);
+};
+
+struct adc_device {
+	struct platform_device	*pdev;
+	struct platform_device	*owner;
+	struct clk		*clk;
+	struct s3c_adc_client	*cur;
+	struct s3c_adc_client	*ts_pend;
+	void __iomem		*regs;
+
+	unsigned int		 prescale;
+
+	int			 irq;
+};
+
+static struct adc_device *adc_dev;
+
+static LIST_HEAD(adc_pending);
+
+#define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)
+
+static inline void s3c_adc_convert(struct adc_device *adc)
+{
+	unsigned con = readl(adc->regs + S3C2410_ADCCON);
+
+	con |= S3C2410_ADCCON_ENABLE_START;
+	writel(con, adc->regs + S3C2410_ADCCON);
+}
+
+static inline void s3c_adc_select(struct adc_device *adc,
+				  struct s3c_adc_client *client)
+{
+	unsigned con = readl(adc->regs + S3C2410_ADCCON);
+
+	client->select_cb(1);
+
+	con &= ~S3C2410_ADCCON_MUXMASK;
+	con &= ~S3C2410_ADCCON_STDBM;
+	con &= ~S3C2410_ADCCON_STARTMASK;
+
+	if (!client->is_ts)
+		con |= S3C2410_ADCCON_SELMUX(client->channel);
+
+	writel(con, adc->regs + S3C2410_ADCCON);
+}
+
+static void s3c_adc_dbgshow(struct adc_device *adc)
+{
+	adc_dbg(adc, "CON=%08x, TSC=%08x, DLY=%08x\n",
+		readl(adc->regs + S3C2410_ADCCON),
+		readl(adc->regs + S3C2410_ADCTSC),
+		readl(adc->regs + S3C2410_ADCDLY));
+}
+
+void s3c_adc_try(struct adc_device *adc)
+{
+	struct s3c_adc_client *next = adc->ts_pend;
+
+	if (!next && !list_empty(&adc_pending)) {
+		next = list_first_entry(&adc_pending,
+					struct s3c_adc_client, pend);
+		list_del(&next->pend);
+	} else
+		adc->ts_pend = NULL;
+
+	if (next) {
+		adc_dbg(adc, "new client is %p\n", next);
+		adc->cur = next;
+		s3c_adc_select(adc, next);
+		s3c_adc_convert(adc);
+		s3c_adc_dbgshow(adc);
+	}
+}
+
+int s3c_adc_start(struct s3c_adc_client *client,
+		  unsigned int channel, unsigned int nr_samples)
+{
+	struct adc_device *adc = adc_dev;
+	unsigned long flags;
+
+	if (!adc) {
+		printk(KERN_ERR "%s: failed to find adc\n", __func__);
+		return -EINVAL;
+	}
+
+	if (client->is_ts && adc->ts_pend)
+		return -EAGAIN;
+
+	local_irq_save(flags);
+
+	client->channel = channel;
+	client->nr_samples = nr_samples;
+
+	if (client->is_ts)
+		adc->ts_pend = client;
+	else
+		list_add_tail(&client->pend, &adc_pending);
+
+	if (!adc->cur)
+		s3c_adc_try(adc);
+	local_irq_restore(flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s3c_adc_start);
+
+static void s3c_adc_default_select(unsigned select)
+{
+}
+
+struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,
+					void (*select)(unsigned int selected),
+					void (*conv)(unsigned d0, unsigned d1),
+					unsigned int is_ts)
+{
+	struct s3c_adc_client *client;
+
+	WARN_ON(!pdev);
+	WARN_ON(!conv);
+
+	if (!select)
+		select = s3c_adc_default_select;
+
+	if (!conv || !pdev)
+		return ERR_PTR(-EINVAL);
+
+	client = kzalloc(sizeof(struct s3c_adc_client), GFP_KERNEL);
+	if (!client) {
+		dev_err(&pdev->dev, "no memory for adc client\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	client->pdev = pdev;
+	client->is_ts = is_ts;
+	client->select_cb = select;
+	client->convert_cb = conv;
+
+	return client;
+}
+EXPORT_SYMBOL_GPL(s3c_adc_register);
+
+void s3c_adc_release(struct s3c_adc_client *client)
+{
+	/* We should really check that nothing is in progress. */
+	kfree(client);
+}
+EXPORT_SYMBOL_GPL(s3c_adc_release);
+
+static irqreturn_t s3c_adc_irq(int irq, void *pw)
+{
+	struct adc_device *adc = pw;
+	struct s3c_adc_client *client = adc->cur;
+	unsigned long flags;
+	unsigned data0, data1;
+
+	if (!client) {
+		dev_warn(&adc->pdev->dev, "%s: no adc pending\n", __func__);
+		return IRQ_HANDLED;
+	}
+
+	data0 = readl(adc->regs + S3C2410_ADCDAT0);
+	data1 = readl(adc->regs + S3C2410_ADCDAT1);
+	adc_dbg(adc, "read %d: 0x%04x, 0x%04x\n", client->nr_samples, data0, data1);
+
+	(client->convert_cb)(data0 & 0x3ff, data1 & 0x3ff);
+
+	if (--client->nr_samples > 0) {
+		/* fire another conversion for this */
+
+		client->select_cb(1);
+		s3c_adc_convert(adc);
+	} else {
+		local_irq_save(flags);
+		(client->select_cb)(0);
+		adc->cur = NULL;
+
+		s3c_adc_try(adc);
+		local_irq_restore(flags);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int s3c_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct adc_device *adc;
+	struct resource *regs;
+	int ret;
+
+	adc = kzalloc(sizeof(struct adc_device), GFP_KERNEL);
+	if (adc == NULL) {
+		dev_err(dev, "failed to allocate adc_device\n");
+		return -ENOMEM;
+	}
+
+	adc->pdev = pdev;
+	adc->prescale = S3C2410_ADCCON_PRSCVL(49);
+
+	adc->irq = platform_get_irq(pdev, 1);
+	if (adc->irq <= 0) {
+		dev_err(dev, "failed to get adc irq\n");
+		ret = -ENOENT;
+		goto err_alloc;
+	}
+
+	ret = request_irq(adc->irq, s3c_adc_irq, 0, dev_name(dev), adc);
+	if (ret < 0) {
+		dev_err(dev, "failed to attach adc irq\n");
+		goto err_alloc;
+	}
+
+	adc->clk = clk_get(dev, "adc");
+	if (IS_ERR(adc->clk)) {
+		dev_err(dev, "failed to get adc clock\n");
+		ret = PTR_ERR(adc->clk);
+		goto err_irq;
+	}
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(dev, "failed to find registers\n");
+		ret = -ENXIO;
+		goto err_clk;
+	}
+
+	adc->regs = ioremap(regs->start, resource_size(regs));
+	if (!adc->regs) {
+		dev_err(dev, "failed to map registers\n");
+		ret = -ENXIO;
+		goto err_clk;
+	}
+
+	clk_enable(adc->clk);
+
+	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
+	       adc->regs + S3C2410_ADCCON);
+
+	dev_info(dev, "attached adc driver\n");
+
+	platform_set_drvdata(pdev, adc);
+	adc_dev = adc;
+
+	return 0;
+
+ err_clk:
+	clk_put(adc->clk);
+
+ err_irq:
+	free_irq(adc->irq, adc);
+
+ err_alloc:
+	kfree(adc);
+	return ret;
+}
+
+static int s3c_adc_remove(struct platform_device *pdev)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+
+	iounmap(adc->regs);
+	free_irq(adc->irq, adc);
+	clk_disable(adc->clk);
+	clk_put(adc->clk);
+	kfree(adc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int s3c_adc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+	u32 con;
+
+	con = readl(adc->regs + S3C2410_ADCCON);
+	con |= S3C2410_ADCCON_STDBM;
+	writel(con, adc->regs + S3C2410_ADCCON);
+
+	clk_disable(adc->clk);
+
+	return 0;
+}
+
+static int s3c_adc_resume(struct platform_device *pdev)
+{
+	struct adc_device *adc = platform_get_drvdata(pdev);
+
+	clk_enable(adc->clk);
+
+	writel(adc->prescale | S3C2410_ADCCON_PRSCEN,
+	       adc->regs + S3C2410_ADCCON);
+
+	return 0;
+}
+
+#else
+#define s3c_adc_suspend NULL
+#define s3c_adc_resume NULL
+#endif
+
+static struct platform_driver s3c_adc_driver = {
+	.driver		= {
+		.name	= "s3c24xx-adc",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= s3c_adc_probe,
+	.remove		= __devexit_p(s3c_adc_remove),
+	.suspend	= s3c_adc_suspend,
+	.resume		= s3c_adc_resume,
+};
+
+static int __init adc_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&s3c_adc_driver);
+	if (ret)
+		printk(KERN_ERR "%s: failed to add adc driver\n", __func__);
+
+	return ret;
+}
+
+arch_initcall(adc_init);
Index: linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c/include/plat/adc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c/include/plat/adc.h	2008-10-08 15:00:20.000000000 +0100
@@ -0,0 +1,29 @@
+/* arch/arm/plat-s3c/include/plat/adc.h
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simnte.co.uk/
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *
+ * S3C24XX ADC driver information
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_ADC_H
+#define __ASM_PLAT_ADC_H __FILE__
+
+struct s3c_adc_client;
+
+extern int s3c_adc_start(struct s3c_adc_client *client,
+			 unsigned int channel, unsigned int nr_samples);
+
+extern struct s3c_adc_client *s3c_adc_register(struct platform_device *pdev,
+					       void (*select)(unsigned selected),
+					       void (*conv)(unsigned d0, unsigned d1),
+					       unsigned int is_ts);
+
+extern void s3c_adc_release(struct s3c_adc_client *client);
+
+#endif /* __ASM_PLAT_ADC_H */
Index: linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/devs.c
===================================================================
--- linux-2.6.27-rc9-s3c64xx-2.orig/arch/arm/plat-s3c24xx/devs.c	2008-10-08 15:00:20.000000000 +0100
+++ linux-2.6.27-rc9-s3c64xx-2/arch/arm/plat-s3c24xx/devs.c	2008-10-10 10:39:53.000000000 +0100
@@ -372,12 +372,20 @@ static struct resource s3c_adc_resource[
 };
 
 struct platform_device s3c_device_adc = {
-	.name		  = "s3c2410-adc",
+	.name		  = "s3c24xx-adc",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c_adc_resource),
 	.resource	  = s3c_adc_resource,
 };
 
+/* HWMON */
+
+struct platform_device s3c_device_hwmon = {
+	.name		= "s3c24xx-hwmon",
+	.id		= -1,
+	.dev.parent	= &s3c_device_adc.dev,
+};
+
 /* SDI */
 
 static struct resource s3c_sdi_resource[] = {

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
