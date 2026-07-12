Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD535677D
	for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783873518; cv=none; b=UfC0WFBA+xFoKmC/S4RUDmhoCevunj6V0kwppr/KE9mrO9Xs9OE5K74VQyJ1ifJTDqpJyfbp9VIRku60H7y6djORGxdA5bj/f8m1IMQhfIrJNPDFS26gUvkmeOxtAbGxLMSBHsK9iBSPMX2+u5c5QLFzvB1M6PHE6kKaWJJBk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783873518; c=relaxed/simple;
	bh=6QMkztKg+4In+ZoyTx9Z3AjZ4U9YrzL0eHDHOYHqlGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bA7dtT0wAJTYV4UUU7Tp5y1ZgMNOhenuPvyAOVWP0FL3s3oBmfXXgKppeuO2JDfFIlEAIybfKrun/ujHNl0GU2dFd+qz2fObFsnaRLvhMA7nJwXJe2v93fjsjtBPir2vW9cDh+3KQaun4PK2NQ34GomEd3I1bCyVLSG29PHuzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1243986a12.3
        for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 09:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783873517; x=1784478317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uf6ucJ+N+sR3tVW7KXXVAlwY/gD/+yR1WlVp6MFS6uA=;
        b=FImFWWnhZK2g3qMjur1QyquVD0UOAzT9kC4GLNmMHzp3HGl+qxhhPTk6u3YJnwqtUy
         D2D/CB/OCpzzHFW5RWkKnj4TwSgcN8BmnxrE/wbs2eJnCfVQy0bufeN0Lx3ZLuy48XqE
         AnvTkDRJPUvK8peTHxLrNY9mS456m+LFkiOudjiRCAe8sDQK+fDehQoWSMvYdk+KwFUg
         FSuvqgfXGZJLxV6G6a1lBkxVsNMtbdOAYewhOq5fnZc43a+2naR5JymAuARRVcFjXb3k
         W6Vb6FXhDF7StiGuw556ffMuLidapRD14dfRwi2aG0yMEUd/g0+QZcUIYIRGh665nc0y
         16nA==
X-Gm-Message-State: AOJu0Yw2z1TMx/cy0+Mh4gii/ZadPaSXi8eR4dIkmktxvA/dL8EjTneK
	eVqP0NQQqViOCB6XbJhTOPB0tFsbeDKQqZ0xpJZWsUk42/WKZ/hGeK4=
X-Gm-Gg: AfdE7clN9QuBdu7eVcUxmITYYI+DHCVatHixxwBjyIsvEI+86O2wlme4Se+dWbfHaAU
	byLrTqrXeXDVOkYQwJHnXMLoTQI6vnwWwQ5egiJ1Cu2nuwkeW3iD+gXN2Ijtl4FYKQdZe9qSJBk
	dqBRvgwCirm9i/hVN0c0+vdGUEKC0kxUr0fcBr2zb9RM82FAS+uet190b3pbv09Y6dncEeyS+es
	N9qwtQM9FsV18LITdCrrIzBv09pnt81glymZ8fNl+NT2y099icvApfgOegoiMzK9uUD2AuAJJJN
	Lsi/ZZNHTEttWIyyHUK/k47bTuNb/Lv1bYgnJEGzbOFX8pnjp4cPdDVDM88JMHMZkLK5lxpybFL
	McK4u3Dsfh7u/GWmt3hqR+c2TqZLw123Uq2FCKSWHitRKB/cJv6HnKkqlI1wiANl9/1vxdB7cX9
	gDYnJ6mEir/1V0SD3WctbWdn0h4NWSSHk8cseikkdUBX6M8BZT0FMgHnUE4RYJBLJukCUIIP1mT
	4fyST/xKas7RSCOWIwQ+JvNgkw9
X-Received: by 2002:a05:6a20:c784:b0:3b3:216b:274c with SMTP id adf61e73a8af0-3c1108c0142mr6085705637.22.1783873516686;
        Sun, 12 Jul 2026 09:25:16 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b93ae3b45sm12329887c88.15.2026.07.12.09.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:25:16 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH 2/2] spi: pxa2xx: restore LPSS private and IDMA registers on S3 resume
Date: Mon, 13 Jul 2026 00:24:20 +0800
Message-Id: <20260712162420.7453-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260712162420.7453-1-fourdollars@debian.org>
References: <20260712162420.7453-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel LPSS SPI controllers lose all private register state across S3
suspend because the LPSS power domain is fully removed.  On resume the
driver only re-enables the SSP clock but leaves the LPSS private
registers (BAR0 0x200-0x2ff) and the IDMA registers (0x800-0x814) in
their power-on-reset state, which causes two separate problems:

