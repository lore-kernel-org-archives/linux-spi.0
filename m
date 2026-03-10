Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77142E01E;
	Tue, 10 Mar 2026 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132813; cv=none; b=LLt6JXRIDlQf7Dy9wnXemyCX813OAc+9Se9cilXuQd7db8hOdL1gpgfbVv5na2r8+UtPd7a7HWzQ7m2fHPf4sArOYNxNU3YADigxSt/in5jHuAHROh2Nk9cIWbmdCQh1dpODIGNyGu7VSAtnoxOwfbB7QDYIufvuoAGq1VJtyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132813; c=relaxed/simple;
	bh=4yc9AAumZlol1xQLJizCq/6X0mFsxqZ4k3sqADJx2PI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKoFNaZBQUbW+/o2FgydRUKoCzEKS1mXvryMm3VREJhwD34yfU/4OxHp7igzm0KhdEASS76Xs9F048ZNaEWM+uc6rziOcfKPWID+82NjBRXLXqRhupil1L7HH1UFDfFCAI59wSjolqPaH8bPEr28SYwX4of3+WwnCoAKpRJ5eoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 99f334da1c5e11f1a21c59e7364eecb8-20260310
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:5d61febd-1a4a-41e4-a8e4-982b3c3ef8b0,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:74e6b59fdece3ae4cf5c346a92072747,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 99f334da1c5e11f1a21c59e7364eecb8-20260310
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1334719173; Tue, 10 Mar 2026 16:53:26 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: cl634@andestech.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] spi: atcspi200: Use helper function devm_clk_get_enabled()
Date: Tue, 10 Mar 2026 16:53:02 +0800
Message-Id: <9f6e31608a24f3cdbd6e1429c1e006ccf9f7d9c1.1773132237.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
 drivers/spi/spi-atcspi200.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index 2075058387f3..6d4f3ff3d602 100644
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
@@ -528,11 +523,10 @@ static int atcspi_enable_clk(struct atcspi_dev *spi)
 {
 	int ret;
 
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
@@ -582,17 +576,12 @@ static int atcspi_probe(struct platform_device *pdev)
 		goto free_controller;
 
 	atcspi_init_controller(pdev, spi, host, mem_res);
-
-	ret = atcspi_setup(spi);
-	if (ret)
-		goto disable_clk;
+	atcspi_setup(spi);
 
 	ret = devm_spi_register_controller(&pdev->dev, host);
-	if (ret) {
+	if (ret)
 		dev_err_probe(spi->dev, ret,
 			      "Failed to register SPI controller\n");
-		goto disable_clk;
-	}
 
 	spi->use_dma = false;
 	if (ATCSPI_DMA_SUPPORT) {
@@ -607,9 +596,6 @@ static int atcspi_probe(struct platform_device *pdev)
 
 	return 0;
 
-disable_clk:
-	clk_disable_unprepare(spi->clk);
-
 free_controller:
 	spi_controller_put(host);
 	return ret;
-- 
2.25.1

