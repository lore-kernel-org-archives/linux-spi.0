Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9043E093
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564505; cv=none; b=oAIF1uLreGZFYbByACoaw710qnhaYIg86ueQSP4YhCwGXJ+aJqdCk/oYg7LJrKsjl6zBHcTLgsdxKk7lvXG6pjK5z2pvnqyH7cBlMezPHbsEMhRdOq1lAE4xPNcrbBAc0pVOS2GEUsSxmmP1BzuwdvwHAO6KtmO07PwfdfwqHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564505; c=relaxed/simple;
	bh=iS7PVNN5Owebkj5FvDrN/m+SHqVNAdifSioUypixLtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WK/n/9saOkIROaKZZzAr3IrqkpG0PcJBINIPF9ZCYFtnnBu045f56a5SJ2X2ZWVI3tUKqvSexyPkjfM15wct4h+CPVfpdO+8SbJ7Tax3UediKUPL8QRH5PmKlXX20cJe68q+Lo5886AD+PU9k76gQ8O03NlHSLh6HZy5d9atB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caed617615so114027135ad.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 09:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784564499; x=1785169299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=agggjMeWOCHZp5peunlNPyTIEns3XzYOIFzREAaYZuY=;
        b=P61ZtaLPkWECWzHg4z4uyZBznH00m/+3wav4MqSztQ2+Akq5epvFJFPrhgXwy0WMM8
         mAVqx2L0mLYHGfrBWZd2AQXD31png7Ezfa6NFgnssVLKwa2dai5Os+h4mxBPf0DAahkf
         IjVd4b2PTX3KrSj9+SuescYz/S8G2wp7lfxeOrQ3Kn+tUq/QUgUjd82Ts8q2EogsDj9w
         ARGpWyiZPg/mFO3FQ/cIM7NGMyIHP1sdzZryZn/ZbFSyFjfoosoi3N5tFv0UYszMhJS1
         5zQfoFm3iDuED+FfBTZhUMLAcJ75KOWFgi0+30ko053PIRFDACZKH+NMxsEg9rg+9Cxp
         iFTw==
X-Forwarded-Encrypted: i=1; AHgh+RqqVR5yNVxFr0BURsWItpVhnaNVJHREu3S4ggRU1cIxYnZhQ3VXQS0KU7qBCG8hG1bHUnSRDf1UdxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAtgbKXojisXEaPG2B4RNSEUvOUGvBbmGz8UId225oCfK7UmS3
	1kt7wUoPKyAs5GEeW7Sk/UnRCBNRB1yI0NBIEfoHeXu97u9xN8j0148=
X-Gm-Gg: AR+sD1085B00Pn6LTBGzCuiOT81XJT0COiIfUbag2kl9qefXRkFLRBCVL2cUDOQmFUB
	CVqJvy/XsK9FKd3Mntu1Bkc3On8Z/njwFfbS2l0QltG6Eqmzp9y6QW8CzamvdiYHiXbAgBNy7O7
	/KFGssDX3vrujnQyNXkNCGGDySaJLRRWES7FbfIzOh/lk7ncIwUPh6Hxbw8qITkswCpQOlpkcSV
	MzthB0aN8MQJokZu/lYaeQXSOED+LLnmyWhgsji8b5GMsRjKSuCVWcoRk+gVuHu4neZ5oRp6WFP
	aiZZhgzYGepro12wEutKdtRFUGpt95ehrcSVWDsdcWj8SpnSE0oJ2xTxpu4qpjMTltFAlu1MN/9
	HqIRuQR75VX97JQ2Sem+5QbQNvGSjxuhbmpaglQcGPnpeqicQw8K0Lw3e7+rYtaauGypfKDYtKf
	LzJFft3src7ibMhKBARHBdZzoEzYEy3XYYIC+QaEGwGBp7wuO0Q5JiIH7pYl9avSU10+8NTpBRS
	HeAK7WAY8J/0YNQxzuOBSsD6aUS
