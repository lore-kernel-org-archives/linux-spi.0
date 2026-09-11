Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7D470EB2;
	Fri, 11 Sep 2026 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129147; cv=none; b=DPLzE+fAaxNScBY+8K/uv/52SY6fWnaJIL2Vh8FqWnrahptIzhXXcPJXLz6OxUsBg4xgLTelGQoEwTFmLkb1pvxAUj6qjBVMDT2+taR2fojKY+GsV13RoX3em1Lk8Ts1I4aNnFPx/RKylwpN80zfIxgDmP9yWtCbJsFsLdStdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129147; c=relaxed/simple;
	bh=++ku9jna0YkTnjbi+aPh6VX6CaGbRV3nL+0VUiAL8gc=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:MIME-Version; b=ZuqPUgSLEbUSqtWwlVg14FpgGF8k2sOEDftoU2WYhaqbA+R1T689qu3GR5NBj+V6ukeKtme5L4FdnAWWEzqryqIUGHZvCvJceDPM4FpSm6ynalFFMzG4NuINSO/PdDyIOM3f+3oYctBBoqGCI41+4QX7lkixyGq1y9Whi1dK/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=uR+Qb9wu; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="uR+Qb9wu"
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1789129135; h=from:to:date:message-id:subject;
	bh=CfXjyBg2eQrzRBtufnkZF6r5NSL/hwhGLEYh0QczVng=;
	b=uR+Qb9wufN3AVLaZuHupuabn9C0t/EYau/oI+NOHaQ1/36PRCtReqHKxDpK9ykyRIACcmQeJKty
	X2s7OCg/5Jpx9R/GN+lULEM04jcBkEz4jgABYvhCy2g2J9soRIvl9V9jkHm5ajPUFwKwiM3ei7eUC
	asAYKHHdr1VGYHrZaGVqPdhGsV7B8KNIvgaRM7Ppd+C/l32+XcHSjQB0OvdkjSSf/RP4FvhT7C1Jh
	S+ONuQNSpA2Zbc4kSO02+AtmBZWZbntoJ3fBkQbGY5GFZVi/7mZAzu0/pNXq8jyiMbWhpQH1EGmi1
	04AhDR83L3n4HvMstGe/iBOOQi/Vh8P/H2fA==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 11 Sep
 2026 17:18:55 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 11 Sep 2026 17:18:55 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Fri, 11 Sep
 2026 17:18:55 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: Mark Brown <broonie@kernel.org>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH] spi: cadence-quadspi: Remove redundant remaining check in
 indirect write
Thread-Topic: [PATCH] spi: cadence-quadspi: Remove redundant remaining check
 in indirect write
Thread-Index: AQHdQee2S4KVpq5CWEKN9v6U5OMUvw==
Date: Fri, 11 Sep 2026 12:18:55 +0000
Message-ID: <20260911121845.175981-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

The loop in cqspi_indirect_write_execute() always executes exactly
once: write_bytes is set to remaining, so remaining is always zero
after the subtraction at the bottom of the loop. The
reinit_completion() guarded by "if (remaining > 0)" is therefore
dead code.

This is a leftover from when the loop wrote the data in
page_size-sized chunks. The chunking was dropped when the driver was
converted to the spi-mem framework, which made the loop single-
iteration and orphaned the check.

Flatten the loop into straight-line code. No functional change.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/spi/spi-cadence-quadspi.c | 51 ++++++++++++-------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index ecb0be394696..7f9cb42c01e5 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1082,15 +1082,15 @@ static int cqspi_indirect_write_execute(struct cqsp=
i_flash_pdata *f_pdata,
 	struct cqspi_st *cqspi =3D f_pdata->cqspi;
 	struct device *dev =3D &cqspi->pdev->dev;
 	void __iomem *reg_base =3D cqspi->iobase;
-	unsigned int remaining =3D n_tx;
-	unsigned int write_bytes;
+	size_t write_words;
+	size_t mod_bytes;
 	int ret;
=20
 	if (!refcount_read(&cqspi->refcount))
 		return -ENODEV;
=20
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
-	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
+	writel(n_tx, reg_base + CQSPI_REG_INDIRECTWRBYTES);
=20
 	/* Clear all interrupts. */
 	writel(CQSPI_IRQ_STATUS_MASK, reg_base + CQSPI_REG_IRQSTATUS);
@@ -1119,36 +1119,25 @@ static int cqspi_indirect_write_execute(struct cqsp=
i_flash_pdata *f_pdata,
 	if (cqspi->apb_ahb_hazard)
 		readl(reg_base + CQSPI_REG_INDIRECTWR);
=20
-	while (remaining > 0) {
-		size_t write_words, mod_bytes;
-
-		write_bytes =3D remaining;
-		write_words =3D write_bytes / 4;
-		mod_bytes =3D write_bytes % 4;
-		/* Write 4 bytes at a time then single bytes. */
-		if (write_words) {
-			iowrite32_rep(cqspi->ahb_base, txbuf, write_words);
-			txbuf +=3D (write_words * 4);
-		}
-		if (mod_bytes) {
-			unsigned int temp =3D 0xFFFFFFFF;
-
-			memcpy(&temp, txbuf, mod_bytes);
-			iowrite32(temp, cqspi->ahb_base);
-			txbuf +=3D mod_bytes;
-		}
-
-		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
-						 msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
-			dev_err(dev, "Indirect write timeout\n");
-			ret =3D -ETIMEDOUT;
-			goto failwr;
-		}
+	write_words =3D n_tx / 4;
+	mod_bytes =3D n_tx % 4;
+	/* Write 4 bytes at a time then single bytes. */
+	if (write_words) {
+		iowrite32_rep(cqspi->ahb_base, txbuf, write_words);
+		txbuf +=3D write_words * 4;
+	}
+	if (mod_bytes) {
+		unsigned int temp =3D 0xFFFFFFFF;
=20
-		remaining -=3D write_bytes;
+		memcpy(&temp, txbuf, mod_bytes);
+		iowrite32(temp, cqspi->ahb_base);
+	}
=20
-		if (remaining > 0)
-			reinit_completion(&cqspi->transfer_complete);
+	if (!wait_for_completion_timeout(&cqspi->transfer_complete,
+					 msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
+		dev_err(dev, "Indirect write timeout\n");
+		ret =3D -ETIMEDOUT;
+		goto failwr;
 	}
=20
 	/* Check indirect done status */
--=20
2.53.0
