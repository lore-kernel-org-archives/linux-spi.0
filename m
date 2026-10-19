Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436504;
	b=A3CD/Qbz19TcmSUXSSJXZUh3sGsQxiCFv6XzDxcw/ie+0tXSxbyRuednlwjBKUfajd9g
	 t67/eYgYpgiOSakHjXEunkV4m0qxR1tXm0pV4HspJXNoa4/HpXUnNJ8WdvrshYsXyqsLH
	 8hCN7OsohJBi0oIIiEub1r7BFf2r8rJi+qAKiVtpbnPRAAh5n+rxrNgZ+qUzXutRmKCa3
	 0ViFu3gkiREV4vUdXo009Niy5MxdOrvpyr++Oa8ll0JCbtlemCX8bja00WxxOYAJRELsT
	 HwxbiFmAe+eVCmEyS2v5NbjV2Mjakl15CloeMslLY69ADC6DiRSmCcTs+qdQVKcqGeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Y274FTxmYUf/DB32r7y0TPNxArDWceGAMS3nEe5VkhQ=;
	b=DgFLt7rFxk5sZDDypE7xBwrYhfqd/AVXcUQ4EmBo1V5uECkgCKPIkIxipxyfeFj1kpEw
	 0OYPAl+lyenzlXgV2Ah1ua7gb8vUZFDmQG9eU47d3xz6OOzM6vV0PzR+IRvMmTf9eeW+m
	 HDEaMa4Tw0lf2JwVc2YkLEGsWeNL6198JrzdBWlp8aNPzxyp6KcaCS98S0ZGlqdTIMU8D
	 5rtYRm7He9Zrvsib5YvYgXdwtobsfvxMHDFRoKKENfSJD62Rl9TDxYsQinVEP98G4rXFR
	 994AQMAk1oxwbn7OF7gltIKIth35u/mGBIbsSOnM5RauQxwj8kq5LbT8UpJ0tezJLUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WXSm9StN;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5200360A5BCF
	for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 19:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5200360A5BCF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WXSm9StN
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8fe8e343fso12715525ad.2
        for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792436504; x=1793041304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y274FTxmYUf/DB32r7y0TPNxArDWceGAMS3nEe5VkhQ=;
        b=WXSm9StNeip5WrR3Wjoa/TKhkiiPRntjCZ1+X18Qi/8d4Qf4ccjYiEf5gvvsJWt8I7
         bHlUHOvt/u1aGdJhHyOJLciuJ0h1KHPOVHjpKKJvCKCQxQhE5jj9M5KjjpamxhryJY8C
         JPT9p+1purQBv8fw4DA2kBcferO0Vc0V7FZHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436504; x=1793041304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y274FTxmYUf/DB32r7y0TPNxArDWceGAMS3nEe5VkhQ=;
        b=GJulTFGmhR0sDNZJ/xBhCQiKzSu6kS8A7yDN2usxwflWyGOOdDKJhCNM4ZwyDejxgP
         ZRWxowlJ2nGto18CVP0vq7vtIohHjPQoDisvzccbcLqNn+WhR681X79hz0NRO6m4qKgt
         BqDFhl2zsh8DqtV2qngXQJeyKuyEoDGgwU3eKIAPIVrY4T1tTOShXenMfPtjTWAOxrTB
         DCxWSQ0z6LVMyJgE64XNyxi5FhWxLMMyXAV+grgV1BcERmjPU6GDnLdZYmvcsABSgjok
         jjeUMmleyCS4btpsuP9s4zLIwwzpjRetds3IvzX1xut04ZhcP3iaW3Vp6YH7wopzBN1M
         NWmQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8Cefd+V5BmD4K6z/25YNDD9rJIgXsrrr5K/oI1keaP8xyVRXJsM3YR7YYNOK0zv/w2APKj7eGGQU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgXtTUnUWlLxeMH+JNSHz9wDSjsDdH9srLo8nVLAHmvGP7poij
	kDSaVG8EOquVCMnSvOjzmiUU6cBB/OPeSqR5hpRFoi3IoLrZwbK2t9STxb5gU551NA==