X-Received: by 2002:a17:903:2c05:b0:2ca:ec6f:aeca with SMTP id d9443c01a7336-2cf3481b670mr163970705ad.8.1784564498470;
        Mon, 20 Jul 2026 09:21:38 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3479463bsm58467385ad.80.2026.07.20.09.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:21:38 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v16 6/7] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Tue, 21 Jul 2026 00:21:15 +0800
Message-Id: <20260720162117.32304-7-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720162117.32304-1-fourdollars@debian.org>
References: <20260720162117.32304-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel LPSS SPI controllers lose all private register state across S3
suspend because the LPSS power domain is fully removed. On resume the
driver only re-enables the SSP clock, leaving the LPSS private registers
in their power-on-reset state, which causes two problems:

1. LPSS_PRIV_RESETS (offset 0x04 within the LPSS private space) stays
   zero, keeping the functional block in reset. Any MMIO access while
   the block is held in reset causes a PCIe Completion Timeout and a
   watchdog-triggered system reset. LPSS_PRIV_RESETS_FUNC and
   LPSS_PRIV_RESETS_IDMA must be de-asserted before any other register
   access on resume.

2. The LPSS software chip-select control register must not be blindly
   restored from its suspend-time snapshot: if CS was asserted at the
   moment of suspend, restoring that state corrupts the first
   post-resume SPI transaction. Instead, call lpss_ssp_setup() which
   unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
   the state established at probe time.

To resolve these issues safely:
- Wrap S3 suspend/resume with pm_runtime_resume_and_get() and
  pm_runtime_put_noidle() to guarantee active clocks during MMIO
  access and preserve PM reference counting.
- Restrict LPSS private register save/restore to LPT, BYT, and BSW
  platforms via pxa2xx_spi_need_lpss_restore() (newer platforms are
  handled by intel-lpss.c).
- Save only the first 6 LPSS private registers (offsets 0x00..0x14) in
  drv_data during suspend, avoiding reserved offsets beyond 0x14.
- On resume, de-assert resets first, restore saved registers, call
  lpss_ssp_setup(), and clear drv_data->suspended to prevent unclocked
  IRQ access.
- Add error recovery paths for spi_controller_suspend/resume failures.
- On the resume error path, call pm_runtime_set_suspended() before
  pm_runtime_put_noidle() to align the PM runtime state with the
  already-disabled hardware clock, preventing pxa2xx_spi_runtime_suspend()
  from attempting unclocked MMIO via pxa2xx_spi_off().

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 105 +++++++++++++++++++++++++++++++++++++--
 drivers/spi/spi-pxa2xx.h |   1 +
 2 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 34241a6742eb..851626ead25e 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -72,6 +72,11 @@ struct chip_data {
 #define LPSS_CAPS_CS_EN_SHIFT			9
 #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
 
+/* Offsets from drv_data->lpss_base */
+#define LPSS_PRIV_RESETS			0x04
+#define LPSS_PRIV_RESETS_IDMA			BIT(2)
+#define LPSS_PRIV_RESETS_FUNC			0x3
+
 #define LPSS_PRIV_CLOCK_GATE 0x38
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK	0x3
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON	0x3
@@ -189,6 +194,18 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
 	}
 }
 