1. LPSS_PRIV_RESETS (0x204) stays zero, keeping the functional block
   and IDMA in reset.  Writing 7 to de-assert both resets before any
   register access is mandatory; accessing MMIO while in reset causes a
   PCIe Completion Timeout and a watchdog-triggered system reset.

2. The IDMA block shares the SPI interrupt line.  With its registers
   zeroed the IDMA asserts a spurious interrupt that masks the real SPI
   interrupt, causing every subsequent SPI transfer to time out (-110).

3. The LPSS software chip-select control register (0x224) must *not* be
   blindly restored from its suspend-time snapshot: if CS was asserted
   at the moment of suspend, restoring that state corrupts the first
   post-resume SPI transaction.  Instead, call lpss_ssp_setup() which
   unconditionally writes SW_MODE | CS_HIGH (idle/deasserted), matching
   the state established at probe time.

Fix all three issues by:
  - Saving the four LPSS clock/LTR/SSP private registers and six IDMA
    registers in pxa2xx_spi_suspend().
  - In pxa2xx_spi_resume(), writing LPSS_PRIV_RESETS first, then
    restoring the saved private registers (excluding 0x204 and 0x224),
    then calling lpss_ssp_setup() to re-initialise CS to idle-high,
    and finally restoring the IDMA registers.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx.c | 57 ++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-pxa2xx.h |  4 +++
 2 files changed, 61 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6291d7c2e06f..e8a83c818328 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1479,12 +1479,35 @@ void pxa2xx_spi_remove(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(pxa2xx_spi_remove, "SPI_PXA2xx");
 
+/*
+ * LPSS private registers to save across S3 suspend.
+ * NOTE: 0x224 (CS control) is intentionally excluded - it is re-initialised
+ * by lpss_ssp_setup() on resume to ensure CS starts deasserted (idle-high).
+ */
+static const unsigned int lpss_saved_regs[] = {
+	0x200,
+	0x204,
+	0x220,
+	0x238,
+};
+
 static int pxa2xx_spi_suspend(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
 	struct ssp_device *ssp = drv_data->ssp;
 	int status;
 
+	if (is_lpss_ssp(drv_data) && !pm_runtime_suspended(dev)) {
+		struct pxa2xx_spi_controller *pdata = drv_data->controller_info;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(lpss_saved_regs); i++)
+			pdata->lpss_priv_ctx[i] = readl(ssp->mmio_base + lpss_saved_regs[i]);
+
+		for (i = 0; i < 6; i++)
+			pdata->lpss_idma_ctx[i] = readl(ssp->mmio_base + 0x800 + i * 4);
+	}
+
 	status = spi_controller_suspend(drv_data->controller);
 	if (status)
 		return status;
@@ -1508,6 +1531,40 @@ static int pxa2xx_spi_resume(struct device *dev)
 		status = clk_prepare_enable(ssp->clk);
 		if (status)
 			return status;
+
+		if (is_lpss_ssp(drv_data)) {
+			struct pxa2xx_spi_controller *pdata = drv_data->controller_info;
+			int i;
+
+			/* First de-assert resets by writing 7 to 0x204 (LPSS_PRIV_RESETS) */
+			writel(7, ssp->mmio_base + 0x204);
+
+			/*
+			 * Restore clock/LTR/SSP private registers.
+			 * 0x204 (resets) is skipped - already written above.
+			 * 0x224 (CS control) is skipped - re-initialised by
+			 * lpss_ssp_setup() below to ensure CS starts idle-high.
+			 */
+			for (i = 0; i < ARRAY_SIZE(lpss_saved_regs); i++) {
+				if (lpss_saved_regs[i] == 0x204)
+					continue;
+				writel(pdata->lpss_priv_ctx[i],
+				       ssp->mmio_base + lpss_saved_regs[i]);
+			}
+
+			/*
+			 * Re-initialise SW chip-select control so CS starts
+			 * deasserted (SW_MODE | CS_HIGH) regardless of the
+			 * state it was in at suspend time.
+			 */
+			lpss_ssp_setup(drv_data);
+
+			/* Restore IDMA registers */
+			for (i = 0; i < 6; i++) {
+				writel(pdata->lpss_idma_ctx[i],
+				       ssp->mmio_base + 0x800 + i * 4);
+			}
+		}
 	}
 
 	/* Start the queue running */
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 447be0369384..423cef5118e7 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -34,6 +34,10 @@ struct pxa2xx_spi_controller {
 
 	/* For non-PXA arches */
 	struct ssp_device ssp;
+
+	/* LPSS private registers context */
+	u32 lpss_priv_ctx[4];
+	u32 lpss_idma_ctx[6];
 };
 
 struct spi_controller;
-- 
2.39.5

