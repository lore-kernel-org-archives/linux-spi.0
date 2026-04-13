Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3B3AE1B1
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074749; cv=none; b=lcTUlHs20WRLhaw+Wa5OiB3H7LgHl541qwI4tf6p7fdKknGGbspx1qplRqNsvjemAA/Pou4UA747CTC5SnplBdfKkc5KuFSZrtVt5rGjZC4nJ6ZEGjKKtG97EUKzBTEYwxUI3wOzoevQ//DRFEhnfdRrIqk7dg9v//84iFr8ukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074749; c=relaxed/simple;
	bh=Tclstug7hRiXGCPxAlH+OYkGPX8vCtXfLKlt8b4ukG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGkN1bao5oz0htjmaASNYMgygT72xGq2xZr/8+0awH3bTm8pCsqk9MRIqT4OBSS7ymJKQO0yeP0+S95qgCevTYEzeDLJ61L5QMh1h6nRcpBhqlM3DLL35KEg3FH+8CDEvKKuHiV05kGD/jX54w7uud1/o6A3DZnAmMythjCLX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afu5oM/U; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afu5oM/U"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so5956956a12.1
        for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 03:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776074746; x=1776679546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUQbeJrmnLAC83DjJTyOiwZ5gn/HwjrSl7M0Tq5ML7I=;
        b=afu5oM/Uk6W0mWRrie/QHyROkw6Wq53tz7A47TCy4WVswvRDNHYTVdVkYqugzoRN9Y
         SnPPPF4KO4vrtIs9ayTdjhZlalmXE0ETbXsTXAT2B6RnvNgHe28BPRLgWK1mz2Pi8vlV
         eBhGhoKAnSYvymatfmG0p0unVdL3Cv9g8MI6Umu7hp+bQQE+bxmVuPsBQXq725zjiKnR
         ScURo6rrXZtCEBPe1eXDgTnh01vqhYnYI8a9Dp1dlX+CFfZnpMYpC1nj0Txojq2zLEac
         mvDh7fXmyB5QS1GWCHS9IwomW2Efodjxk5hjTGnULlpqfni3TFFB4rQLFfXzEMZWa9ez
         eigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776074746; x=1776679546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WUQbeJrmnLAC83DjJTyOiwZ5gn/HwjrSl7M0Tq5ML7I=;
        b=JHvUhVxlv/RIIIV9APXsUPc7BpO7OqPjao+QHr5adOFWC8UX+V17/Htgd4KUmOqUp2
         rPPo8jVYOl/89BvauHnZzLJ5FMB7QgmUXV7jFWx3gP0i/hC2rhLbEqTnXg9eiJ/Tloxs
         /6/coTT5Kx94fnBiGobPKxUMyflkc4eptkyyCY7ex91CS5OBuU2y+xNKFgmjligMDfFX
         LBxuUF2s20LBZqHrwA+v0Yuwtyuti1tK4zMf1UjPCLV9MuUv79pGzWT/DJ34Px88UfPA
         sE+5anaoR/p7PU1kU+1XQBGaLKKkb2DmB+pecz+cYh48tbYlTC+0/6ayxh7XGxehruLT
         WJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWhjI2EhmFz1xw91HftTMmOcJHYDiNj6nAIOzliblO0NYY7wCImTjMFJvjKuoO/QViYcQ7QbJfphE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZZ6Mx5sKlJwOV56reiIPJJSlHxa5NwrgzudDEq2D31frr6up
	JjChWDeyEvEKSacx0gCk+2sq0Leq5pgOZpoxP7q27JvUzmT0eK1CYY+CEcfa7uX0
X-Gm-Gg: AeBDievRgpwLnDf41/nai3iOMJCJdTKNqZpchOGN0KlWeZ45xTPa9HLCJsb3mViDEzy
	5FLjZtzahH/Xja+mFPns9eucJP6Z8v6R0QODDEBhoK2unZIU/kndk6gxKQh62tWaEqcQ6CvtjTN
	VRkECndn8uzK8eq0JunboPVf6kMsNVi/+C+Ylv/r9qvevEycW7Dn9Kok6krldb9LBZjKA/tkvE4
	eZidc/8qa5Tc6OQDOE/9sO2l7zpeI3PP8LcvbsO0P9dfZNu+byACcr1Z1LTUQfDBfNl7Oy2UiZ+
	VYBSgppRAPIQkNg2AOtGuXHlISzo62mVsTi0WYwHeyAg+W0OPFhoHNR5arPMS7LIAw9khxsav+J
	D6E3UvPJrzkNijUNTQUcaANqusJco9K/IDqSOJBz1PvxClNv5M30E6QgHlqqLjVXOyycQi3tviM
	D7KcWvBobAaxbrZAb1XWKLXU7THrgiMaWR
X-Received: by 2002:a17:907:26ce:b0:b9c:2c55:338c with SMTP id a640c23a62f3a-b9d72661585mr638588866b.25.1776074745429;
        Mon, 13 Apr 2026 03:05:45 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5824sm297805066b.38.2026.04.13.03.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:05:44 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>,
	Khalil <khalilst@gmail.com>
