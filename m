Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0B33710F;
	Fri, 13 Mar 2026 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382160; cv=none; b=Z+fgieMZrFkZj5PBs13t9g1a0isSnQpTzIx96aBbypuuysaqlaSfnCDKbIG5dUatrkG+SCarVI2uay2ndcRhmwH8/jVf9wLcwW8oxEKUQ4JMOYz58iBC5muEwultU+DLhlF77WeoJZWMU6GD+MQun9l4YuX/DgiZ1jNNhk6GhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382160; c=relaxed/simple;
	bh=NUdzNnYut2dDDsf2VtQ8bEwkhmYI/mv6zl1cDkP+ugI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4BSqi2iH8b529k276W9A7dRFNaSsogXe2hqRHBthmOpzrLBnJadb85G5wbHq9pm0o7hSNmh0MXOnpSW0reXpcXiSzZznC6LBpaBjwkclYFLsqOU83cmWJECLEg+Lfs7y40xCi4zpQt5JAcPAuBBwTrTUSG+AMnIE03u2dLQy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 22eeeeaa1ea311f1a21c59e7364eecb8-20260313
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:4b6aa0af-ffb4-4b0d-a0cc-f9d15f63a572,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:da9e4b9454dc511ca8a48fba8da5b2c6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 22eeeeaa1ea311f1a21c59e7364eecb8-20260313
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 974837560; Fri, 13 Mar 2026 14:09:03 +0800
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
Subject: [PATCH v2 14/17] spi: sunplus-sp7021: Use helper function devm_clk_get_enabled()
Date: Fri, 13 Mar 2026 14:08:30 +0800
Message-Id: <5951a0403ac15a2f46ad8f126ccccc5a209e85d1.1773381582.git.xiaopei01@kylinos.cn>
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
 drivers/spi/spi-sunplus-sp7021.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index 789b092fe8c0..35601212fb78 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -389,11 +389,6 @@ static int sp7021_spi_target_transfer_one(struct spi_controller *ctlr, struct sp
 	return ret;
 }
 
-static void sp7021_spi_disable_unprepare(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
 static void sp7021_spi_reset_control_assert(void *data)
 {
 	reset_control_assert(data);
@@ -460,7 +455,7 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	if (pspim->s_irq < 0)
 		return pspim->s_irq;
 
-	pspim->spi_clk = devm_clk_get(dev, NULL);
+	pspim->spi_clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(pspim->spi_clk))
 		return dev_err_probe(dev, PTR_ERR(pspim->spi_clk), "clk get fail\n");
 
@@ -468,14 +463,6 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	if (IS_ERR(pspim->rstc))
 		return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst get fail\n");
 
-	ret = clk_prepare_enable(pspim->spi_clk);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to enable clk\n");
-
-	ret = devm_add_action_or_reset(dev, sp7021_spi_disable_unprepare, pspim->spi_clk);
-	if (ret)
-		return ret;
-
 	ret = reset_control_deassert(pspim->rstc);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to deassert reset\n");
-- 
2.25.1

