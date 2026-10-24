Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803131;
	b=PZ2xCkjyZ+NE5E0aWjOhYCQKe0LULOBlMiyngUMEU50+mFQUaoGwwNMD7v6lshWhcE1Y
	 p37LgdmmroKwqhSZ42qtiCGLiR2g+0zE3ViwFwswxHllFFDBnzOTdPsfX2JnX7xDNDybd
	 Yy5gJKiafPAyryuTTS+CUpKpHiRpUTA1pQrjDL1BYOMgiIrtSsoqK1nyDNH6xoTlUJazX
	 /Pg/TbgJcDeRv4ZrR6JUTMX4VB0YBazgZbWctP5EY9pc6F8XPCSMdrVqfnBF0rnxAdj/s
	 gCjqIwxSIrRCiuQlKR4E9YBnr5AAKCcey4aO3HvxEU5Nh3SE9DYEq/yQQlajTcEF5zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=7cmNzQ+venBCfOkt5tm233/lURYnvNZW+Gno7dqxU5o=;
	b=LV/ZiwVTJVyhBxVKopvF70amCOCS0+lf3SRrWGWBEJXCIFDape1kj0dPJvMzoPlGL2wP
	 3DwPc4wvcDcTYuXpqL4lt4k5mpxZqLsdOt6r0gR9dbawQUbfjoaXgtDRd4BgAdFY58Te3
	 vtuTgix6fJ5llrRdxP35dsT7uL+ejAHWeW3PaX7mKJdGqZcVn1ZIC65sSXJRMj3Z0nSvg
	 T2wtPbLkhML/GqnFla3SQjJFrS5lz8wkPxJ+dYNlxJk7ClKh/QCpG1A+5t+qxML7XGnhb
	 16jCO7W1ElOXnZutSouh5Ws+sTMd6jcgGb8ZCXVYr8xKb7vO/zttnT45Xc+afoKX+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nfe5Kjw3;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F4606A33E
	for <linux-spi@vger.kernel.org>; Sat, 24 Oct 2026 00:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A0F4606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nfe5Kjw3
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so1688850a91.2
        for <linux-spi@vger.kernel.org>; Fri, 23 Oct 2026 17:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792803121; x=1793407921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7cmNzQ+venBCfOkt5tm233/lURYnvNZW+Gno7dqxU5o=;
        b=nfe5Kjw3eILSzv8cd5cKXvdPxvpWozlWPP7mNDO06wTVO6UX8oVRpfsi+aHtLKVv4I
         5fMPj6xozjtafXdRHQxGyKbR9qNVXXYR9Fh0hPYsGeKqUFHfO31QGshPQ19LM1N9vqIM
         2tqotcDxzYNVjS58kbqci/2fekeLXxJM++dnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792803121; x=1793407921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7cmNzQ+venBCfOkt5tm233/lURYnvNZW+Gno7dqxU5o=;
        b=tOng+vMq62yhXjgW2VBlQ+rb9w3OfJkRyRyJGALwcqYxNVAnD/CdcOscFWfLjqjG7s
         Ku7zGlh5sCQFjwap0wKngRXDcmn+ec0qBK/wRTv+GSQc5JI2Z29cCiPKmyTq5xw7yLlS
         cgjcZtfW2U2E4SI1IAoqeEfdENEANzprPbEerx5C2prodHdm9h7TJcqvbCqaJSTer+8l
         a+Jtw2GkjKqf7uDA9TEUpxEoOW07ftBxWUvzfTLlo8rZ7qRvg3NPtxs9rRj2hBgxM9Ix
         +FHTSBNtfTkkvajaXGpce4Ke096Xv9iVbtxG3dqR97S+2JMs8ysit0Tkorx+Qehd0vVD
         E2mQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBcRTcZyPaPl0QYZ9oOlCZTh0IgSRvOvapjCAOChFmp/cR0FMQXdxkw+cpAKM9EPQcxh/nV3bhqWk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOlhOCIrVpgmXvf8cG+MG/JpA5vG9jv8j99uWNtIdpGTPcc+Yd
	hY4uwD7DOEsv9Ng7BlGcr9llx72725y9l01H37jrSsgBUZQWF3D0Br0gwOIkdG0A3w==
