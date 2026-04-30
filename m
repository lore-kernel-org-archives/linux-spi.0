Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59E3783C0;
	Thu, 30 Apr 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564592; cv=none; b=oSGG6xjwWDXN5bc8M/fw8Bo9JPv5Ig9/tA9I00qN5Z9setNSQqszOlDUlwSmG6VZibm43CJh9p/9+5OqxgD5pHX0NML8SYPo9p1LJCwwOTjz6lkuMxX34kncxYc8ha9zhnP6bZmhREYwI9ayZvTVtoPKHWX5WJtAE+/Zd2vJKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564592; c=relaxed/simple;
	bh=lg30E+nI//bFfV/7P+jkI/Alz7Wv8zi6p5QkditKtlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzNDMkorCptuVAzUASygrd/QIqTKHjpsit1Yz52LJbZV2ilGqOz16OChohlzhHuECkk7yvqmrIZXhX5Ztuugp+bEnuKU10/tFH+npYMB38NJEQsq/Dh2/fBi6Lu1DEe7CylFzs+7dXBfu+RwypgKzGTFAhGJUANMIVXJEAoQqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XQVBYSIf; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XQVBYSIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=EZ
	yfT7HUgDZVpDW8FnDzfwicIGCHfxW7z0LSAJ2rXYg=; b=XQVBYSIfjg2SUfM4gw
	q62jHmuXr2HzZNhlmA4IqyN69WveUqMFdR4oXYdDKP1voIHOrxc0eJqFGdsVT5gh
	qQWlAP4F8qRTobbOtxBFcUYdIbN43rw8bBbp3t2u+Oj2cK7h5SIe033yFTZGO7+F
	DiORvwZ08IBBK47xtTjQfT0fU=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXyu5Se_NpHedTCg--.49548S9;
	Thu, 30 Apr 2026 23:55:07 +0800 (CST)
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
Subject: [PATCH 07/10] spi: stm32-ospi: Use FIELD_MODIFY()
Date: Thu, 30 Apr 2026 23:54:53 +0800
Message-Id: <20260430155456.36998-8-18255117159@163.com>
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
X-CM-TRANSID:_____wAXyu5Se_NpHedTCg--.49548S9
X-Coremail-Antispam: 1Uf129KBjvdXoWrur17tw4DXF1kXFW7Kr1xZrb_yoWDJrg_CF
	48AF4Ikw4Y9rZxAa1rurn3AF909aykWa109FyDtFZayrWDWw4Uu393Jrn8Ga4UZrs7Ar4f
	CFnrX3W8A34fKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRN6pBPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBtM72nze1tkuQAA3b

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/spi/spi-stm32-ospi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 4461c6e24b9e..3757f6ba8fc6 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -470,10 +470,9 @@ static int stm32_ospi_send(struct spi_device *spi, const struct spi_mem_op *op)
 	u8 cs = spi->chip_select[ffs(spi->cs_index_mask) - 1];
 
 	cr = readl_relaxed(ospi->regs_base + OSPI_CR);
-	cr &= ~CR_CSSEL;
-	cr |= FIELD_PREP(CR_CSSEL, cs);
-	cr &= ~CR_FMODE_MASK;
-	cr |= FIELD_PREP(CR_FMODE_MASK, ospi->fmode);
+	FIELD_MODIFY(CR_CSSEL, &cr, cs);
+
+	FIELD_MODIFY(CR_FMODE_MASK, &cr, ospi->fmode);
 	writel_relaxed(cr, regs_base + OSPI_CR);
 
 	if (op->data.nbytes)
-- 
2.34.1

