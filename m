Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E9450915;
	Thu, 30 Apr 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564602; cv=none; b=dNU1GrE6nCbm8qMNswVaPotoghBmtJB44XRpFpaczWdXo+7/bPBD+EpORapL7Y6WI/A/Xo1KvU7QxV9CTaluf8+9xd8FVwp0fZ/oZA55rMzV7np/az/jvpH37Jf8ZZimGr6K/ODyQF1oEJu5ggcBAxPf+gH+lXvwhbf/WGt77h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564602; c=relaxed/simple;
	bh=zd1dE7/6Zd8Z2L8eKieK1Px69LQtufkEf9w1SXxqMnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRTNk9LVOKtDDmmltSa12sgix1Q5qDc2HEiTKxK02mXD9NF8PUStaivV4/h/SgqB7mpWG3Fn2zWCR0UNRwMmgBO7Sh1TWT+BPhTiRQvobcKGRsMhTjDdp5UKvgw5cOvMfptuNU1RZhASSoNDwwYxlecQU9eUEwPoxR1/gfWEpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T9pSkmCW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T9pSkmCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=19
	prBy0n5wuyUpUdXN4aPlt40TxeRc+ijGpYYWAHrnw=; b=T9pSkmCWcahkdwYwN+
	JEqB7kssGOAN2DzJVHZhlCfIHGwqag/u6OA5YBG84PumYwOKjWXE0gYavC3QB4Wo
	4akF0Rb+XZUHLduYZoktCUDw0Q3lyMcBumhcAm4B0K3FoDnR3NMB3oXHAYePappo
	5XaZO2I8ULEMUY5LZ94UxBSco=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S12;
	Thu, 30 Apr 2026 23:55:11 +0800 (CST)
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
Subject: [PATCH 10/10] spi: uniphier: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:54:56 +0800
Message-Id: <20260430155456.36998-11-18255117159@163.com>
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
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S12
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW7uF43JF4kKrWUJFyUtrb_yoW8WFW5pF
	s5GFsFyF40yr4UArn5Aay8uFyaqa929as7Ga4DK39xX3WIqr1UAFW0ka15Jr47AFWxXF1f
	Ca93AFyrGF47ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9a9hUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x9N8Gnze19PzAAA30

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/spi/spi-uniphier.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index eac6c3e8908b..846f65ba9495 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -184,14 +184,12 @@ static void uniphier_spi_set_transfer_size(struct spi_device *spi, int size)
 	u32 val;
 
 	val = readl(priv->base + SSI_TXWDS);
-	val &= ~(SSI_TXWDS_WDLEN_MASK | SSI_TXWDS_DTLEN_MASK);
-	val |= FIELD_PREP(SSI_TXWDS_WDLEN_MASK, size);
-	val |= FIELD_PREP(SSI_TXWDS_DTLEN_MASK, size);
+	FIELD_MODIFY(SSI_TXWDS_WDLEN_MASK, &val, size);
+	FIELD_MODIFY(SSI_TXWDS_DTLEN_MASK, &val, size);
 	writel(val, priv->base + SSI_TXWDS);
 
 	val = readl(priv->base + SSI_RXWDS);
-	val &= ~SSI_RXWDS_DTLEN_MASK;
-	val |= FIELD_PREP(SSI_RXWDS_DTLEN_MASK, size);
+	FIELD_MODIFY(SSI_RXWDS_DTLEN_MASK, &val, size);
 	writel(val, priv->base + SSI_RXWDS);
 }
 
@@ -308,9 +306,8 @@ static void uniphier_spi_set_fifo_threshold(struct uniphier_spi_priv *priv,
 	u32 val;
 
 	val = readl(priv->base + SSI_FC);
-	val &= ~(SSI_FC_TXFTH_MASK | SSI_FC_RXFTH_MASK);
-	val |= FIELD_PREP(SSI_FC_TXFTH_MASK, SSI_FIFO_DEPTH - threshold);
-	val |= FIELD_PREP(SSI_FC_RXFTH_MASK, threshold);
+	FIELD_MODIFY(SSI_FC_TXFTH_MASK, &val, SSI_FIFO_DEPTH - threshold);
+	FIELD_MODIFY(SSI_FC_RXFTH_MASK, &val, threshold);
 	writel(val, priv->base + SSI_FC);
 }
 
-- 
2.34.1