X-Gm-Gg: AYBFou2+HOKLgOsGNbRkKYQq8Z/jw1AFlG7bbEer+L7Zol4lWWfYUl1NDMUvSIt1knA
	HHDHDxloz4mgU4WtuK2uhSiCZcqhCdKo1KofIFc2TEbF+fX7LIWJAd/IA2/lV3vSWlEoUu7DheD
	LCVJ7BBlcUF28QHQcsvJ5YFEaxpFqGSwXGDJzGoanC6t+i33n2p0Aobj7Rv2pwbULNVTJI6bwmC
	cqSyOadkFGhhQQbR95S9n+HCzhIWPKORvFykEwnzQJjxPRmOqk4voFQ8pn0H5XIEA+SbKx1d8RH
	MlzBo28AFeBEsgPrf4XSCbVvY5zBe3e06suKEgtftHu6MrJFYfKs+8EBmHyESl438S44KcOuR9Q
	nMok8thxt3gHNbe+jEaCDediO0/bzfw/dTlL/VROmQlhGko3h5SgjQViobtZO2u+XxSvZDTpQB5
	0VM3DcSef08oGIC0Db3YwB4+D1T6Na0XhEEc56ttezsE2jQi34SFbUVGDgPxXpEkHdS+s7PYTsr
	bXC1vR4joWOEWPlbkWz/2qSdN8IEFqUfKRSLW168GD9fKKDel/TtYJGai+Eu8NQPmoOiGMI5CLV
	hUvZc33EfxL0bG3ElI8AjtQa5uVfKoW8SC5DJV8zNrpG0PGUrWx1iZOPXvTnWQM=
X-Received: by 2002:a17:90a:e7ce:b0:3ac:17c:6e74 with SMTP id 98e67ed59e1d1-3adeafaa551mr723948a91.53.1792803120570;
        Fri, 23 Oct 2026 17:52:00 -0700 (PDT)
Received: from jingyliang-input-linux.c.googlers.com (218.117.230.35.bc.googleusercontent.com. [35.230.117.218])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebadfeb1sm843763a91.9.2026.10.23.17.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:51:59 -0700 (PDT)
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Sat, 24 Oct 2026 00:51:45 +0000
Subject: [PATCH v7 11/11] HID: spi-hid: add panel follower support
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
Message-Id: <20261024-send-upstream-v7-11-abad13174b43@chromium.org>
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
 Jingyuan Liang <jingyliang@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792803111; l=11772;
 i=jingyliang@chromium.org; s=20260213; h=from:subject:message-id;
 bh=e3ij+066MTVfQoi7WLCpfy4R9eesAGgsO8Poar1vtdg=;
 b=edM0iqMbeuZ/1pWFai3gqlgq3lhvJ/2O3I5IFIG/S9cQhbm4VS1V1iMzazJtxSlO88JaGlx+A
 lDWcT5c9ETWBEboow5IKOKdyhD/N49bKBG8b+F6Doc3SHpQpfOFZ6Qe
X-Developer-Key: i=jingyliang@chromium.org; a=ed25519;
 pk=VTYSdqslTtYOjWWoIGgYoWupGWqNSidrggReKMgfPo4=

Add support to spi-hid to be a panel follower.

Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
---
 drivers/hid/spi-hid/Kconfig        |   4 +
 drivers/hid/spi-hid/spi-hid-core.c | 221 ++++++++++++++++++++++++++++---------
 drivers/hid/spi-hid/spi-hid-core.h |   7 ++
 3 files changed, 177 insertions(+), 55 deletions(-)

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
index 3b8874ca0e1c..496b33cdf3d4 100644
--- a/drivers/hid/spi-hid/spi-hid-core.c
+++ b/drivers/hid/spi-hid/spi-hid-core.c
@@ -277,10 +277,13 @@ static int spi_hid_suspend(struct spi_hid *shid)
 			if (error) {
 				dev_err(dev, "%s failed to suspend hid driver: %d\n",
 					__func__, error);
-				enable_work(&shid->reset_work);
-				/* Redo a schedule_work() dropped while disabled. */
-				schedule_work(&shid->reset_work);
-				return error;
+				/* A follower powers off with the panel anyway. */
+				if (!shid->is_panel_follower) {
+					enable_work(&shid->reset_work);
+					/* Redo a schedule_work() dropped while disabled. */
+					schedule_work(&shid->reset_work);
+					return error;
+				}
 			}
 		}
 	}
