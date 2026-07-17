Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD796418A3A
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298991; cv=none; b=ll1UmvxDcSdS4FSXy4Uv8A+SP/KqOpLzG54tH1FFdAAbjHFf6uCy+R0bByU4Ddt1RqG7uurcJ4d5YuMlcQIgHcwiAEnnBSEGPnmcWde4W5JJjP2arUSSqhTA5lYO7iuPYPMqvAJeeSSohW0ViIojNIbzF+vlzticdK+Tru0ZMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298991; c=relaxed/simple;
	bh=ukKOayovYPz+N1uxirJ7SNW+NLgElUDsr8xtH0cDn80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8DEREKNmPjg2wIsqBs5ivMvX79pyOOZ+/Z10kpn+iIsrlstj5bCYlIbw1HfOMYyMQEqYxXeE+DoP6WDJIG2E5XAyifOtkSK6zehPLnUAIwKu7RydH5yp2VmcH6RXUGdm3Oc4U3iSB0ExHMdMD41oqOx28D4mHe4Ciw8dQ1BVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5zRdjzQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5zRdjzQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc61541f8cso17337885ad.0
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784298989; x=1784903789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zsezRzUgH4CnJUtyPPiS7O3QQiFIeq4/udW8yu2mReo=;
        b=f5zRdjzQ9+NF9jTVuLOGUBLYuTEAURMCj58uEvgHtFFNPTiXyOJiXN7e68nDy5jPPk
         J2iUo2F7b/gJ/fPLmHyFheekwtv3wF88qurlxE9LqImZgu8vo4BIDz+7rhA4zYjyzGjJ
         V3DRYwCu3PPNuB+BNQ8JLyjStt8LcrZJ2/jyd2U0E0RWhal+dhh9mf7Um10QtSLEXOmU
         P/AXlAcYMoLq3rzmvrJ/yQ4ZLoXwuO+6Iu4C5yylbsVyt4f7BT55/mpYn2Nfn+QA71l2
         +UzK6ZFxbT5mq7dva//iH9W30rzZOyJaSsZk3mBNc4VriKgkMQn/AE2oyE3o3iZA8MWs
         3pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784298989; x=1784903789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zsezRzUgH4CnJUtyPPiS7O3QQiFIeq4/udW8yu2mReo=;
        b=fl9wp0x9jpSru2xt9oCXWBpm77b3mwAKd2yaMAP/d7k3nQpqgCcUqd+y9Zgyv5DkiV
         CFzHiVnMX7V9nyA069PM9wyLxhZgUihAIaTOc9ScmHGlsZPumttPGX2eYiZtFrjjlsw9
         UwapjAMgpFLwqAs6WYjDWlfmsv2jYD3OG5aTbszBSD//0gpoG43Crp6/Eyno4B0+1DC7
         1mSQaj6HaJShM0wkTBQ864ZCf94AknQ9jQv5A0SEv4I0pwVvFC/dPdRThcS5syNvciEt
         x9QBfGE4cpyWTI8IR3y3lZmC1DVbiUh7FOH02/wwlMJp4OrBj0H1nsqJIHvoOHEmpo8n
         KN/A==
X-Gm-Message-State: AOJu0Yz6p1FusXA29wBfuuu5fvHknVIAqIPCijeUnf6RWSR2Z2YMgb7H
	VEdQfDW81tUrK619zc+ywy7wjSqPMK85AXKFAFY+k9UaYYO4UdjV1pw=
X-Gm-Gg: AfdE7clbSb+HCwScjmpDfcTYpwiGSogUhwKRZCvSblD8UZ2VFXKdgoFPwtVI75kDU7B
	K/xZtBK9UYOKA9LB5XaNke0L5F1JKLjlvxcH5ffwFVUmqTj7OG0MZ0TCbJcVz2eL+SaYzdt4gar
	HPpFhfZu+NwlyVcArz8AqdqQi2tuR1M9b+usJ3EU01BQ26gQalVcpC4yGXYFYS6HICoArtJa+NG
	TKNDYAUImVtR/izfmb2EA2lhPm6+S5zp02ppaG/WTZB+KfBXJ8lDbNrYJz3KKIt/MbJRFK4rYeY
	qfLab874uwF34bq8+uQ3ullzEkzIw3HfW/FDxGFpr1GR9fWBmxRZzzWz4BfNTnjkB+j8YkE6W9G
	jCNqLfFTuIT7eqoiUP5OqpveblzkWzU2aVQkSDpQQIZ1Cnhfo0KEKbzV6h1BLbmscn9nHHGN6uh
	Ooc1frja7JnflSIaRiMs2mtVhwSng5HmvMVq/tB0xUaMTFWQRv0AuUKHtP+FgFHHS1yk5+a8MrB
	sOxdiPfRWp1sQ==
X-Received: by 2002:a17:902:fc43:b0:2cf:41ba:96c2 with SMTP id d9443c01a7336-2cf41bab3cdmr1005375ad.12.1784298988850;
        Fri, 17 Jul 2026 07:36:28 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346d9bd5sm12145695ad.45.2026.07.17.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:36:28 -0700 (PDT)
From: "Shih-Yuan Lee (FourDollars)" <fourdollars@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Fri, 17 Jul 2026 22:36:16 +0800
Message-Id: <20260717143616.4765-3-fourdollars@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260717143616.4765-1-fourdollars@gmail.com>
References: <20260712162420.7453-1-fourdollars%40debian.org>
 <20260717143616.4765-1-fourdollars@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shih-Yuan Lee <fourdollars@debian.org>

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
 drivers/spi/spi-pxa2xx.c | 88 +++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f9dde4b28c32..6e554911c076 100644
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
@@ -1488,16 +1493,38 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
 
 	pxa_ssp_disable(ssp);
 
-	if (!pm_runtime_suspended(dev))
-		clk_disable_unprepare(ssp->clk);
+	if (is_lpss_ssp(drv_data)) {
+		unsigned int i;
 
-	return 0;
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
+	clk_disable_unprepare(ssp->clk);
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1507,14 +1534,53 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
-		if (status)
-			return status;
-	}
+	status = clk_prepare_enable(ssp->clk);
+	if (status)
+		return status;
+
+	if (is_lpss_ssp(drv_data)) {
+		unsigned int i;
 
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
 	/* Start the queue running */
-	return spi_controller_resume(drv_data->controller);
+	status = spi_controller_resume(drv_data->controller);
+	if (status) {
+		clk_disable_unprepare(ssp->clk);
+		return status;
+	}
+
+	/* Let runtime PM autosuspend again if needed */
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static int pxa2xx_spi_runtime_suspend(struct device *dev)
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 447be0369384..fce776e2404c 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -71,6 +71,7 @@ struct driver_data {
 	irqreturn_t (*transfer_handler)(struct driver_data *drv_data);
 
 	void __iomem *lpss_base;
+	u32 lpss_priv_ctx[6];
 
 	/* Optional slave FIFO ready signal */
 	struct gpio_desc *gpiod_ready;
-- 
2.39.5

