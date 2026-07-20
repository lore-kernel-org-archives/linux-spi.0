Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A93DDAFB
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544053; cv=none; b=dV5cN7uyikr7VwP6+DLusgmAYI5RBFvCLOmZF3oYVLmjvgAoxIeMtbr4bIg8uhBegNdYrZ3TGj2syCV4ES4jm8jj6laemYsrYHGaxDybHC5cGE43JrtHYnjWmjKuXrN89Zu2pwmSw8Iw4gZyPbwkH/Az2wcKoIZUgfFP+ompciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544053; c=relaxed/simple;
	bh=3g+3xi7SKONTJUBylpqN2msZG7y/rNb3leszdhJKwh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHWhYg4F/PHmJpA30MxqAQZOHyw5uzr+REpakHJSb5MubvTHguul54j4TNv/wxR3CNFu30Ufbi9GdE+c59/SnjQZkGWAL2uxTcU7rShrz83nn/M3RhlVoQPDXmZt2jNf+bLd2d7+dfSCx87TqSFNczl4CrL37oxe/AutiGU1+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cad8076b01so119826705ad.2
        for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 03:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544049; x=1785148849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4fOErW4W0huqYOzMta6lrgtyUPK1eaYnpCDX3YPECv0=;
        b=Tcq3NrsdBIotuegqSYL1gYPKYDcjTcIbW1LO+6Jc5L36vJ4gAXen0PvQe9W4thKbKB
         LS7M2JFHehPhJAdlKbSuqklNMuhN5TvMaSPezcuL+DXY8/mivTfr+BFkphkiy2b0ADte
         wB5HKGWQHQfkcEof9+wFfU94PjrfQSoxwDFEdufaBck6T9OF0elXhoKmuBEGny4ZGsWs
         o8tMFba53pjBbUplKw85Ap5JfLXm72o6TkTZ4SbDltLr9pZtoelGnfS77QOcdq+vgMH7
         gvlYBHrWx/z4JYLVhwkqNwUlpj1iR7RW9eXQya5vieF9cIbpdh5Q9pQ72FhzDGxrJpZm
         2J/g==
X-Forwarded-Encrypted: i=1; AHgh+RpvOOqR2oWPyLXUYl3ghN1NPdtTWAy9U68r1SUxMfVjPSvKamfxPkM/meq5ed6H63PFmU/8tZO9kAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoF2G/C/COyUz9VtkG6VRFdfr8ki1cpSaVO2TkeNAz99sbH67
	kbI4saas4fCN0NgswUD0m5ghRbhkTiUaJKLX57/Uqi24eIxqu0Dk6N4=
X-Gm-Gg: AfdE7cnHZ5e4q9yJeOS1cTdBle7c2iSr+3/DrvQ3dGUt7RuvK+W2DsnKebHQpkC2y6x
	E6k2Lx0xKhiwHaPTT5wjo1Quu5L1oA9pPUrRzUiKgw8SswXtvnEXDR/a2FrBuGr8bgPqCGWUCHc
	VHpCux/i9rwmXfh8gJn730mVaMrj9ARhdLjObZ0VV2qr/3MfTn+xCMmpn2pc76RCnC29pXzl2y3
	vEdtN3q1fLGrGpmROmbMqRJXbppp/wfhkTexfQR0meDQJuFxTtYYJWqp6I69C8CJmKUIh1KcHqS
	gMMLTji++KQXWQRmRnmIpYq8VIkiLRjqalBZPyeBcMfpy/6l5LVYo7DO6Z5dnmHNIdhfaL4rYp+
	893lGW6gOJtYZZAOyyL2n41TwvwlE9QAdTfHJgd65jtw56MkBLU+3lIsoJqSzgkdLjMAZr2xGdx
	XV83Z5bQYCOgAghzUkGxQ0GmSVPatYhwthtUf96fGr7T0NtSmYd2iniJCdjfuiU7uadnUIX5b5K
	Cf2n+h7xrL9IUMW0w==
X-Received: by 2002:a17:902:f688:b0:2ca:5d24:720b with SMTP id d9443c01a7336-2cf349caff7mr152740295ad.39.1784544048693;
        Mon, 20 Jul 2026 03:40:48 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf344f61ffsm54900325ad.33.2026.07.20.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:40:48 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v15 6/7] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Mon, 20 Jul 2026 18:40:28 +0800
Message-Id: <20260720104029.13740-7-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720104029.13740-1-fourdollars@debian.org>
References: <20260720104029.13740-1-fourdollars@debian.org>
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
  pm_runtime_put_autosuspend() to guarantee active clocks during MMIO
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108331
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 95 ++++++++++++++++++++++++++++++++++++++--
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 88ed28096b07..56e434f6e794 100644
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
@@ -1527,17 +1544,45 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
+	status = pm_runtime_resume_and_get(dev);
+	if (status < 0)
+		return status;
+
 	status = spi_controller_suspend(drv_data->controller);
 	if (status)
-		return status;
+		goto out_put;
 
+	/* Disable SSP interrupt generation on hardware level while clock is active */
 	pxa2xx_spi_off(drv_data);
+
+	/* Mark as suspended and synchronize IRQ before disabling clock */
 	drv_data->suspended = true;
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
@@ -1550,9 +1595,47 @@ static int pxa2xx_spi_resume(struct device *dev)
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
@@ -1561,10 +1644,14 @@ static int pxa2xx_spi_resume(struct device *dev)
 		drv_data->suspended = true;
 		synchronize_irq(ssp->irq);
 		pxa2xx_spi_clk_disable(drv_data);
-		return status;
+		goto out_put;
 	}
 
-	return 0;
+out_put:
+	if (!pm_runtime_suspended(dev))
+		pm_runtime_put_noidle(dev);
+
+	return status;
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