@@ -325,28 +328,30 @@ static int spi_hid_resume(struct spi_hid *shid)
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
-				dev_err(dev, "%s: could not power up: %d\n", __func__, error);
-				/* Suspend runs next even if resume fails. */
-				enable_irq(shid->spi->irq);
-				return error;
-			}
-			shid->power_state = HIDSPI_ON;
-			reinit_completion(&shid->reset_done);
-			error = shid->ops->deassert_reset(shid->ops);
-			if (error)
-				dev_err(dev, "%s: failed to deassert reset: %d\n",
-					__func__, error);
-			else
-				was_reset = true;
+		error = shid->ops->power_up(shid->ops);
+		if (error) {
+			dev_err(dev, "%s: could not power up: %d\n", __func__, error);
+			/* Suspend runs next even if resume fails. */
+			enable_irq(shid->spi->irq);
+			return error;
 		}
+		shid->power_state = HIDSPI_ON;
+		reinit_completion(&shid->reset_done);
+		error = shid->ops->deassert_reset(shid->ops);
+		if (error)
+			dev_err(dev, "%s: failed to deassert reset: %d\n",
+				__func__, error);
+		else
+			was_reset = true;
 	}
 
 	enable_irq(shid->spi->irq);
@@ -1447,6 +1452,108 @@ static struct hid_ll_driver spi_hid_ll_driver = {
 	.raw_request = spi_hid_ll_raw_request,
 };
 
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
+		dev_err(dev, "%s: could not power up: %d\n", __func__, error);
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
@@ -1462,10 +1569,11 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		return -ENOMEM;
 
 	shid->spi = spi;
-	shid->power_state = HIDSPI_ON;
+	shid->power_state = HIDSPI_OFF;
 	shid->ops = ops;
 	shid->conf = conf;
 	set_bit(SPI_HID_RESET_PENDING, &shid->flags);
+	shid->is_panel_follower = drm_is_panel_follower(&spi->dev);
 
 	spi_set_drvdata(spi, shid);
 
@@ -1480,6 +1588,7 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 	init_completion(&shid->reset_done);
 
 	INIT_WORK(&shid->reset_work, spi_hid_reset_work);
+	INIT_WORK(&shid->panel_follower_work, spi_hid_panel_follower_work);
 
 	/*
 	 * we need to allocate the buffer without knowing the maximum
@@ -1490,20 +1599,6 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
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
@@ -1523,21 +1618,19 @@ int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
 		}
 	}
 
-	error = shid->ops->power_up(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: could not power up: %d\n", __func__, error);
-		return error;
-	}
-
-	error = shid->ops->deassert_reset(shid->ops);
-	if (error) {
-		dev_err(dev, "%s: failed to deassert reset: %d\n", __func__, error);
-		shid->ops->power_down(shid->ops);
-		return error;
+	if (shid->is_panel_follower) {
+		/* Like the IRQ: the first panel_prepared resume enables it. */
+		disable_work(&shid->reset_work);
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
 
@@ -1551,15 +1644,27 @@ void spi_hid_core_remove(struct spi_device *spi)
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
-		dev_err(dev, "failed to disable regulator: %d\n", error);
+	if (shid->power_state != HIDSPI_OFF) {
+		shid->ops->assert_reset(shid->ops);
+		error = shid->ops->power_down(shid->ops);
+		if (error)
+			dev_err(dev, "failed to disable regulator: %d\n", error);
+	}
 }
 EXPORT_SYMBOL_GPL(spi_hid_core_remove);
 
@@ -1567,6 +1672,9 @@ static int spi_hid_core_pm_suspend(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_suspend(shid);
 }
 
@@ -1574,6 +1682,9 @@ static int spi_hid_core_pm_resume(struct device *dev)
 {
 	struct spi_hid *shid = dev_get_drvdata(dev);
 
+	if (shid->is_panel_follower)
+		return 0;
+
 	return spi_hid_resume(shid);
 }
 
diff --git a/drivers/hid/spi-hid/spi-hid-core.h b/drivers/hid/spi-hid/spi-hid-core.h
index 060272353216..28e9880ad464 100644
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
2.56.0.257.gf7497c7d27-goog

