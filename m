Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803120;
	b=q4DWj/6dRJxOgxlxCwQFleibwoxx2i4wim/gCB44X8untLZM+HBm0ZNYMhHbri6HDm+p
	 xGLrNu7B0EBPUvQyDXOXSasZgXI/ImVchAtqNQfj9dz5cmbMV3t6gV3v1sI/t9gpfo+lp
	 kok5T5wZ9zoJVyRIWMbr7aELj5zU9wf5pAl8jmiGK1twzc3txpM1wIY1bB1FK4ueNQMIW
	 r0p3I6jFfyBBOMkx86DANDPBOsRUAPthSEIiS1xPSGGNo+5G3+jOdY06XOLThHo9/7Taa
	 JFJK7U4WCPl12cu/uRODLow/SYvxlzrCxjdxvoPyXoHT9ZDtkB4YsHf+zfZKPoxo9vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WyQaDxrxGTsX5Oh1V8K+PKKyhp5Oq8DyrDg5XAZ9Gwc=;
	b=U35JNTT0pvqXMCZI+Brp34LgFdeHbZVIaCS4RK3kgCwaobQG53el2w9zPkXUsvbxA/Y9
	 Kg8xUnAC9RmzEQpEtltpgLvaClDnTQfjY/SP55mu3Z3ec4yKiwzP0h/YB8kR38w/HZC7U
	 tAOZV5WIcThha4/zVisyTF/A4P2zXNRhBiTgvUxqb7k6ZbOwPcX2n+FHt6h0kZnbjC+D7
	 ktAG/6b56jrHYXxGVqCMna2lINx53vjm326lrp3g/uSOtLmElDXDSzvZcgaxUFF543xyb
	 8UudZlyF9LflCFqC+gG4zIAQvVh1GrEs79CPsXi3k+uL7ORiHqlV1VywAHQ/eTs4PQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36360A260C
	for <linux-spi@vger.kernel.org>; Sat, 24 Oct 2026 00:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A36360A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso818850a91.3
        for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 17:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803114; x=1793407914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyQaDxrxGTsX5Oh1V8K+PKKyhp5Oq8DyrDg5XAZ9Gwc=;
        b=WzTEMHktigzn5QU1ypgOW78Rjy6sGrSK6BNYl5UkSRi5I21k3KxC0mbXdQ9L3U5MPG
         1qwvnj+1kaPgyPlBGcAYC+oMgdtOjIPV9A1reZAArVSLkFf4cx4xo2HC1cxgiQxn5zAg
         fTWDAA4FhhNDmToS2ZLuGfAV2FT9XdBodGyG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803114; x=1793407914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WyQaDxrxGTsX5Oh1V8K+PKKyhp5Oq8DyrDg5XAZ9Gwc=;
        b=GnY5afKkve/cae9jZS8eQkq0hF2tDQcm6H6R45WNaA4twKz/4i2HzBNKq63Qvbh7XS
         8LlevKCIgWuH1tpIKTby5otZPnfxG+GppPrS5cBLTIP/WghETGYqHGb32m3HUr98QZga
         xL9KKmoc/JWDzDUxYH1jcEBzJ4Fldp68OQWL0njvTMy3DwRbYzcos1Hh8lY/9RwmUb7S
         tqg68ju+gt9eWhzdJboMdZ+9G7ktQKN3WoMTJ97YIOnvsES2blNuWG8AZY+/uBI2A01/
         8st4y2vlKQcoF+YP7YSvxODUeTDvyBAwaYOKhH+h+np2Q2MyOIkqy2LjRWVCe/s28jf6
         S6TQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZ/QIJA4vVxAc2+xzk4d6LIfnCUd+/s0wc3V1RuL4jQ0wSVIlgvbs6vAzYN45H6TByODxtErZjbio=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtlae7eZBgzbITHW2wj9Wa6fSdO5VMDTI0vMpdEaVbp6tglVSh
	4LrKzUsn8wGfjJmiPllj8MtX8P2/hBUOtSnx6DB8y2jTiV38YPR9o5V2y+mXE6s5YA==
