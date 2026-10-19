Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436503;
	b=tgKsj7fZi2GE1aP4tQEKdF1QVFhIgehcupvQvcxXqQcg4XcYw52x919pXGjbGP3Y6RAz
	 LMPLk5pqcH0K0YeYC1yToIhENnsSiSM4yGGEoEHP597hja2OHT060bI3/qzbUoP3MSn8R
	 S1M7yIljTFlgy90DsZWkpTztjUE8GvmJG/WginnaYrMhoTUBKCwrftqyBDxTWDrfdHoJb
	 mfLLsiwjm3oTrZWCKDjI8gKQJvXw30xl2W8em1Y2BGLA0FgPuhXRIQPhOI++orKdl4X4S
	 I0xR2yfQtM+ZHZLPO3Ifoa5wmkLMA0w4dvaZsMQCvlCex8rMfhrPCho5YVQyvSyrZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zPfvRWM7bSNeBi2gQjCK2xqmlEgV+DzhRh7S+wwhFIw=;
	b=Wk8KgDVftggDCtP/2q0edWId+Ph6S4lCarCtPctr2LVFgQmUgmrOhpqFWJcjH4ocPr7E
	 jZk/nyGB2FvtVa523AefAh3NIG2k0s8MwQ3DPJcO7dbZY2B5ydEYYkVBKZLZ4tVDpl5kv
	 u2locIc4hctPGPS5KhqAEvJZQTzAxIU3XBQ624vitgCQJ+tapm+P6RxkuuMpWEvUMV4Wx
	 JOQPZ4FNN2lzpew8BTFJo/BcqueAqjLUgkJQ+uwRBR8H8zXmEB8PJj5cIS9CshrwpX1W9
	 wLugCB7pTq7FYFhgoymuaJWtE2IdSKytrFjlf7DPuJ0Z44eIrDcmGWBM4nl8K8IL0tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OOzWEP9A;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081D60A3837
	for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 19:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0081D60A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OOzWEP9A
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d7791b00so7071815ad.0
        for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436501; x=1793041301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zPfvRWM7bSNeBi2gQjCK2xqmlEgV+DzhRh7S+wwhFIw=;
        b=OOzWEP9A13yvn7IDRzpSBQULW1MraF5lMOdMHKUir0slkMU0jl69RWniFMFrfr/Y5v
         mNM/MroFMs+lz9pbII329dSRc2y+Zu86FF71af/KdsNM9AcMJWFWzqTWeyKeG8k9GdhT
         +f7LzvLc+jXbpcYzL96idvhPgsU83xmE/u48Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436501; x=1793041301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zPfvRWM7bSNeBi2gQjCK2xqmlEgV+DzhRh7S+wwhFIw=;
        b=mtISj/Ec5JrKf7+AEFdsalpt3oUSdtgT6bFfWALev2e1U/IOoe0bb2P92YEQhldi/M
         dSnlOp9hHiXPySlfRV+icr6XsO0QD1qwwMmwTdi6Wxya9NLacynJM9PKzedQfnJssmtO
         l/kUrra2u1tZ6IHGVR+eMCC6kcAyRMILz0WTOd/xr2i5tlmG7cAB2tQxAOy8gXvLFeYB
         6MozpOChcci8S5nLmlo7Ux03vFXt0iqbMNLwZViQRO1ZG3u3WUElhUoiqthEsBG+QQ8Z
         y1DVAF6a1NXIhddOjn5uXaX2xvZXGXYxdZckwz2JGt4FqBSCS8LWxxrELrobjiRPsJYu
         iv0g==
X-Forwarded-Encrypted: i=1; AKwUvByq5m7Pti5AW8IYwRPFwOB3MavJMKmpwrX9IkogaOe0hWSKDEASKTDs9lbVpj6ac6UtAguBbMBEzLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCtKpnFRnuX08fc0KcJNEntpjrkbnwc1hXutb9eM3duOA2VTWi
	3OnE/05/24K8szywY1qZRG8HSHWqwIWFr4WOGaxbmskjqa5rtWaBNuip4f3Axd3JEA==
