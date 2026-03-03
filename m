Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE52382377
	for <linux-spi@vger.kernel.org>; Tue,  3 Mar 2026 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518437; cv=none; b=PBx1Vl1C9QY4J9kwjCKmFMomC4htRhpOa2ogRqM8luK5JbFvAmQht79sEUNo+RLc6bOlXdArbOX8PYxfbD9LJ1qZsqVfeukbPOY6/Wwopq47oV3jaaCuHNxSMsRnJA/ECc1IfjThYbNmebWQRlLDr0rasrj2lVy9KRf2OXY1dl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518437; c=relaxed/simple;
	bh=0OWVvkpb8UuVF2dcKxIXv4nkgilqjcELXDqX61I3pA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cl/IX66xAVQi8P3n1alc8TSMhQwYYQJRa2W/88p0ptSVXAKraBEiFlGgfZYQt0Z5OBOl1hIOFRVntPW/63uKZ2bKZsZK6b2/ZmVgRVTCB7MBEZWClIgmQPXSc1IHhd1dYOkKiZoCSw4RMMZI1PdbUB6vfE7PbGyMBfagV0j6TxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fJ8/Z8bx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJ8/Z8bx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae4e538abdso18092765ad.3
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 22:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772518433; x=1773123233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrh1Fd8nSQVaqqRA38zJbtmK+DIMwuwcBDvEg12fGDM=;
        b=fJ8/Z8bxteLz7rT+nhqFNSDZRHnUA3zljqh6wFYM44pFWZ9bdu4PR5AlwDukloOSyE
         QIpIESPK6a89y7YtVcj2M+mLTBTRDScVfBBBVJnIDThy2Tc/YcQPxpV40XTMsVh7lmEI
         pn42nBWpZsP3EG2thQFSyqzmaXyKauIUU4pk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772518433; x=1773123233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jrh1Fd8nSQVaqqRA38zJbtmK+DIMwuwcBDvEg12fGDM=;
        b=SDhkUn7bOAyXD90upfSPJLhbI67MShNbA6qi6L/VkjTT2DNpoHJ+B1ziKqjFH5wgHu
         wN52SbWx4qi5PkT6+s95T/WCDfpoQGBq/RoRubR+H10PX3NPO9HdPcwmD3g5q77sxRNx
         kveNbN1dIUBmLspextxKaYBPXxyylX79HC1mxa0fgKwM1z6ipWuZo+8z1L6v/b6ro5lN
         AavynJF5zF0QS4aFQqKlzLWoNBhuKYpdgXMoOs8QmxtgjV+r7iNs29ogo9kc1H8ckLAc
         PMzXH/YIjQopIE6gmIVzsXL7saudZC2jAtKaMzRDAkebL4dHLVHh3aCdDSERifPWx12f
         19rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+xDqiqU1aET8rEvAVWs8XjR86weoPsbSpIMEsTzy9XmNOEyTKc5jH9qUAJIk7IEyGcIzvJD/7mJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYRxG58QQzHbKjsteKbd0jxQEDhMLwUYIrFHO+8A99mNaNy2xz
	Ack0limy1tVYLxrKC9eSA4B5Aq50F/+1VujLQ7BDo9aPPLMjYtVpxIG5kHjd6TE2Ig==
X-Gm-Gg: ATEYQzwVFB4a1P0DivHSiB+TzmqiHUOl9CD7YuH9w1DeIgd62465G5qifBBRQOvoCbq
	njGa3lQmS8ChYOJx3OE8Zleet3z5XANCbtsUKQdqR3ckCjFpW7YrR8ziWp7SEVReU4WD0EwEkgB
	BpCH3sZdNfw019YUzWkjBngPLJfuqqRtGOwu20Cvdn4Xv/EPq07y1HTDhWlccOi0C3Up9Ifentx
	KRrJqLRihIoP5wL/LPnWn/by5PgurOKNV87fg0q7+xxD2V4hkyPJ7Nu4CMCrRZ9C6gd0s6xk/q9
	BwPI53bDKgUruMxNQwbf97ITAuQmwtzyHcO9MSfRFDwfALOsH9u6fHD3mNS0SnLwXX22GnXFNqK
	2YCI6mHNKzKGYqy+KQdd/9FO/uq6hZcEUlPSdeClyWO9VjiFu/ChsFcCdCD491t81aWjCceKZvC
	MjPTFFbmDVhrbYxNgxLaSlZjYfr5b4KxrWcGbpDanOZkJujlIfusHWxJvx3HY52VZDEqeRMWMHK
	NMJ2ezMKrnhx+bFqCcZcEgux4+44Vx1Zg==