X-Gm-Gg: AYBFou20pCSAoxcU4VXFx4qMAwUbUbD1VFyJ4eGovj6yUgItO5HUSVEHS5AgxNz7dB7
	ky8JnhQATrUVY86zyGoZV9JPcdLk9C6pdm1I/Eslv7/GOXfYKqTOEEgFgMj6CT57l34NEE1uTT7
	3T+/0ROHfulQLU11Zusy2zjDiGNeYY+xhrRM8T5IGTzOO/uA/hifqcnuFidLMvZF4I7vkeYhEie
	GvWZKRA9PES7frg6m9nWTuQMo/c0/1bpjhCNRiMb4Z7/fSLU+jgN6A+HRGwcydBvxO4vGEv9KN0
	QGB5CFMIaJuZqBRDH0WCqpiu0PATqg5lbUusukUGSNNsUT5dSU4WpMxFFWm2PTntVnjmePqXRBd
	GXKN5HRzUzSn+XZZrpJqicB5l2Z+Wofw4lJp4IS9RWdt0uhf7ciI9bxrr7NUQRv5r7QXUpxwsNq
	LjYlxJQy47qtjwOapLiZQ6g10AZf3Nw6K4sOu/I9H2I/eIXzcxWbZF+otJtCe/0GlzmUDZJ5z+k
	57g0JNOM2lAOy13IZQuPuHv3Lc3XyFrI1MIQcoiaQ6zmleILj007DtlBJKRs+7ZIaP4kP8cZJpA
	mFRpAQ==
X-Received: by 2002:a17:903:196b:b0:2e8:422e:19c5 with SMTP id d9443c01a7336-2e9a6c13951mr68093305ad.55.1792436503515;
        Mon, 19 Oct 2026 12:01:43 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151e1b7esm4473105ad.75.2026.10.19.12.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:01:42 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Mon, 19 Oct 2026 19:01:23 +0000
Subject: [PATCH v6 11/11] HID: spi-hid: add panel follower support
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
Message-Id: <20261019-send-upstream-v6-11-cb9ba4b3d6fa@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792436487; l=11787;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=58Z5ay6cDlPDvzDgbQSMgMYgeRWx5N4kbp52bg9SFvU=;
 b=vtse1LNlmFkZ8YhPhTjehDIf2rFltt7WFZ1zjOUr0uz2IK85yhSTsNvjAL8GKUxAVeLxD10rn
 iCi51tQF17nDero898EYpCdb5JD+LUTOfy4/WnsPpCXQo7mq4ZJJaRg
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add support to spi-hid to be a panel follower.

Tested-by: Dale Whinham <daleyo@gmail.com>
Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig        |   4 +
 drivers/hid/spi-hid/spi-hid-core.c | 213 ++++++++++++++++++++++++++++---------
 drivers/hid/spi-hid/spi-hid-core.h |   7 ++
 3 files changed, 174 insertions(+), 50 deletions(-)

diff --git a/drivers/hid/spi-hid/Kconfig b/drivers/hid/spi-hid/Kconfig
index 63f202975ac3..656dbda1c5d8 100644
--- a/drivers/hid/spi-hid/Kconfig
+++ b/drivers/hid/spi-hid/Kconfig
@@ -13,6 +13,7 @@ if SPI_HID
 config SPI_HID_ACPI
 	tristate "HID over SPI transport layer ACPI driver"
 	depends on ACPI
+	depends on DRM || !DRM
 	select RESET_CONTROLLER
 	select SPI_HID_CORE
 	help
@@ -29,6 +30,7 @@ config SPI_HID_ACPI
 config SPI_HID_OF
 	tristate "HID over SPI transport layer Open Firmware driver"
 	depends on OF
+	depends on DRM || !DRM
 	select SPI_HID_CORE
 	help
 	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
@@ -43,4 +45,6 @@ config SPI_HID_OF
 
 config SPI_HID_CORE
 	tristate
+	# We need to call into panel code so if DRM=m, this can't be 'y'
+	depends on DRM || !DRM
 endif
diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi-hid-core.c
index c2232d5959b8..8b2e21be5107 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -281,7 +281,9 @@ static int spi_hid_suspend(struct spi_hid *shid)
 			if (error) {
 				dev_err(dev, "%s failed to suspend hid driver: %d\n",
 					__func__, error);
-				return error;
+				/* A follower powers off with the panel anyway. */
+				if (!shid->is_panel_follower)
+					return error;
 			}
 		}
 	}
@@ -311,6 +313,9 @@ static int spi_hid_suspend(struct spi_hid *shid)
 				dev_err(dev, "%s: could not power down\n", __func__);
 				shid->regulator_error_count++;
 				shid->regulator_last_error = error;
