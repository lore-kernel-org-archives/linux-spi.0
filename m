Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225838A701;
	Thu, 19 Mar 2026 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885877; cv=none; b=QsEnPIZy3Fhp6pVuW3fvDGw0LTzU2sRor+/eCt43zeycg4aM0mbw6E5ENj5guZjf37lcC18d8+oiH0fcswWKAAkKljHBfiJEVqXNlIYsQEABrx4QWLR7iSm6alSfdkxAAB1+HBQQHD+iNp3yz7nyJiiiVUu/OnrsTAEpmIGdc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885877; c=relaxed/simple;
	bh=JxNBfQq344N/2CAB5JlxZ4NdP0US6YmZ4h9xGaciSOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IEcgwE092S0cfgoP16NOwllxNWH6E2WT28bH/XyTiAYSdZjTPOzScomMblDSA+ilCMaAHBphbobzuf0C+uZ7IeWK/5a/mWbaEDgySy2EfrK/s5q2amdtJWA/zbtOcqk90SSicpTNaz0o5WYpFGIbQNN7oMoCeFhaiApau8sXLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f4b189dc233711f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:10f7c1f4-f24a-426e-b4b5-df917d8a9cb6,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:173e02fd34b2c516b8e16ceee670e4ab,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f4b189dc233711f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1715651615; Thu, 19 Mar 2026 10:04:26 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	broonie@kernel.org,
	Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v5 14/17] spi: sunplus-sp7021: Simplify clock handling with devm_clk_get_enabled()
Date: Thu, 19 Mar 2026 10:04:10 +0800
Message-Id: <fb0bc46107975cfff4eefa9ba96fe7545996ae52.1773885292.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773885292.git.xiaopei01@kylinos.cn>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devm_clk_get() followed by clk_prepare_enable() with
devm_clk_get_enabled() for the clock. This removes the need for
explicit clock enable/disable calls and the custom cleanup function,
as the managed API automatically handles clock disabling on device
removal or probe failure.

Remove the now-unnecessary sp7021_spi_disable_unprepare() function
and the devm_add_action_or_reset() call.

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

