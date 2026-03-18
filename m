Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED232D3733;
	Wed, 18 Mar 2026 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801632; cv=none; b=SQ2hyQGDc0QU/XemPJVUFoAsYLdY48ry0akRM6KmHUw6p22I11DjvN1ngvharg+Y987olM6bSC4F+z1+f9+JagNTjexabvT9LHuwv9ACIgb5SCnTHcIXPN3wgW2NxoDnGjbljZhDGH9pJL0hFGAlWI1oSkZvXdoWdyfrpd5kidA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801632; c=relaxed/simple;
	bh=CGbeoWHvJo3PD9AZfWg0XgRkZTASOZnyVW3ysUXlSI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twbTLQj6zQImP/dDyNPNT0Vf0pkke/P6xKI2tX9FYQqvFt+p90M5t9Nd+2sbY6HZ3hQzA/LVTEEhItKMp1/kZ1u3xm1lWXeiCCUZiCinMAM4qx0xDzC1ESjrS2+TF4Yat26nbCNE900FdMy6Mi+ujv3QKuR2k2OOihwETbPDbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cb44b41c227311f1a21c59e7364eecb8-20260318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:0203037e-adaf-4254-8911-c4acc1e35a6e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:d98bf1cde657b2071c1f6fc4533bc0bd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cb44b41c227311f1a21c59e7364eecb8-20260318
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1294059975; Wed, 18 Mar 2026 10:40:15 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	openbmc@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v4 10/17] spi: slave-mt27xx: Simplify clock handling with devm_clk_get_enabled()
Date: Wed, 18 Mar 2026 10:40:00 +0800
Message-Id: <a0b2f699f352282ddd17953ae9dbe9c84877dfca.1773801401.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773801401.git.xiaopei01@kylinos.cn>
References: <cover.1773801401.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace devm_clk_get() followed by clk_prepare_enable() with
devm_clk_get_enabled() for the "spi" clock. This reduces boilerplate
code and error handling, as the managed API automatically disables the
clock when the device is removed or if probe fails.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-slave-mt27xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index ce889cb33228..8ec886918165 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -438,19 +438,13 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 		goto err_put_ctlr;
 	}
 
-	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi");
+	mdata->spi_clk = devm_clk_get_enabled(&pdev->dev, "spi");
 	if (IS_ERR(mdata->spi_clk)) {
 		ret = PTR_ERR(mdata->spi_clk);
 		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
 		goto err_put_ctlr;
 	}
 
-	ret = clk_prepare_enable(mdata->spi_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable spi_clk (%d)\n", ret);
-		goto err_put_ctlr;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
-- 
2.25.1