+			}
+			/* A follower powers off with the panel anyway. */
+			if (error && !shid->is_panel_follower) {
 				/*
 				 * Undo partial suspend before returning error.
 				 * Complete the reset; RESET_PENDING stays set
@@ -346,26 +351,28 @@ static int spi_hid_resume(struct spi_hid *shid)
 		return 0;
 	}
 
-	if (!device_may_wakeup(dev)) {
-		if (shid->power_state == HIDSPI_OFF) {
-			shid->ops->assert_reset(shid->ops);
+	/*
+	 * Check power_state, not device_may_wakeup(): power/wakeup can change
+	 * while the device is off.
+	 */
+	if (shid->power_state == HIDSPI_OFF) {
+		shid->ops->assert_reset(shid->ops);
 
-			shid->ops->sleep_minimal_reset_delay(shid->ops);
+		shid->ops->sleep_minimal_reset_delay(shid->ops);
 
-			error = shid->ops->power_up(shid->ops);
-			if (error) {
-				dev_err(dev, "%s: could not power up\n", __func__);
-				shid->regulator_error_count++;
-				shid->regulator_last_error = error;
-				/* Suspend runs next even if resume fails. */
-				enable_irq(shid->spi->irq);
-				return error;
-			}
-			shid->power_state = HIDSPI_ON;
-			reinit_completion(&shid->reset_done);
-			shid->ops->deassert_reset(shid->ops);
-			was_reset = true;
+		error = shid->ops->power_up(shid->ops);
+		if (error) {
+			dev_err(dev, "%s: could not power up\n", __func__);
+			shid->regulator_error_count++;
+			shid->regulator_last_error = error;
+			/* Suspend runs next even if resume fails. */
+			enable_irq(shid->spi->irq);
+			return error;
 		}
+		shid->power_state = HIDSPI_ON;
+		reinit_completion(&shid->reset_done);
+		shid->ops->deassert_reset(shid->ops);
+		was_reset = true;
 	}
 
 	enable_irq(shid->spi->irq);
@@ -1504,6 +1511,110 @@ const struct attribute_group *spi_hid_groups[] = {
 };
 EXPORT_SYMBOL_GPL(spi_hid_groups);
 
+/*
+ * At the end of probe we initialize the device:
+ *   0) assert reset, bias the interrupt line
+ *   1) sleep minimal reset delay
+ *   2) power up the device
+ *   3) deassert reset (high)
+ * After this we expect an IRQ with a reset response.
+ */
+static int spi_hid_dev_init(struct spi_hid *shid)
+{
+	struct spi_device *spi = shid->spi;
+	struct device *dev = &spi->dev;
+	int error;
+
+	guard(mutex)(&shid->power_lock);
+
+	shid->ops->assert_reset(shid->ops);
+
+	shid->ops->sleep_minimal_reset_delay(shid->ops);
+
+	error = shid->ops->power_up(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: could not power up\n", __func__);
+		shid->regulator_error_count++;
+		shid->regulator_last_error = error;
+		return error;
+	}
+
+	shid->power_state = HIDSPI_ON;
+	error = shid->ops->deassert_reset(shid->ops);
+	if (error) {
+		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
+		shid->ops->power_down(shid->ops);
+		shid->power_state = HIDSPI_OFF;
+		return error;
+	}
+
+	enable_irq(spi->irq);
+
+	return 0;
+}
+
+static void spi_hid_panel_follower_work(struct work_struct *work)
+{
+	struct spi_hid *shid = container_of(work, struct spi_hid,
+					    panel_follower_work);
+	int error;
+
+	/* Also does the first power up: probe leaves the device off. */
+	error = spi_hid_resume(shid);
+	if (error)
+		dev_warn(&shid->spi->dev, "Power on failed: %d\n", error);
+	/* Even a failed resume enables the IRQ; let suspend undo it. */
+	WRITE_ONCE(shid->panel_follower_work_finished, true);
+}
+
+static int spi_hid_panel_follower_resume(struct drm_panel_follower *follower)
+{
+	struct spi_hid *shid = container_of(follower, struct spi_hid, panel_follower);
+
+	/* Powering on can be slow; don't block the panel's power up. */
+	WRITE_ONCE(shid->panel_follower_work_finished, false);
+	schedule_work(&shid->panel_follower_work);
+
+	return 0;
+}
+
+static int spi_hid_panel_follower_suspend(struct drm_panel_follower *follower)
+{
+	struct spi_hid *shid = container_of(follower, struct spi_hid, panel_follower);
+
+	cancel_work_sync(&shid->panel_follower_work);
+
+	if (!READ_ONCE(shid->panel_follower_work_finished))
+		return 0;
+
+	return spi_hid_suspend(shid);
+}
+
+static const struct drm_panel_follower_funcs
+				spi_hid_panel_follower_prepare_funcs = {
+	.panel_prepared = spi_hid_panel_follower_resume,
+	.panel_unpreparing = spi_hid_panel_follower_suspend,
+};
+
+static int spi_hid_register_panel_follower(struct spi_hid *shid)
+{
+	struct device *dev = &shid->spi->dev;
+
+	shid->panel_follower.funcs = &spi_hid_panel_follower_prepare_funcs;
+
+	/*
+	 * If we're not in control of our own power up/power down then we can't
+	 * do the logic to manage wakeups. Give a warning if a user thought
+	 * that was possible then force the capability off.
+	 */
+	if (device_can_wakeup(dev)) {
+		dev_warn(dev, "Can't wakeup if following panel\n");
+		device_set_wakeup_capable(dev, false);
+	}
+
+	return drm_panel_add_follower(dev, &shid->panel_follower);
+}
+
 int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		       struct spi_hid_conf *conf)
 {
@@ -1519,10 +1630,11 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		return -ENOMEM;
 
 	shid->spi = spi;
-	shid->power_state = HIDSPI_ON;
+	shid->power_state = HIDSPI_OFF;
 	shid->ops = ops;
 	shid->conf = conf;
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+	shid->is_panel_follower = drm_is_panel_follower(&spi->dev);
 
 	spi_set_drvdata(spi, shid);
 
@@ -1537,6 +1649,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	init_completion(&shid->reset_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+	INIT_WORK(&shid->panel_follower_work, spi_hid_panel_follower_work);
 
 	/*
 	 * we need to allocate the buffer without knowing the maximum
@@ -1547,20 +1660,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	if (error)
 		return error;
 
-	/*
-	 * At the end of probe we initialize the device:
-	 *   0) assert reset, bias the interrupt line
-	 *   1) sleep minimal reset delay
-	 *   2) request IRQ
-	 *   3) power up the device
-	 *   4) deassert reset (high)
-	 * After this we expect an IRQ with a reset response.
-	 */
-
-	shid->ops->assert_reset(shid->ops);
-
-	shid->ops->sleep_minimal_reset_delay(shid->ops);
-
 	error = devm_request_threaded_irq(dev, spi->irq, NULL, spi_hid_dev_irq,
 					  IRQF_ONESHOT | IRQF_NO_AUTOEN, dev_name(&spi->dev), shid);
 	if (error) {
@@ -1580,21 +1679,17 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		}
 	}
 
-	error = shid->ops->power_up(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: could not power up\n", __func__);
-		return error;
-	}
-
-	error = shid->ops->deassert_reset(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
-		shid->ops->power_down(shid->ops);
-		return error;
+	if (shid->is_panel_follower) {
+		error = spi_hid_register_panel_follower(shid);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "Failed to register panel follower\n");
+	} else {
+		error = spi_hid_dev_init(shid);
+		if (error)
+			return error;
 	}
 
-	enable_irq(spi->irq);
-
 	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
 		spi_hid_power_mode_string(shid->power_state));
 
