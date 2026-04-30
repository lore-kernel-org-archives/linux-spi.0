Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368C045BD6C;
	Thu, 30 Apr 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564599; cv=none; b=gO64NkkiBeblpPyIJZcoSWk3k7BKy5ISfH8wiS3/11/H2kYOcrRQI8C5KR3TKiNk0bgpcg/HUz8D1EK/oD06sz1YcdKwtoBVtLaM/3VIXL5LLfvl/gdOgAeSO65yq06bLhbah4AreuxmDGNXjXzDgnoJPJxxaSUoioFZ6ja1OHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564599; c=relaxed/simple;
	bh=JuO95LLlvVCqdK/aJx1XUcne2M7CiL54qgbUbBwSJEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iglx66wJehcMiU/KJPSxmDBRhMuS5XjH5ZWGz3JXYhafDeUtk10H/sfje8LansUps6wQhnPETqIaCMj9blNG2eFUqi4l1Sgq6Kqne2MfcAXzlzDY84GfWwTwHiemU/B83AaOqn6t68CcXcAIZIXWHBQK03CzRHGiLLifC7ULTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ev0pNmK+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ev0pNmK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sE
	zybTxl5A7lsGll3i9/ZIVwmqpi3pHGLUkxqxB3X5E=; b=Ev0pNmK+X/kmMND+dC
	EpxzIK8inHUSw6mGkY8INdzuWZ40vLd+JHraH+juElBjcZ5RLXrbuWRJuhTrQDc/
	zOnd9BQFW7fSaHNC3dagcPLYyUBMiejx54bgWhu2fks7Fjt3fJqxc2TJeOW5FkkO
	QrPvI10tC4X+JfJtL1CtMZasI=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S10;
	Thu, 30 Apr 2026 23:55:08 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: broonie@kernel.org,
	sunny.luo@amlogic.com,
	xianwei.zhao@amlogic.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	han.xu@nxp.com,
	haibo.chen@nxp.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	lhjeff911@gmail.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 08/10] spi: stm32-qspi: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:54:54 +0800
Message-Id: <20260430155456.36998-9-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430155456.36998-1-18255117159@163.com>
References: <20260430155456.36998-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw43ur1xXF4xXr47Jwb_yoWfKFb_ur
	1UAFn7Kw4q9F97JF48CryxZr909FWDWa1ktFnIqayfAwn8X3y7u3ykXr1DG3WDZr4kCr4F
	9FsrX3Wvkry3JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN6pBPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxxN8Gnze1xaPQAA34

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/spi/spi-stm32-qspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index df1bbacec90a..ea69fe25686f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -374,9 +374,8 @@ static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
 	int timeout, err = 0, err_poll_status = 0;
 
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
-	cr &= ~CR_PRESC_MASK & ~CR_FSEL;
-	cr |= FIELD_PREP(CR_PRESC_MASK, flash->presc);
-	cr |= FIELD_PREP(CR_FSEL, flash->cs);
+	FIELD_MODIFY(CR_PRESC_MASK, &cr, flash->presc);
+	FIELD_MODIFY(CR_FSEL, &cr, flash->cs);
 	writel_relaxed(cr, qspi->io_base + QSPI_CR);
 
 	if (op->data.nbytes)
-- 
2.34.1