Subject: [PATCH v2 2/3] platform/x86: serial-multi-instantiate: Fix SPI chip select on platforms with incomplete ACPI cs-gpios
Date: Mon, 13 Apr 2026 12:05:29 +0200
Message-ID: <20260413100530.580649-3-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413100530.580649-1-khalil@rentman.nl>
References: <20260413100530.580649-1-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some HP laptops with Intel Lunar Lake and dual Cirrus Logic CS35L56
amplifiers over SPI have an incomplete cs-gpios property in the SPI
controller's _DSD - it only declares the first chip select. The
remaining chip select GPIOs are defined as GpioIo resources in the
peripheral's ACPI node but are not referenced by the controller.

This causes the SPI framework to reject devices whose chip select
exceeds num_chipselect with -EINVAL, preventing the second amplifier
from probing.

Fix this on known affected platforms by:

1. Adding a DMI quirk table to identify affected systems
2. For devices with chip selects outside the controller's range,
   acquiring the GPIO from the peripheral's ACPI GpioIo resource
3. Extending num_chipselect and reallocating the controller's
   cs_gpiods array to install the GPIO descriptor
4. Setting SPI_CONTROLLER_GPIO_SS so the framework calls both
   the GPIO toggle and controller->set_cs (needed for clock
   gating on Intel LPSS controllers)

Only chip selects beyond the controller's num_chipselect are fixed up.
Chip selects within range with a NULL cs_gpiods entry are left alone,
as NULL means "native chip select" which is intentional.

Tested on HP EliteBook 8 G1i 16 inch (board 8D8A) with 2x CS35L56
Rev B0 amplifiers. Both amplifiers probe and produce audio.

Signed-off-by: Khalil <khalilst@gmail.com>
---
 .../platform/x86/serial-multi-instantiate.c   | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 1a369334f..0d30bd0a7 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -8,6 +8,10 @@
 
 #include <linux/acpi.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -46,6 +50,53 @@ struct smi {
 	int spi_num;
 	struct i2c_client **i2c_devs;
 	struct spi_device **spi_devs;
+	struct gpio_desc *cs_gpio;
+};
+
+/*
+ * Quirk data for platforms with broken ACPI SPI chip select descriptions.
+ * cs_gpio_idx: index of the GpioIo resource in the ACPI _CRS that provides
+ *              the chip select GPIO for devices missing a proper cs-gpios
+ *              entry on the SPI controller.
+ */
+struct smi_cs_gpio_quirk {
+	int cs_gpio_idx;
+};
+
+static const struct smi_cs_gpio_quirk hp_elitebook_8g1i_quirk = {
+	.cs_gpio_idx = 0,
+};
+
+/*
+ * DMI table of platforms with broken SPI chip select ACPI descriptions.
+ *
+ * These systems have multiple SPI peripherals (e.g., dual CS35L56
+ * amplifiers) but the SPI controller's _DSD cs-gpios property is
+ * incomplete - it only declares the first chip select. The remaining
+ * chip select GPIOs are defined as GpioIo resources in the peripheral's
+ * ACPI node but are not referenced by the controller.
+ */
+static const struct dmi_system_id smi_cs_gpio_dmi_table[] = {
+	{
+		.ident = "HP EliteBook 8 G1i 16 inch",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8D8A"),
+		},
+		.driver_data = (void *)&hp_elitebook_8g1i_quirk,
+	},
+	{ }
+};
+
+/*
+ * ACPI GPIO mapping for the chip select GpioIo resource.
+ * Maps "cs-gpios" to the GpioIo resource at index 0 of the ACPI _CRS.
+ */
+static const struct acpi_gpio_params smi_cs_gpio_params = { 0, 0, false };
+
+static const struct acpi_gpio_mapping smi_cs_gpio_mapping[] = {
+	{ "cs-gpios", &smi_cs_gpio_params, 1 },
+	{ }
 };
 
 static int smi_get_irq(struct platform_device *pdev, struct acpi_device *adev,
@@ -99,6 +150,101 @@ static void smi_devs_unregister(struct smi *smi)
 	}
 }
 