X-Received: by 2002:a17:902:f68b:b0:2ae:5851:9960 with SMTP id d9443c01a7336-2ae58519b53mr41949005ad.21.1772518432883;
        Mon, 02 Mar 2026 22:13:52 -0800 (PST)
Received: from jingyliang-input-linux.c.googlers.com (111.169.168.34.bc.googleusercontent.com. [34.168.169.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm152639735ad.91.2026.03.02.22.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 22:13:52 -0800 (PST)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 03 Mar 2026 06:13:00 +0000
Subject: [PATCH 08/12] HID: spi_hid: add device tree support for SPI over
 HID
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-send-upstream-v1-8-1515ba218f3d@chromium.org>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
In-Reply-To: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 hbarnor@chromium.org, Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772518424; l=8754;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=DhX2Uh1rHNONR9PWKjCuHamOIXQpxg2tk//xxr/GNPg=;
 b=dDRFUCZnpLF1KnXWXYiRsSlUS8MJO3AWwE32XYsswZX0/B6AABOdoeQqF2SlQ+BRC4FVSDbK0
 QNBC2h7LX40BSzuPL2J/nM+D3eAr/CRBC5O6OGBgYZrNS/o2yrtw80H
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig      |  15 +++
 drivers/hid/spi-hid/Makefile     |   1 +
 drivers/hid/spi-hid/spi-hid-of.c | 243 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 114b1e00da39..76a2cd587a3e 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -25,6 +25,21 @@ config SPI_HID_ACPI
 	  will be called spi-hid-acpi. It will also build/depend on the
 	  module spi-hid.
 
+config SPI_HID_OF
+	tristate "HID over SPI transport layer Open Firmware driver"
+	depends on OF
+	select SPI_HID_CORE
+	help
+	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
+	  other HID based devices which are connected to your computer via SPI.
+	  This driver supports Open Firmware (Device Tree)-based systems.
+
+	  If unsure, say N.
+
+	  This support is also available as a module.  If so, the module
+	  will be called spi-hid-of. It will also build/depend on the
+	  module spi-hid.
+
 config SPI_HID_CORE
 	tristate
 endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
index 753c7b7a7844..fe627fd378e3 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
 obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
+obj-$(CONFIG_SPI_HID_OF)	+= spi-hid-of.o
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
new file mode 100644
index 000000000000..a20c8146230b
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol, Open Firmware related code
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ *
+ * This code was forked out of the HID over SPI core code, which is partially
+ * based on "HID over I2C protocol implementation:
+ *
+ * Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ * Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ * Copyright (c) 2012 Red Hat, Inc
+ *
+ * which in turn is partially based on "USB HID support for Linux":
+ *
+ * Copyright (c) 1999 Andreas Gal
+ * Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ * Copyright (c) 2007-2008 Oliver Neukum
+ * Copyright (c) 2006-2010 Jiri Kosina
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+
+#include "spi-hid.h"
+
+/* Config structure is filled with data from Device Tree */
+struct spi_hid_of_config {
+	struct spihid_ops ops;
+
+	struct spi_hid_conf property_conf;
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+	struct gpio_desc *reset_gpio;
+	struct regulator *supply;
+	bool supply_enabled;
+};
+
+static int spi_hid_of_populate_config(struct spi_hid_of_config *conf,
+				      struct device *dev)
+{
+	int error;
+	u32 val;
+
+	error = device_property_read_u32(dev, "input-report-header-address",
+					 &val);
+	if (error) {
+		dev_err(dev, "Input report header address not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_header_address = val;
+
+	error = device_property_read_u32(dev, "input-report-body-address", &val);
+	if (error) {
+		dev_err(dev, "Input report body address not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_body_address = val;
+
+	error = device_property_read_u32(dev, "output-report-address", &val);
+	if (error) {
+		dev_err(dev, "Output report address not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.output_report_address = val;
+
+	error = device_property_read_u32(dev, "read-opcode", &val);
+	if (error) {
+		dev_err(dev, "Read opcode not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.read_opcode = val;
+
+	error = device_property_read_u32(dev, "write-opcode", &val);
+	if (error) {
+		dev_err(dev, "Write opcode not provided.");
+		return -ENODEV;
+	}
+	conf->property_conf.write_opcode = val;
+
+	error = device_property_read_u32(dev, "post-power-on-delay-ms", &val);
+	if (error) {
+		dev_err(dev, "post-power-on-delay-ms not provided, using 10.");
+		val = 10;
+	}
+	conf->post_power_on_delay_ms = val;
+
+	error = device_property_read_u32(dev, "minimal-reset-delay-ms", &val);
+	if (error) {
+		dev_err(dev, "minimal-reset-delay-ms not provided, using 100.");
+		val = 100;
+	}
+	conf->minimal_reset_delay_ms = val;
+
+	/* FIXME: not reading hid-over-spi-flags, multi-fragment not supported */
+
+	conf->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(conf->supply)) {
+		if (PTR_ERR(conf->supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get regulator: %ld.",
+				PTR_ERR(conf->supply));
+		return PTR_ERR(conf->supply);
+	}
+	conf->supply_enabled = false;
+
+	conf->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(conf->reset_gpio)) {
+		dev_err(dev, "%s: error getting reset GPIO.", __func__);
+		return PTR_ERR(conf->reset_gpio);
+	}
+
+	return 0;
+}
+
+static int spi_hid_of_power_down(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	int error;
+
+	if (!conf->supply_enabled)
+		return 0;
+
+	error = regulator_disable(conf->supply);
+	if (error == 0)
+		conf->supply_enabled = false;
+
+	return error;
+}
+
+static int spi_hid_of_power_up(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	int error;
+
+	if (conf->supply_enabled)
+		return 0;
+
+	error = regulator_enable(conf->supply);
+
+	if (error == 0) {
+		conf->supply_enabled = true;
+		usleep_range(1000 * conf->post_power_on_delay_ms,
+			     1000 * (conf->post_power_on_delay_ms + 1));
+	}
+
+	return error;
+}
+
+static int spi_hid_of_assert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	gpiod_set_value(conf->reset_gpio, 1);
+	return 0;
+}
+
+static int spi_hid_of_deassert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	gpiod_set_value(conf->reset_gpio, 0);
+	return 0;
+}
+
+static void spi_hid_of_sleep_minimal_reset_delay(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	usleep_range(1000 * conf->minimal_reset_delay_ms,
+		     1000 * (conf->minimal_reset_delay_ms + 1));
+}
+
+static int spi_hid_of_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct spi_hid_of_config *config;
+	int error;
+
+	config = devm_kzalloc(dev, sizeof(struct spi_hid_of_config),
+			      GFP_KERNEL);
+	if (!config)
+		return -ENOMEM;
+
+	config->ops.power_up = spi_hid_of_power_up;
+	config->ops.power_down = spi_hid_of_power_down;
+	config->ops.assert_reset = spi_hid_of_assert_reset;
+	config->ops.deassert_reset = spi_hid_of_deassert_reset;
+	config->ops.sleep_minimal_reset_delay =
+		spi_hid_of_sleep_minimal_reset_delay;
+
+	error = spi_hid_of_populate_config(config, dev);
+	if (error) {
+		dev_err(dev, "%s: unable to populate config data.", __func__);
+		return error;
+	}
+
+	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+}
+
+const struct of_device_id spi_hid_of_match[] = {
+	{ .compatible = "hid-over-spi" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_hid_of_match);
+
+static const struct spi_device_id spi_hid_of_id_table[] = {
+	{ "hid", 0 },
+	{ "hid-over-spi", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
+
+static struct spi_driver spi_hid_of_driver = {
+	.driver = {
+		.name	= "spi_hid_of",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spi_hid_of_match),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = spi_hid_groups,
+	},
+	.probe		= spi_hid_of_probe,
+	.remove		= spi_hid_core_remove,
+	.id_table	= spi_hid_of_id_table,
+};
+
+module_spi_driver(spi_hid_of_driver);
+
+MODULE_DESCRIPTION("HID over SPI OF transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.53.0.473.g4a7958ca14-goog