X-Gm-Gg: AYBFou1qQj0I5++bYy44hdJbeTS4tqvAbKB7+PjgfTwpsGv7eiHHm4+EnMiepc/gnbf
	daUmF+aXUtPdVWQCr6x5brP8sb/eH66wVPyrsppO8Cj5ECmDgzY8m4RCY5Suai9l03PKBUFwy0f
	BPhrSnegU9oK+KvUPAk4IXaUrilPqsuoGiPIgehWAL00doB7npY093mF4RixM1I9FyMyEtkKiEg
	B/Dd2Zr46gS7LP+D3enh8feqNh/EBXrgwRyPze6vtyJtEtN5oxPd9L8PK7dwt3J1PjYGszVOnqf
	bJdamuVwsLOJYO/Y6c7CW13fVoR0z0RUOigoKtpVHSr0xCFGXA72LNfubrWTEC7F8S0ziBRCLx9
	vHtQNxvUJ6RoMkI+mnzcvw+sQx+Ayh3WL7ImTuVxuo+ClAqrTQpDynIJz1swuKBff2AlHhEIsES
	9LgNROw4Ca7YXY54SN1/uBpL7YQn76slB2zMjlPC12aZ6X8GMT+psJJTemN0P0+/HCdpyAMHxkM
	GOe1702NJOCFMctMaaBZzaD5z37g0NKUjUFHK242MA44bPKCFDkc6ivWREW9Yg4/GtI34YI5PDK
	fFx9frOsJa1DrcsM
X-Received: by 2002:a17:903:19e7:b0:2e9:5059:4468 with SMTP id d9443c01a7336-2e9a683494emr71737535ad.7.1792436501030;
        Mon, 19 Oct 2026 12:01:41 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:40 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:21 +0000
Subject: [PATCH v6 09/11] HID: spi-hid: add device tree support for HID
 over SPI
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-send-upstream-v6-9-cb9ba4b3d6fa@chromium.org>
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
In-Reply-To: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
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
 hbarnor@chromium.org, tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com, 
 Jingyuan Liang <jingyliang@chromium.org>, 
 Jarrett Schultz <jaschultz@microsoft.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=8811;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=ZwplQx3Zaio7A0BeO3K1MwL13gktGgnxvBWSAzF3474=;
 b=hj1gYmEhnIR2luvY05+VzohgfAKYfecLZ7gP9Zi8ZZmeDQaAMJWyQL+VuDRcTaSY/9+ffvLP3
 Hmn5LFFKlVABs01WX/YT2ic5JqNOlsDsHlE+oEnAIYSK0lv5MDt55Yo
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Jarrett Schultz <jaschultz@microsoft.com>

Detect SPI HID devices described in Device Tree.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig      |  15 +++
 drivers/hid/spi-hid/Makefile     |   1 +
 drivers/hid/spi-hid/spi-hid-of.c | 241 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 303ada03a1bf..63f202975ac3 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -26,6 +26,21 @@ config SPI_HID_ACPI
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
index 3ca326602643..31192e71edae 100644
--- a/drivers/hid/spi-hid/Makefile
+++ b/drivers/hid/spi-hid/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
 spi-hid-objs 			= spi-hid-core.o
 CFLAGS_spi-hid-core.o 		:= -I$(src)
 obj-$(CONFIG_SPI_HID_ACPI)	+= spi-hid-acpi.o
