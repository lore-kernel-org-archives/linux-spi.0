Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA87436A344
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303221; cv=none; b=NSdu9SSUDeGh8VtCAr9aeEaAPNsBtgzrbDC9OQRKadFtlKR6YYXn7Kl8kGzzR23GR95JjmlD7GyHCpo5VlcaC0WbyAPNh5ZhzHVxmhHxE2Qzb8r6JTbES2HhmsrttWIS4GTPW1GRQHceNmvLslwl/iGbHpiKrxQ7hDrZk/1dqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303221; c=relaxed/simple;
	bh=/30ILNi97e371ZCUfDdkkvyywAaA/bsZTpX6mXbpwm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eFt/GC6ZAWwvOONqUEJ1/hbshfyRGzrlUs4Ibd5kBfcyKnETeMKhjL+C/Def2dQ2VRwQ35RrksUAO7AwApQUYZY6wJj/3Md6myF7oGnxjiHCDGK08J1YQj2n7Lm2ZEUvyZDLK8XZAgeJqdujG+XxEFxwUfTt60HilYkcCDPWpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487b7b4066so8317705b3a.1
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 08:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303219; x=1784908019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8C+dIg+iRIUuwRCedX9SwbyPIfJoMEmzzskW79kAUPY=;
        b=Mj41zZpXk1DLpEyqDxcP+fiVvifWkXozrdjo6JeqBXakb5ne6hzeRQ1M/3rYP/wraU
         E8gqMAM/kLTgDSpoZcNNIXTugk/QtlTwQBi/Ur+cQaOthk7l8QtAUxDDr4OqZ4KU5SUP
         dAHzbaNyIZtZLG2bFuhabbScV/7IbSQnZH254wQAv7ed+djxdmWzsjGo8exS5ixg0ebh
         q8EeBkMgMtF2Ur9WrXJ6uc9iIOUn8ja90BdJWgKZr5xvIw+QI+xS43RNCEdH/nB87ETm
         LbgXFkwqJGMelbB/YSrm1Dow8EYxp3wevuF5ObNFsJaNE7KC+9PW3zYNzNR1MqcCIYug
         iEXA==
X-Gm-Message-State: AOJu0YxQY/z3I9ARglfCv1fWB3kTVjnpKhlHKmb7JesdEcIF+4Efd76A
	+3gwQVEuAVypwlBHj+NOK9Z9uA6qAjwbw88T+EWSdujC8klIUEF80NE=
X-Gm-Gg: AfdE7cl602x0JquYUfsk1RNQ8B/FONAtqvJFOiegQ1JQFWhykisgndCum06uL+g6M5w
	KPPc8+PV2alFu1IO3Dkt9XXh0HylVF3U7jMNTiKFffUUUx5EZrd6lzun8H6OZubZDd0N9jiLg3c
	EsANfHdp6KeUHGK97EmUJuxG8ToT+rPSF3pD/P6NRzYztpkdNJJa+H9o7Hyt4/9gSg/jTboVFgL
	5UP0zqAHHblmZJv2oZlqb9e2+8aGc4fWPJ8c9pXXGjzyKP3DcjDgoK5nxyQ/ulXNuTfftv5+WE4
	WcF7tG2HUFc5/i7In5EYuAoJmitaJVFgMHSuRmhpMKMKWz8JhTbntH6VrJQag48uCl87Ns1+Kla
	A9BuNJ2kRmb289tXyt/3Sb5AITYwzHXgeyXQB/sgTq2pyYo/gFScM6RTGKpZVEqRY6xaDelDd5K
	roeftxjJvkXR3ym7HuLdiegA04PuUslrMJO5Dz8AIf/YHy6nKAt8jXBOZDcF5Dc01HEAh4MUn2G
	Pu6wJ0rQZNuugo=
X-Received: by 2002:a05:6a00:4208:b0:845:c906:5ff5 with SMTP id d2e1a72fcca58-84c292d5262mr3363923b3a.30.1784303218932;
        Fri, 17 Jul 2026 08:46:58 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-46-68.dynamic-ip.hinet.net. [61.228.46.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad87f83sm1332576b3a.3.2026.07.17.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:46:58 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v3 2/2] spi: pxa2xx: restore LPSS private register state on S3 resume
Date: Fri, 17 Jul 2026 23:46:46 +0800
Message-Id: <20260717154646.5854-3-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260717154646.5854-1-fourdollars@debian.org>
References: <20260712162420.7453-1-fourdollars@debian.org>
 <20260717154646.5854-1-fourdollars@debian.org>
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
 drivers/spi/spi-pxa2xx.c | 87 +++++++++++++++++++++++++++++++++++-----
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 22020c43fbe4..94d41cbb3d71 100644
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
@@ -1505,16 +1510,39 @@ static int pxa2xx_spi_suspend(struct device *dev)
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
 	return 0;
+
+out_put:
+	pm_runtime_put_noidle(dev);
+	return status;
 }
 
 static int pxa2xx_spi_resume(struct device *dev)
@@ -1524,14 +1552,55 @@ static int pxa2xx_spi_resume(struct device *dev)
 	int status;
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev)) {
-		status = clk_prepare_enable(ssp->clk);
-		if (status)
-			return status;
+	status = clk_prepare_enable(ssp->clk);
+	if (status)
+		goto out_put;
+
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
 	}
 
 	/* Start the queue running */
-	return spi_controller_resume(drv_data->controller);
+	status = spi_controller_resume(drv_data->controller);
+	if (status) {
+		clk_disable_unprepare(ssp->clk);
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

