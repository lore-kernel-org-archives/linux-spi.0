Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F423352C28;
	Fri, 13 Mar 2026 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382160; cv=none; b=LH9EyDc34zpq+b8h6d6j9bhr0iN/+eSR/AsOFvJ/p0sWBpcc2FDsSDHT8+NDX57F8/JijQFSYbVTPpVFu3iemvmyHoiPar4LpFuANOlPAQs/++V63izq4nj21EcgXGYOdyRwULNt2uSsHH7Kw0fe4Te3fdc1fP5mEiwYedTeO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382160; c=relaxed/simple;
	bh=dKBnh8sJQftJQFNU1M/dsyI1ASCji+nDI1LiBDmOXwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvBnWH4l6EftEtlP4kEFZzSXJfzkDtaC0VKcWfNqgRHeJFZVbP8j4Yb+neNNEwaOLpsVr5v24KlcLgPy61XVx8tqAyo7ePVDUM8tlGIpJXnJmubZHA/iti6amLGtn7S1L4A+91a39A1eWV5PBxMxKBd/WXq1xpGN0S1QiA0ErVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2250e20a1ea311f1a21c59e7364eecb8-20260313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:be500e60-1ecc-4643-8493-a33481b3c948,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:c3a3e7e624be805ff82687162505ea97,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2250e20a1ea311f1a21c59e7364eecb8-20260313
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1722470595; Fri, 13 Mar 2026 14:09:02 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 12/17] spi: stm32-qspi: Use helper function devm_clk_get_enabled()
Date: Fri, 13 Mar 2026 14:08:28 +0800
Message-Id: <74030eaa592b4a27ec75a4dffe49a5029c5dc6b8.1773381582.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773381582.git.xiaopei01@kylinos.cn>
References: <cover.1773381582.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_clk_get() and clk_prepare_enable() can now be replaced by
devm_clk_get_enabled() when driver enables the clocks. Moreover, it is no
longer necessary to unprepare and disable the clocks explicitly.
Simplify code.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-stm32-qspi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index df1bbacec90a..9ff9975edef4 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -819,25 +819,19 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 	init_completion(&qspi->match_completion);
 
-	qspi->clk = devm_clk_get(dev, NULL);
+	qspi->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(qspi->clk))
-		return PTR_ERR(qspi->clk);
-
+		return dev_err_probe(dev, PTR_ERR(qspi->clk),
+				     "can not enable the clock\n");
 	qspi->clk_rate = clk_get_rate(qspi->clk);
 	if (!qspi->clk_rate)
 		return -EINVAL;
 
-	ret = clk_prepare_enable(qspi->clk);
-	if (ret) {
-		dev_err(dev, "can not enable the clock\n");
-		return ret;
-	}
-
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(rstc)) {
 		ret = PTR_ERR(rstc);
 		if (ret == -EPROBE_DEFER)
-			goto err_clk_disable;
+			goto err_defer;
 	} else {
 		reset_control_assert(rstc);
 		udelay(2);
@@ -886,8 +880,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(qspi->dev);
 err_dma_free:
 	stm32_qspi_dma_free(qspi);
-err_clk_disable:
-	clk_disable_unprepare(qspi->clk);
+err_defer:
 
 	return ret;
 }
-- 
2.25.1

