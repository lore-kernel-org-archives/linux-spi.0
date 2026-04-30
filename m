Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B745BD4C;
	Thu, 30 Apr 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564600; cv=none; b=AmQJVxwxaSqUZ9s0IbBUDUNXaJ7WFVn2fwpbL4dJ0ZWsp/QHn3PNtHstprYHy5iZ4rctBAVUpyjaAHmB1KEDZAYLVE8TqfQqJ4g0Pfa2/yo7rzy7OZ4Y4axjDidvCdK705uGxtQIR6dfOgZe+UC6rEYM81YzIOV/npHyErhCak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564600; c=relaxed/simple;
	bh=+jhBlKsXvsKWEsl/8Sz11TGhp+rmYjPv/rm16EbY7A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q2mwgSm+x7Q8ceg16AZOXFsLq8e9rN0ezpiuXotHe8eRu0jdyCAdHCfkXbBh1bDe5a1MdnQYlhmFKXoQrG8hW9H3sEbvovkBxhXekktGdX28HvuJnODXdGh9vkA1z1MNnIkerb4jyZHeGLHDkLEADWkts1FZrRJNNlcQLw5ALE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=o8vXHoUB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="o8vXHoUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mh
	XA4cqqHPFlshtdy+6Myvdjud+BTw8nlhOl5t9b4BU=; b=o8vXHoUBewuSn3444E
	d8AGVQhH/Uvg/8sMdhEzhu360oYztp0mtqMMuoTG8nvLVEeaRJDqUTIvg+4GUkLl
	qFgRs8sZm04XByzz184XL4yVyPPtX7doIThwpaGos9mdcE0qoijGqmMTRWFHtASL
	K8E5FT8tFOrnU9MKW/AWc9H9U=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S7;
	Thu, 30 Apr 2026 23:55:05 +0800 (CST)
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
Subject: [PATCH 05/10] spi: nxp-xspi: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:54:51 +0800
Message-Id: <20260430155456.36998-6-18255117159@163.com>
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
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF4ftw4UKF43Gr48WFg_yoW8Zry5pr
	18Aa47GFW8tay0y3ZxZF4ayF1YqFs5X3W7A3Wkt39I93Z2vF1kZFWvkF1rJw1UJFy8KFya
	g392kFyUCw4Yv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piBMKNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBlM72nze1lkagAA3I

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/spi/spi-nxp-xspi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 385302a6e62f..037eac24e6fd 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -493,9 +493,8 @@ static void nxp_xspi_disable_ddr(struct nxp_xspi *xspi)
 	writel(reg, base + XSPI_MCR);
 
 	reg &= ~XSPI_MCR_DDR_EN;
-	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
 	/* Use dummy pad loopback mode to sample data */
-	reg |= FIELD_PREP(XSPI_MCR_DQS_FA_SEL_MASK, 0x01);
+	FIELD_MODIFY(XSPI_MCR_DQS_FA_SEL_MASK, &reg, 0x01);
 	writel(reg, base + XSPI_MCR);
 	xspi->support_max_rate = 133000000;
 
@@ -524,15 +523,13 @@ static void nxp_xspi_enable_ddr(struct nxp_xspi *xspi)
 	writel(reg, base + XSPI_MCR);
 
 	reg |= XSPI_MCR_DDR_EN;
-	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
 	/* Use external dqs to sample data */
-	reg |= FIELD_PREP(XSPI_MCR_DQS_FA_SEL_MASK, 0x03);
+	FIELD_MODIFY(XSPI_MCR_DQS_FA_SEL_MASK, &reg, 0x03);
 	writel(reg, base + XSPI_MCR);
 	xspi->support_max_rate = 200000000;
 
 	reg = readl(base + XSPI_FLSHCR);
-	reg &= ~XSPI_FLSHCR_TDH_MASK;
-	reg |= FIELD_PREP(XSPI_FLSHCR_TDH_MASK, 0x01);
+	FIELD_MODIFY(XSPI_FLSHCR_TDH_MASK, &reg, 0x01);
 	writel(reg, base + XSPI_FLSHCR);
 
 	reg = FIELD_PREP(XSPI_SMPR_DLLFSMPFA_MASK, 0x04);
@@ -1096,8 +1093,7 @@ static int nxp_xspi_default_setup(struct nxp_xspi *xspi)
 
 	/* Give read/write access right to EENV0 */
 	reg = readl(base + XSPI_FRAD0_WORD2);
-	reg &= ~XSPI_FRAD0_WORD2_MD0ACP_MASK;
-	reg |= FIELD_PREP(XSPI_FRAD0_WORD2_MD0ACP_MASK, 0x03);
+	FIELD_MODIFY(XSPI_FRAD0_WORD2_MD0ACP_MASK, &reg, 0x03);
 	writel(reg, base + XSPI_FRAD0_WORD2);
 
 	/* Enable the FRAD check for EENV0 */
-- 
2.34.1