@@ -1608,15 +1703,27 @@ void spi_hid_core_remove(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int error;
 
+	if (shid->is_panel_follower) {
+		drm_panel_remove_follower(&shid->panel_follower);
+		/* Already cancelled by panel_unpreparing; be explicit. */
+		cancel_work_sync(&shid->panel_follower_work);
+	}
+
+	/*
+	 * Follower suspend above can be skipped. Disabling again is
+	 * fine: nothing re-enables the IRQ before devres frees it.
+	 */
 	disable_irq(spi->irq);
 	disable_work_sync(&shid->reset_work);
 
 	spi_hid_stop_hid(shid);
 
-	shid->ops->assert_reset(shid->ops);
-	error = shid->ops->power_down(shid->ops);
-	if (error)
-		dev_err(dev, "failed to disable regulator\n");
+	if (shid->power_state != HIDSPI_OFF) {
+		shid->ops->assert_reset(shid->ops);
+		error = shid->ops->power_down(shid->ops);
+		if (error)
+			dev_err(dev, "failed to disable regulator\n");
+	}
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_remove);
 
@@ -1624,6 +1731,9 @@ static int spi_hid_core_pm_suspend(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_suspend(shid);
 }
 
@@ -1631,6 +1741,9 @@ static int spi_hid_core_pm_resume(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_resume(shid);
 }
 
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 0b3248aedfce..631897dd9e8a 100644
--- a/drivers/hid/spi-hid/spi-hid-core.h
+++ b/drivers/hid/spi-hid/spi-hid-core.h
@@ -10,6 +10,8 @@
 #include <linux/hid-over-spi.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_panel.h>
+
 /* Protocol message size constants */
 #define SPI_HID_READ_APPROVAL_LEN		5
 #define SPI_HID_OUTPUT_HEADER_LEN		8
@@ -56,6 +58,10 @@ struct spi_hid {
 	struct spi_hid_input_buf *input;	/* Input buffer. */
 	struct spi_hid_input_buf *response;	/* Response buffer. */
 
+	struct drm_panel_follower panel_follower;
+	bool	is_panel_follower;
+	bool	panel_follower_work_finished;
+
 	u16 response_length;
 	u16 bufsize;
 	/* Response type awaited by a sync request, 0 if none. Protected by io_lock. */
@@ -70,6 +76,7 @@ struct spi_hid {
 	unsigned long flags;	/* device flags. */
 
 	struct work_struct reset_work;
+	struct work_struct panel_follower_work;
 
 	/*
 	 * Serializes request/response transactions: held from sending a

-- 
2.56.0.212.g129ede20d9-goog