+obj-$(CONFIG_SPI_HID_OF)	+= spi-hid-of.o
diff --git a/drivers/hid/spi-hid/spi-hid-of.c b/drivers/hid/spi-hid/spi-hid-of.c
new file mode 100644
index 000000000000..24215ffaaafd
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-of.c
@@ -0,0 +1,241 @@
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
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "spi-hid.h"
+
+struct spi_hid_timing_data {
+	u32 post_power_on_delay_ms;
+	u32 minimal_reset_delay_ms;
+};
+
+/* Config structure is filled with data from Device Tree */
+struct spi_hid_of_config {
+	struct spihid_ops ops;
+
+	struct spi_hid_conf property_conf;
+	const struct spi_hid_timing_data *timing_data;
+
+	struct gpio_desc *reset_gpio;
+	struct regulator *supply;
+	bool supply_enabled;
+};
+
+static const struct spi_hid_timing_data timing_data = {
+	.post_power_on_delay_ms = 10,
+	.minimal_reset_delay_ms = 100,
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
+		dev_err(dev, "Input report header address not provided\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_header_address = val;
+
+	error = device_property_read_u32(dev, "input-report-body-address", &val);
+	if (error) {
+		dev_err(dev, "Input report body address not provided\n");
+		return -ENODEV;
+	}
+	conf->property_conf.input_report_body_address = val;
+
+	error = device_property_read_u32(dev, "output-report-address", &val);
+	if (error) {
+		dev_err(dev, "Output report address not provided\n");
+		return -ENODEV;
+	}
+	conf->property_conf.output_report_address = val;
+
+	error = device_property_read_u8(dev, "read-opcode",
+					&conf->property_conf.read_opcode);
+	if (error) {
+		dev_err(dev, "Read opcode not provided\n");
+		return -ENODEV;
+	}
+
+	error = device_property_read_u8(dev, "write-opcode",
+					&conf->property_conf.write_opcode);
+	if (error) {
+		dev_err(dev, "Write opcode not provided\n");
+		return -ENODEV;
+	}
+
+	conf->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(conf->supply))
+		return dev_err_probe(dev, PTR_ERR(conf->supply),
+				     "Failed to get regulator\n");
+	conf->supply_enabled = false;
+
+	conf->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(conf->reset_gpio),
+				     "Failed to get reset GPIO\n");
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
+		fsleep(1000 * conf->timing_data->post_power_on_delay_ms);
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
+	return gpiod_set_value_cansleep(conf->reset_gpio, 1);
+}
+
+static int spi_hid_of_deassert_reset(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+
+	return gpiod_set_value_cansleep(conf->reset_gpio, 0);
+}
+
+static void spi_hid_of_sleep_minimal_reset_delay(struct spihid_ops *ops)
+{
+	struct spi_hid_of_config *conf = container_of(ops,
+						      struct spi_hid_of_config,
+						      ops);
+	fsleep(1000 * conf->timing_data->minimal_reset_delay_ms);
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
+	config->timing_data = device_get_match_data(dev);
+	if (!config->timing_data)
+		config->timing_data = &timing_data;
+
+	/*
+	 * FIXME: multi-SPI not supported. Once it is, derive the
+	 * HID-over-SPI flags from spi->mode.
+	 */
+
+	error = spi_hid_of_populate_config(config, dev);
+	if (error)
+		return dev_err_probe(dev, error, "Unable to populate config data\n");
+
+	return spi_hid_core_probe(spi, &config->ops, &config->property_conf);
+}
+
+static const struct of_device_id spi_hid_of_match[] = {
+	{ .compatible = "hid-over-spi", .data = &timing_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_hid_of_match);
+
+static const struct spi_device_id spi_hid_of_id_table[] = {
+	{ .name = "hid" },
+	{ .name = "hid-over-spi" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, spi_hid_of_id_table);
+
+static struct spi_driver spi_hid_of_driver = {
+	.driver = {
+		.name = "spi_hid_of",
+		.owner = THIS_MODULE,
+		.of_match_table = spi_hid_of_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = spi_hid_groups,
+	},
+	.probe = spi_hid_of_probe,
+	.remove = spi_hid_core_remove,
+	.id_table = spi_hid_of_id_table,
+};
+
+module_spi_driver(spi_hid_of_driver);
+
+MODULE_DESCRIPTION("HID over SPI OF transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0.212.g129ede20d9-goog

