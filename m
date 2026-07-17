Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37F42BEBB
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306264; cv=none; b=dw9XQgdBRTZTFyL/7hUncTbebBwJxymErHIenEakVy+Fg3a1gFou7fCO5/b91FbLjw6J01L7gWtfrtnu/ZyG7yCHeQQGGp+cLZbwzVb0pdfeoOgFLOztX4qlDujwuk4EUqev1XsiC1ctSUvV190s1jRWp07IM5a5s0aCM1eOvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306264; c=relaxed/simple;
	bh=4Cplk9Wyfwie8eEhkHpkoxFOURxnvpRi/wnr1nMvh2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DC6zHeEiRhuXRU6v76ME/DBpUugkDCoGh0EBOcnzmiD4JndAEJXDESr6h4YbzVraNOqcusn6ff+1wbnRP03DAwgBSEcbK9nD9AOhtR7qEQckaG11Esd33PKRmXi2YbsNYDce8tgmWrXUkTCLh5RY+W0QQKUjjGU8WToR2KpvY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8487088510aso8315372b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 09:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784306262; x=1784911062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F9cHWXZxT3AOb0TsNm1pwNj/aI5kZG+WJPp72xJRVno=;
        b=Gj+KfA/7ljvsFZ81m7bxw2I7o2OL2VpSD43Ar3SRB1g036p+EiRPRWHrod+H3bddFD
         jw8xBCcDuKwM0prcNCk5S2cCh/xIj/Kb0VHFze1DxOQqKNsh/3HnI/Dpo70Q4wiyIkAP
         5X7JK07YD+e9cjKivWS01OPRLhgB+lZeQ1+iXwkeVVbCgk/ie1NfQp4SeMI3nncGnmYH
         Dg4xZo/OG24fUzOs5c1+en3dg2ZQ2A/PKOaGK3odpOooZKucGdWXyEB95NqS/RqttBJb
         RT9lMxtvFUC2DJkaxGhSHOUvQuKHN/9XQZ1jyKN10euSBERuC/64vJfbZCtmto7k5MzJ
         +ddA==
X-Gm-Message-State: AOJu0Yy0d6joNS83TiFm6xnxgP8g1zdP2RZNyHYW0hXeUOTDsiUowPwJ
	tn+wy+LwRCVkOUJgVhydjQN8vM0wDJFSwladfAKXJ+WmHbbmBZrOotU=
X-Gm-Gg: AfdE7cmDMV0Ecuf0cBD4uIH5fes4FLvwDcp+/homzvSW3+wckA6yodYsXjZ6RMJQ76D
	1YluDOXshd6JNRlbjxoNGguZeVE2PD5lSMLNU6rQodkha5o4AVZ24XrNwIDf5ZJUDg9Nc9cHlwv
	XGOw1gRTR8e7Z1DdJobaHNFnoiFhWirny7yKpu1rLoOGkksR9BR2GTj07EoeW2hvtECL3UtL4BO
	Q238moXWMTl64xKeNJvEy5iaJmGcTEkp+p8GjhPPzZxH0NN+qD8BtEOE1XSvwH9CzZp5bn8VpQA
	nDgcDmKlKhtMaYcBd8m/Dn960482MPiWMby/Mf7oqdH91mEoiGY//SbraIobkl6pUhhzqwEOoBj
	37Q5jiLS3gRUAU+d7AOzAbKHRoViHO9F5ae6/a8qx1+7Q1gAz+npuhJfBISRFr+j5YL4Ffm2lWt
	M3ZQ1W1McHYVAe/nc82Wz+Bf4bwHLR+81ceRiDo3Frm8i+wz5mtgp5S/87J83SESjt6flu4QAW7
	Pny9bmhwSITPs8=
X-Received: by 2002:a05:6a00:1d9c:b0:848:2f73:9001 with SMTP id d2e1a72fcca58-84c295484c5mr3845739b3a.74.1784306261667;
        Fri, 17 Jul 2026 09:37:41 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad8b86dsm1441669b3a.8.2026.07.17.09.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:37:41 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v4 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Sat, 18 Jul 2026 00:37:31 +0800
Message-Id: <20260717163731.6782-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260717163731.6782-1-fourdollars@debian.org>
References: <20260712162420.7453-1-fourdollars@debian.org>
 <20260717163731.6782-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel LPSS SPI controllers lose all private register state across S3
