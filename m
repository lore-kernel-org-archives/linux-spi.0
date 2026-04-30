Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E64145BD57;
	Thu, 30 Apr 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564597; cv=none; b=j8FUVN4yRnx4jPzqARZS82ORN9545IfyXfRUueRQtoFARUct/zh5DMU1WJBga55Wf8/e31pm1DIab5jNuvZKzrv7Em2st4iTdkqB+ApVw5VFROnD8uytO/tJTQRy3rNIVNVxOssZVbza0s/orwXs4N+rifWpO1KrWWlstphBWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564597; c=relaxed/simple;
	bh=W6lFfzpfpHlSJb+6mf2xCSNtxKNmn4pnm4EpIfLBycM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJGT86UneYgonMDq8N3ylFcMa9UFk76piSWOEiHtUJm8toIc0C6Nlgu1KejP2H25ghmF5/Ad1xas5NS19lZhR1/am4xBCfzmT+Bq57ugshi9JBZTibOcallY6VxUNMBhpVEuUnTLCU5MNCuHbC+id8wHqLbowDlj8f1Jy+wE59M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oHuZOIlr; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oHuZOIlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=h/
	7T1NDghetOHRJTyiGBs6dkj72nosx7Vr+gqd9IPi8=; b=oHuZOIlrbjneTkFD57
	+HdARWyQjbuM2K+9E8apm9oASe/dq/mESx9apsulDZ3FH1LjAdr/4T0qUXNtay+e
	Au3rHgG8hU2MXS6wFynfNm8IVTQBkgpU6QDAvTdQkkj+aa9u5/fykhGUuxPInofP
	gLED3vSHYcXpg7ltIVec615nI=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S6;
	Thu, 30 Apr 2026 23:55:04 +0800 (CST)
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
Subject: [PATCH 04/10] spi: meson-spicc: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:54:50 +0800
Message-Id: <20260430155456.36998-5-18255117159@163.com>
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
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw4DWFWfZr4DZw1xAFb_yoWfCrb_Ca
	y8WF4IqFsxt34xAF17Ga4xCr90vrn8Zw4vvF1vgFyfta1kZ3s8Zr1DCry8GF15CF4Fkr4S
	9r93W348Zr43CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN6pBPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BhM72nze1hYgAAA32

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/spi/spi-meson-spicc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index b80f9f457b66..682dda114412 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -539,9 +539,8 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 	conf = conf_orig = readl_relaxed(spicc->base + SPICC_CONREG);
 
 	/* Setup word width */
-	conf &= ~SPICC_BITLENGTH_MASK;
-	conf |= FIELD_PREP(SPICC_BITLENGTH_MASK,
-			   (spicc->bytes_per_word << 3) - 1);
+	FIELD_MODIFY(SPICC_BITLENGTH_MASK, &conf,
+		     (spicc->bytes_per_word << 3) - 1);
 
 	/* Ignore if unchanged */
 	if (conf != conf_orig)
-- 
2.34.1