X-Gm-Gg: AYBFou1rwIWqt1Wrn57RdtMnUaN51l1gA73PpU/qhMlfwAgWD8P5tcMOe9ZCsEKGvxm
	BkZHLS+sZh3Nd9GUjsCttQjSknjdw/0vnIXw4J6/Vj6QnmfSJYnVF2z508FobjrGzOQc3zEpG1Q
	qMNg/5IG32vCoccqmYuj6tinhH2mP4CKIZ+SPiglXnhP5asx00mBi8OD+SaNg6d+vya0DJW9nuK
	5WaBkVjiZbAdRuIRgEM+5mmaSdB69rMXeeplNvv1ktlFuCnQGQgA4Jodp4JGxcrORvccB2UzpNT
	kUR8TzNLjPF6UBMQI18LT14bma/vln3NGK0seMAIaIiV9AvCm8i3c4ii0SQywFPoXe89ieEwmfP
	w/8dlEi7AgtG7xKp3DBAhIaR4X+P6OnErlS+cFm+kuKIexoN5doYNEKXhZYzzUC5/E60K/gGIny
	tcdYkwyZVLrLdN4q2C2eEWyaR7VkfLAKX7A1gm2lY0AGIWjK9HKov77uq35ZTCBIVtfvaQMZht/
	yUqZYbqVA8ZqNtsn2SviLbYaPPEz6byO5ZV6ENt35/AYpoP1jqgrMj8f3TWZcc+PDgPboxzHnrU
	NlKZHMaSj3xLZ+qomFkK6mYZrI692S1JcYEPOJvuFeTVIlv4f+OBOFlrjHi1dFk=
X-Received: by 2002:a17:90b:564d:b0:3ac:8ee5:e00f with SMTP id 98e67ed59e1d1-3adeafb048dmr756235a91.57.1792803114041;
        Fri, 23 Oct 2026 17:51:54 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:53 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:37 +0000
Subject: [PATCH v7 03/11] HID: spi-hid: add transport driver skeleton for
 HID over SPI bus
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
Message-Id: <20261024-send-upstream-v7-3-abad13174b43@chromium.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
In-Reply-To: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>, Angela Czubak <acz@semihalf.com>, 
 Dmitry Antipov <dmanti@microsoft.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=7049;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=dHd9ieI1rPWyNtZTf93ybIIIk3OGUSmw9cXrsWLZvDQ=;
 b=ipH/tV9JOZ3DbvJONxOAfdMqw9rKAu9tJrIPcOhAC2CR7qcP6xAaUKhV6h0bP3V+wJEPwD56u
 nseVQfrdrZcCIy8qrDC5nqHElhiGx8Vv+KJry6G8LiTt87kfPzbhiAw
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

From: Angela Czubak <acz@semihalf.com>

Create spi-hid folder and add Kconfig and Makefile for spi-hid driver.
Add basic device structure, definitions, and probe/remove functions.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Angela Czubak <acz@semihalf.com>
Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/Kconfig                |   2 +
 drivers/hid/Makefile               |   2 +
 drivers/hid/spi-hid/Kconfig        |  15 ++++
 drivers/hid/spi-hid/Makefile       |   9 +++
 drivers/hid/spi-hid/spi-hid-core.c | 158 +++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c43e824428f0..17a42301875c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1527,6 +1527,8 @@ source "drivers/hid/bpf/Kconfig"
 
 source "drivers/hid/i2c-hid/Kconfig"
 
+source "drivers/hid/spi-hid/Kconfig"
+
 source "drivers/hid/intel-ish-hid/Kconfig"
 
 source "drivers/hid/amd-sfh-hid/Kconfig"
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 48a863b245ee..b5a7ef7f208f 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -177,6 +177,8 @@ obj-$(CONFIG_USB_KBD)		+= usbhid/
 
 obj-$(CONFIG_I2C_HID_CORE)	+= i2c-hid/
 
+obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid/
+
 obj-$(CONFIG_INTEL_ISH_HID)	+= intel-ish-hid/
 
 obj-$(CONFIG_AMD_SFH_HID)       += amd-sfh-hid/
diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
new file mode 100644
index 000000000000..836fdefe8345
--- /dev/null
+++ b/drivers/hid/spi-hid/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+
+menuconfig SPI_HID
+	tristate "SPI HID support"
+	default y
+	depends on SPI
+
+if SPI_HID
+
+config SPI_HID_CORE
+	tristate
+endif
diff --git a/drivers/hid/spi-hid/Makefile b/drivers/hid/spi-hid/Makefile
new file mode 100644
index 000000000000..92e24cddbfc2
--- /dev/null
+++ b/drivers/hid/spi-hid/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the SPI HID input drivers
+#
+# Copyright (c) 2021 Microsoft Corporation
+#
+
+obj-$(CONFIG_SPI_HID_CORE)	+= spi-hid.o
+spi-hid-objs 			= spi-hid-core.o
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
new file mode 100644
index 000000000000..4991dc972cae
--- /dev/null
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HID over SPI protocol implementation
+ *
+ * Copyright (c) 2021 Microsoft Corporation
+ * Copyright (c) 2026 Google LLC
+ *
+ * This code is partly based on "HID over I2C protocol implementation:
+ *
+ *  Copyright (c) 2012 Benjamin Tissoires <benjamin.tissoires@gmail.com>
+ *  Copyright (c) 2012 Ecole Nationale de l'Aviation Civile, France
+ *  Copyright (c) 2012 Red Hat, Inc
+ *
+ *  which in turn is partly based on "USB HID support for Linux":
+ *
+ *  Copyright (c) 1999 Andreas Gal
+ *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
+ *  Copyright (c) 2007-2008 Oliver Neukum
+ *  Copyright (c) 2006-2010 Jiri Kosina
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/hid-over-spi.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+/* struct spi_hid_conf - Conf provided to the core */
+struct spi_hid_conf {
+	u32 input_report_header_address;
+	u32 input_report_body_address;
+	u32 output_report_address;
+	u8 read_opcode;
+	u8 write_opcode;
+};
+
+/**
+ * struct spihid_ops - Ops provided to the core
+ * @power_up: do sequencing to power up the device
+ * @power_down: do sequencing to power down the device
+ * @assert_reset: do sequencing to assert the reset line
+ * @deassert_reset: do sequencing to deassert the reset line
+ * @sleep_minimal_reset_delay: minimal sleep delay during reset
+ */
+struct spihid_ops {
+	int (*power_up)(struct spihid_ops *ops);
+	int (*power_down)(struct spihid_ops *ops);
+	int (*assert_reset)(struct spihid_ops *ops);
+	int (*deassert_reset)(struct spihid_ops *ops);
+	void (*sleep_minimal_reset_delay)(struct spihid_ops *ops);
+};
+
+/* Driver context */
+struct spi_hid {
+	struct spi_device	*spi;	/* spi device. */
+	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
+
+	struct spihid_ops	*ops;
+	struct spi_hid_conf	*conf;
+
+	enum hidspi_power_state power_state;
+};
+
+static const char *spi_hid_power_mode_string(enum hidspi_power_state power_state)
+{
+	switch (power_state) {
+	case HIDSPI_ON:
+		return "d0";
+	case HIDSPI_SLEEP:
+		return "d2";
+	case HIDSPI_OFF:
+		return "d3";
+	default:
+		return "unknown";
+	}
+}
+
+static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
+{
+	return IRQ_HANDLED;
+}
+
+int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
+		       struct spi_hid_conf *conf)
+{
+	struct device *dev = &spi->dev;
+	struct spi_hid *shid;
+	int error;
+
+	if (spi->irq <= 0)
+		return dev_err_probe(dev, spi->irq ?: -EINVAL, "Missing IRQ\n");
+
+	shid = devm_kzalloc(dev, sizeof(*shid), GFP_KERNEL);
+	if (!shid)
+		return -ENOMEM;
+
+	shid->spi = spi;
+	shid->power_state = HIDSPI_ON;
+	shid->ops = ops;
+	shid->conf = conf;
+
+	spi_set_drvdata(spi, shid);
+
+	/*
+	 * At the end of probe we initialize the device:
+	 *   0) assert reset, bias the interrupt line
+	 *   1) sleep minimal reset delay
+	 *   2) request IRQ
+	 *   3) power up the device
+	 *   4) deassert reset (high)
+	 * After this we expect an IRQ with a reset response.
+	 */
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
+					  IRQF_ONESHOT, dev_name(&spi->dev), shid);
+	if (error) {
+		dev_err(dev, "%s: unable to request threaded IRQ\n", __func__);
+		return error;
+	}
+
+	error = shid->ops->power_up(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: could not power up: %d\n", __func__, error);
+		return error;
+	}
+
+	shid->ops->deassert_reset(shid->ops);
+
+	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
+		spi_hid_power_mode_string(shid->power_state));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_hid_core_probe);
+
+void spi_hid_core_remove(struct spi_device *spi)
+{
+	struct spi_hid *shid = spi_get_drvdata(spi);
+	struct device *dev = &spi->dev;
+	int error;
+
+	shid->ops->assert_reset(shid->ops);
+	error = shid->ops->power_down(shid->ops);
+	if (error)
+		dev_err(dev, "failed to disable regulator: %d\n", error);
+}
+EXPORT_SYMBOL_GPL(spi_hid_core_remove);
+
+MODULE_DESCRIPTION("HID over SPI transport driver");
+MODULE_AUTHOR("Dmitry Antipov <dmanti@microsoft.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0.257.gf7497c7d27-goog