suspend because the LPSS power domain is fully removed.  On resume the
driver only re-enables the SSP clock, leaving the LPSS private registers
in their power-on-reset state, which causes two problems:

1. LPSS_PRIV_RESETS (offset 0x04 within the LPSS private space) stays
   zero, keeping the functional block in reset.  Any MMIO access while
   the block is held in reset causes a PCIe Completion Timeout and a
   watchdog-triggered system reset.  LPSS_PRIV_RESETS_FUNC and
   LPSS_PRIV_RESETS_IDMA must be de-asserted before any other register
   access on resume.

2. The LPSS software chip-select control register must not be blindly
   restored from its suspend-time snapshot: if CS was asserted at the
   moment of suspend, restoring that state corrupts the first
   post-resume SPI transaction.  Instead, call lpss_ssp_setup() which
   unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
   the state established at probe time.

To resolve these issues safely:
- Wrap S3 suspend/resume with pm_runtime_resume_and_get() and
  pm_runtime_put_autosuspend() respectively.  This ensures that if the
  device was runtime-suspended, it is temporarily resumed to active state
  prior to suspend.  This guarantees that the clock and power domain are
  active during MMIO register access, and that the private registers are
  consistently saved and restored across S3 sleep cycles.
- On S3 suspend success path, return 0 directly without dropping the PM
  reference.  This preserves the acquired PM reference across suspend.
  On S3 resume, release it via pm_runtime_put_autosuspend(), and ensure
  all error paths in resume (clock enable failure or spi_controller_resume
  failure) jump to out_put to correctly release the reference, preventing
  reference count underflow and leaks.
- Save only the first 6 LPSS private registers (offsets 0x00 to 0x14)
  via drv_data->lpss_base during suspend.  Offsets beyond 0x14 (except
  CS control at 0x18, which is re-initialised by lpss_ssp_setup()) are
  reserved/unimplemented on LPT platforms (such as MacBook8,1), and
  writing to them triggers a PCIe Completion Timeout causing a system
  freeze.
- Store the saved context in drv_data->lpss_priv_ctx[6] (inside struct
  driver_data) which is private to the core driver.  This avoids changing
  the layout of struct pxa2xx_spi_controller, preventing ABI symbol
  version mismatches with uncompiled platform drivers (e.g.,
  spi-pxa2xx-platform.ko).

On resume, de-assert resets first, restore all other saved registers,
then call lpss_ssp_setup() to re-initialise CS.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 90 +++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index dcae43a04eac..c4b4cb49cfc0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -72,7 +72,12 @@ struct chip_data {
 #define LPSS_CAPS_CS_EN_SHIFT			9
 #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
 
-#define LPSS_PRIV_CLOCK_GATE 0x38
+/* Offsets from drv_data->lpss_base */
+#define LPSS_PRIV_RESETS			0x04
+#define LPSS_PRIV_RESETS_IDMA			BIT(2)
+#define LPSS_PRIV_RESETS_FUNC			0x3
+
+#define LPSS_PRIV_CLOCK_GATE			0x38
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_MASK	0x3
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_ON	0x3
 #define LPSS_PRIV_CLOCK_GATE_CLK_CTL_FORCE_OFF	0x0
@@ -1533,19 +1538,43 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
 
+	/* Mark as suspended and synchronize IRQ before disabling clock */
 	drv_data->suspended = true;
 	synchronize_irq(ssp->irq);
 
 	pxa_ssp_disable(ssp);
 
-	if (!pm_runtime_suspended(dev))
-		pxa2xx_spi_clk_disable(drv_data);
+	if (is_lpss_ssp(drv_data)) {
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
 
+	pxa2xx_spi_clk_disable(drv_data);
 	return 0;
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1555,16 +1584,57 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev)) {
-		status = pxa2xx_spi_clk_enable(drv_data);
-		if (status)
-			return status;
-	}
+	status = pxa2xx_spi_clk_enable(drv_data);
+	if (status)
+		goto out_put;
 
 	drv_data->suspended = false;
 
+	if (is_lpss_ssp(drv_data)) {
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
+
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
 	/* Start the queue running */
-	return spi_controller_resume(drv_data->controller);
+	status = spi_controller_resume(drv_data->controller);
+	if (status) {
+		pxa2xx_spi_clk_disable(drv_data);
+		goto out_put;
+	}
+
+out_put:
+	/* Let runtime PM autosuspend again if needed */
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
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