+static bool pxa2xx_spi_need_lpss_restore(const struct driver_data *drv_data)
+{
+	switch (drv_data->ssp_type) {
+	case LPSS_LPT_SSP:
+	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
 {
 	return drv_data->ssp_type == QUARK_X1000_SSP;
@@ -1532,17 +1549,44 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
+	status = pm_runtime_resume_and_get(dev);
+	if (status < 0)
+		return status;
+
+
 	status = spi_controller_suspend(drv_data->controller);
 	if (status)
-		return status;
+		goto out_put;
 
+	/* Disable SSP interrupt generation on hardware level while clock is active */
 	drv_data->suspended = true;
 	pxa2xx_spi_off(drv_data);
 	synchronize_irq(ssp->irq);
 
+	if (pxa2xx_spi_need_lpss_restore(drv_data)) {
+		unsigned int i;
+
+		/*
+		 * Save the first 6 LPSS private registers (offsets 0x00 to 0x14)
+		 * while the clock is still enabled.  They are lost when the LPSS
+		 * power domain is removed across S3 and must be restored on resume.
+		 * Use drv_data->lpss_base so the correct per-platform offset
+		 * is applied regardless of LPSS IP revision.
+		 * Registers beyond 0x14 (except CS control at 0x18) are reserved
+		 * or unimplemented on LPT, and accessing them triggers a PCIe
+		 * Completion Timeout causing a system halt.
+		 */
+		for (i = 0; i < 6; i++)
+			drv_data->lpss_priv_ctx[i] = readl(drv_data->lpss_base + i * 4);
+	}
+
 	pxa2xx_spi_clk_disable(drv_data);
 
 	return 0;
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1555,9 +1599,47 @@ static int pxa2xx_spi_resume(struct device *dev)
 	if (!pm_runtime_suspended(dev)) {
 		status = pxa2xx_spi_clk_enable(drv_data);
 		if (status)
-			return status;
+			goto out_put;
 	}
 
+	if (pxa2xx_spi_need_lpss_restore(drv_data)) {
+		unsigned int i;
+
+		/*
+		 * The LPSS power domain is removed across S3, taking
+		 * all private registers with it.  De-assert the
+		 * functional block and IDMA resets first; any MMIO
+		 * access while the block is held in reset causes a
+		 * PCIe Completion Timeout and a watchdog-triggered
+		 * system reset.
+		 */
+		writel(LPSS_PRIV_RESETS_FUNC | LPSS_PRIV_RESETS_IDMA,
+		       drv_data->lpss_base + LPSS_PRIV_RESETS);
+
+		/* Restore the other 5 saved private registers */
+		for (i = 0; i < 6; i++) {
+			if (i == LPSS_PRIV_RESETS / 4)
+				continue;
+			writel(drv_data->lpss_priv_ctx[i],
+			       drv_data->lpss_base + i * 4);
+		}
+	}
+
+	if (is_lpss_ssp(drv_data)) {
+		/*
+		 * Re-initialise the SW chip-select control register so
+		 * CS starts deasserted (SW_MODE | CS_HIGH), regardless
+		 * of the state it was in at suspend time.  A stale
+		 * asserted CS on the first post-resume transaction
+		 * corrupts the write-status response from the device.
+		 */
+		lpss_ssp_setup(drv_data);
+	}
+
+	/*
+	 * Now that resets are de-asserted and registers are restored,
+	 * it is safe to handle interrupts.
+	 */
 	drv_data->suspended = false;
 
 	/* Start the queue running */
@@ -1566,10 +1648,25 @@ static int pxa2xx_spi_resume(struct device *dev)
 		drv_data->suspended = true;
 		synchronize_irq(ssp->irq);
 		pxa2xx_spi_clk_disable(drv_data);
-		return status;
+		goto out_put;
 	}
 
-	return 0;
+out_put:
+	if (!pm_runtime_suspended(dev)) {
+		if (status)
+			/*
+			 * Clock is already disabled on the error path; align
+			 * the PM runtime state with hardware reality before
+			 * releasing the reference so the PM core does not
+			 * later invoke pxa2xx_spi_runtime_suspend() and attempt
+			 * unclocked MMIO via pxa2xx_spi_off().
+			 */
+			pm_runtime_set_suspended(dev);
+		pm_runtime_put_noidle(dev);
+	}
+
+	return status;
+
 }
 
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 44f37bf9c519..48169494f74e 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -71,6 +71,7 @@ struct driver_data {
 	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
 
 	void __iomem *lpss_base;
+	u32 lpss_priv_ctx[6];
 
 	bool suspended;
 	bool clk_enabled;
-- 
2.39.5

