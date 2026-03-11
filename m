Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346829A9C3;
	Wed, 11 Mar 2026 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194165; cv=none; b=BXPqjzVzb3Z7aT2tGhvzTUgZESCShVIugIytk1wikpw9QD2kttTb3wieF48Job0iBYLGuIPm9hpxTf5eekYSAm9UKzHVfm1o9dhUsBdUJ0HJZ4yZldcuijBf72DAh3Y0dIePaDVCLEb+JpQZLHCdA31oJiZ5DPYbo8czWJmz/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194165; c=relaxed/simple;
	bh=0YcOD8aP9aHUXAgkxqqizZmQmNW30B6uLEqX5ukccIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8EFczAOjjicCTYPtVMvfbpj1/BZ7HMkrucaM+CK+T88mOSQRTGYBWK+h5zJYThfXHS2JhiXSzIYe0+iFPJolfSMdAFFvcT33ycWDLAQe/I8UICIOb4VhKHNM+q2zb4kd7AHOKshPUMGlCRRJplyqzrUe1+dETLOb7dkfKR1RD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 71b2b1fa1ced11f1a21c59e7364eecb8-20260311
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:b6f24356-0cab-4b45-9553-92b841dcf4ff,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-20
X-CID-INFO: VERSION:1.3.11,REQID:b6f24356-0cab-4b45-9553-92b841dcf4ff,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-META: VersionHash:89c9d04,CLOUDID:622a925c7554644d4957baa4706bea99,BulkI
	D:260311095559FJDLW5NL,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71b2b1fa1ced11f1a21c59e7364eecb8-20260311
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1979403286; Wed, 11 Mar 2026 09:55:56 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: cl634@andestech.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 1/2] spi: atcspi200: Use helper function devm_clk_get_enabled()
Date: Wed, 11 Mar 2026 09:55:13 +0800
Message-Id: <e53aefc63e28caf32bcd553f3d0a8f2a5a25cd8d.1773193726.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773193726.git.xiaopei01@kylinos.cn>
References: <cover.1773193726.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks"), devm_clk_get() and clk_prepare_enable() can now be
replaced by devm_clk_get_enabled(). Moreover, it is no longer necessary to
unprepare and disable the clocks explicitly.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-atcspi200.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index dd19fe9f9ee7..c0607193be8d 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -486,11 +486,6 @@ static int atcspi_init_resources(struct platform_device *pdev,
 		return dev_err_probe(spi->dev, PTR_ERR(spi->regmap),
 				     "Failed to init regmap\n");
 
-	spi->clk = devm_clk_get(spi->dev, NULL);
-	if (IS_ERR(spi->clk))
-		return dev_err_probe(spi->dev, PTR_ERR(spi->clk),
-				     "Failed to get SPI clock\n");
-
 	spi->sclk_rate = ATCSPI_MAX_SPEED_HZ;
 	return 0;
 }
@@ -512,13 +507,10 @@ static int atcspi_configure_dma(struct atcspi_dev *spi)
 
 static int atcspi_enable_clk(struct atcspi_dev *spi)
 {
-	int ret;
-
-	ret = clk_prepare_enable(spi->clk);
-	if (ret)
-		return dev_err_probe(spi->dev, ret,
-				     "Failed to enable clock\n");
-
+	spi->clk = devm_clk_get_enabled(spi->dev, NULL);
+	if (IS_ERR(spi->clk))
+		return dev_err_probe(spi->dev, PTR_ERR(spi->clk),
+				     "Failed to get SPI clock\n");
 	spi->clk_rate = clk_get_rate(spi->clk);
 	if (!spi->clk_rate)
 		return dev_err_probe(spi->dev, -EINVAL,
@@ -571,15 +563,14 @@ static int atcspi_probe(struct platform_device *pdev)
 
 	ret = atcspi_setup(spi);
 	if (ret)
-		goto disable_clk;
+		goto free_controller;
 
 	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret) {
 		dev_err_probe(spi->dev, ret,
 			      "Failed to register SPI controller\n");
-		goto disable_clk;
+		goto free_controller;
 	}
-
 	spi->use_dma = false;
 	if (ATCSPI_DMA_SUPPORT) {
 		ret = atcspi_configure_dma(spi);
@@ -593,9 +584,6 @@ static int atcspi_probe(struct platform_device *pdev)
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(spi->clk);
-
 free_controller:
 	spi_controller_put(host);
 	return ret;
-- 
2.25.1