+/*
+ * smi_spi_setup_cs_gpio - Fix up chip select for a device on a platform
+ * with broken ACPI cs-gpios description.
+ *
+ * On affected platforms, the SPI controller's cs-gpios property is incomplete,
+ * so the framework has no GPIO descriptor for some chip selects. This causes
+ * __spi_add_device() to reject the device with -EINVAL (cs >= num_chipselect).
+ *
+ * This function:
+ * 1. Extends num_chipselect if the device's CS is out of range
+ * 2. Reallocates cs_gpiods to match, preventing out-of-bounds access
+ *    in __spi_add_device()
+ * 3. Installs the GPIO from the peripheral's ACPI node into the
+ *    controller's cs_gpiods array so __spi_add_device() propagates
+ *    it to the device
+ * 4. Sets SPI_CONTROLLER_GPIO_SS so the framework calls both the GPIO
+ *    toggle and controller->set_cs (needed for clock gating on Intel
+ *    LPSS controllers)
+ */
+static int smi_spi_setup_cs_gpio(struct device *dev,
+				 struct spi_device *spi_dev,
+				 struct smi *smi,
+				 const struct smi_cs_gpio_quirk *quirk)
+{
+	struct spi_controller *ctlr = spi_dev->controller;
+	struct gpio_desc **new_gpiods;
+	u16 cs = spi_get_chipselect(spi_dev, 0);
+
+	/*
+	 * Only fix up chip selects that the controller doesn't know about.
+	 * A NULL cs_gpiods[cs] within the controller's num_chipselect range
+	 * means "native chip select" - that's intentional, not broken.
+	 * The broken case is when cs >= num_chipselect, meaning the ACPI
+	 * cs-gpios property on the controller was incomplete.
+	 */
+	if (cs < ctlr->num_chipselect)
+		return 0;
+
+	/* Extend num_chipselect to cover this device */
+	dev_info(dev, "Extending num_chipselect from %u to %u for CS%u\n",
+		 ctlr->num_chipselect, cs + 1, cs);
+	ctlr->num_chipselect = cs + 1;
+
+	/* Acquire the CS GPIO from the ACPI GpioIo resource if not yet done */
+	if (!smi->cs_gpio) {
+		int ret;
+
+		ret = devm_acpi_dev_add_driver_gpios(dev, smi_cs_gpio_mapping);
+		if (ret) {
+			dev_warn(dev, "Failed to add CS GPIO mapping: %d\n", ret);
+			return ret;
+		}
+
+		smi->cs_gpio = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
+		if (IS_ERR(smi->cs_gpio)) {
+			dev_warn(dev, "Failed to get CS GPIO: %ld\n",
+				 PTR_ERR(smi->cs_gpio));
+			smi->cs_gpio = NULL;
+			return -ENOENT;
+		}
+		dev_info(dev, "Acquired CS GPIO for CS%u from ACPI GpioIo[%d]\n",
+			 cs, quirk->cs_gpio_idx);
+	}
+
+	/*
+	 * Reallocate the controller's cs_gpiods array to accommodate the
+	 * new num_chipselect, and install the GPIO descriptor. This is
+	 * necessary because __spi_add_device() unconditionally reads
+	 * ctlr->cs_gpiods[cs] to set the device's cs_gpiod.
+	 */
+	new_gpiods = devm_kcalloc(&ctlr->dev, ctlr->num_chipselect,
+				  sizeof(*new_gpiods), GFP_KERNEL);
+	if (!new_gpiods)
+		return -ENOMEM;
+
+	if (ctlr->cs_gpiods) {
+		unsigned int i;
+
+		for (i = 0; i < cs; i++)
+			new_gpiods[i] = ctlr->cs_gpiods[i];
+	}
+	new_gpiods[cs] = smi->cs_gpio;
+	ctlr->cs_gpiods = new_gpiods;
+
+	/*
+	 * SPI_CONTROLLER_GPIO_SS ensures the framework calls both the
+	 * GPIO CS toggle and controller->set_cs(). This is required on
+	 * Intel LPSS controllers where set_cs handles clock gating.
+	 */
+	ctlr->flags |= SPI_CONTROLLER_GPIO_SS;
+
+	dev_info(dev, "Installed GPIO CS on controller for CS%u\n", cs);
+	return 0;
+}
+
 /**
  * smi_spi_probe - Instantiate multiple SPI devices from inst array
  * @pdev:	Platform device
@@ -112,10 +258,19 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 {
 	struct device *dev = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(dev);
+	const struct dmi_system_id *dmi_id;
+	const struct smi_cs_gpio_quirk *quirk = NULL;
 	struct spi_controller *ctlr;
 	struct spi_device *spi_dev;
 	char name[50];
 	int i, ret, count;
+	u16 cs;
+
+	dmi_id = dmi_first_match(smi_cs_gpio_dmi_table);
+	if (dmi_id) {
+		quirk = dmi_id->driver_data;
+		dev_info(dev, "Applying CS GPIO quirk for %s\n", dmi_id->ident);
+	}
 
 	ret = acpi_spi_count_resources(adev);
 	if (ret < 0)
@@ -139,6 +294,19 @@ static int smi_spi_probe(struct platform_device *pdev, struct smi *smi,
 		}
 
 		ctlr = spi_dev->controller;
+		cs = spi_get_chipselect(spi_dev, 0);
+
+		/*
+		 * On quirked platforms, fix up the chip select GPIO for
+		 * devices that would otherwise fail due to incomplete
+		 * ACPI cs-gpios on the SPI controller.
+		 */
+		if (quirk) {
+			ret = smi_spi_setup_cs_gpio(dev, spi_dev, smi, quirk);
+			if (ret)
+				dev_dbg(dev, "CS GPIO setup returned %d for CS%u\n",
+					ret, cs);
+		}
 
 		strscpy(spi_dev->modalias, inst_array[i].type);
 
-- 
2.43.0

