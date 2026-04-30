Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC3453491;
	Thu, 30 Apr 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564600; cv=none; b=UjKvdvIPEK2eegkkkIiiJ7liyvp2NwFwR1FTzK826eVTM3yUKxXSNGe6OKbQxJ+hxWGeb4qqKAAtqwq1nJr6AgFlkm4KvPZILGI3oyuw3/xWo89ZF8Etv//VTmvpDjLKvXPGpq5gLX/sma9fRdmwBpzOqK0/vgVgT1/KFidYPrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564600; c=relaxed/simple;
	bh=vMuPCSWnlzUoOadqRRWJjHVYd5EtsG0kqgCpY609jKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+ZirUXkZ9qLwrWrdPG5SlJhe+wlgeBFUUo9nrqE3Q22SM7QLFpj199rJ7bV1wjQO2XMftyuqQk500BqfE3bIVB0xsEWJ1aQUr3H4GDDLx6WRMrz+fEarsL/RcgCdezFGcXU3p9slJ+1nijAAaX8gCx2eiZseU9hcnN3yDzYOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e3TjQ5NG; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e3TjQ5NG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3R
	JLw2ptESdkRgCOXOQZAx2lu7EpkksUmCtcT/1GfHY=; b=e3TjQ5NGBlPXmvA5IV
	nurBn0YnXKta1mNS0pgO8k08+Y8xuqN1h9QWr/g2qnQaSjkEMlDdg7BLA75NJWwm
	i4Urgz/F5psrtaeHqN2mfswAsWxCuygB60ENj7qioTDv68H5v/j5kZ7UKiuujnFA
	/hTOAhtwnuh/5+hMKkMsc2Pqw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S8;
	Thu, 30 Apr 2026 23:55:06 +0800 (CST)
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
Subject: [PATCH 06/10] spi: sn-f-ospi: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:54:52 +0800
Message-Id: <20260430155456.36998-7-18255117159@163.com>
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
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S8
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17Kr15JryDWFyUKFyUJrb_yoWfZFc_CF
	1YvrWxJrZ0k3yxC3WxWFZ5A3s09rn8uF4kt3Z7tasxAwsxWw13Ww1ktrW8Aa4UZFs8ur40
	9wsrZrW8Cr1akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN6pBPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xpM72nze1pO-wAA3Y

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/spi/spi-sn-f-ospi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index b459d51cb3a8..f0320e96fe23 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -222,9 +222,8 @@ static void f_ospi_config_clk(struct f_ospi *ospi, u32 device_hz)
 	 */
 	val = readl(ospi->base + OSPI_CLK_CTL);
 
-	val &= ~(OSPI_CLK_CTL_PHA | OSPI_CLK_CTL_DIV);
-	val |= FIELD_PREP(OSPI_CLK_CTL_PHA, OSPI_CLK_CTL_PHA_180)
-	     | FIELD_PREP(OSPI_CLK_CTL_DIV, div_reg);
+	FIELD_MODIFY(OSPI_CLK_CTL_PHA, &val, OSPI_CLK_CTL_PHA_180);
+	FIELD_MODIFY(OSPI_CLK_CTL_DIV, &val, div_reg);
 
 	writel(val, ospi->base + OSPI_CLK_CTL);
 }
-- 
2.34.1

