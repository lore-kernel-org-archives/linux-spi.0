Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF227467F;
	Wed, 18 Mar 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801623; cv=none; b=GKzeDsC4gu7IKJvGTl/AmRNfDazqMkM+ALXwaRPp8Vk1RSvKf0Y6xclH5A9BZADqo1LDEehE/bkaUYM5kVievmH+CqhtQFI/yXMy5ovyVGLqmXDFceZo+BX69kLU6wDxvHk7JU0vpUJPTDHqw2nbhyAiooTmj2KOTQxP27Iax5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801623; c=relaxed/simple;
	bh=pGu+1DuozLUiGGtwjFE9obpDtozK5Zb42Z6iFLq9STc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UggEYhjs4eT7Jgysrs6FMnt7L4eckjID+o33DMd6VltC3y0o8HEkULvSbNxrK8PNyl6xT5QiUyPGME4Thc46WMVRW4y8x7O80jYxKVek2Gi6epuWQ3pb6vwCxZlz+esyNYrsKav7iXlr8LGjD6hj4+XRNsycJ2w1V2bfrZohjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9eb4c20227311f1a21c59e7364eecb8-20260318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:b7d41302-ab01-4193-84df-230ba0b64e3c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:75c250732db7212cdd6b3f17c9b3ba15,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9eb4c20227311f1a21c59e7364eecb8-20260318
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 786414051; Wed, 18 Mar 2026 10:40:12 +0800
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
Subject: [PATCH v4 04/17] spi: img-spfi: Simplify clock handling with devm_clk_get_enabled()
Date: Wed, 18 Mar 2026 10:39:54 +0800
Message-Id: <b928f4ab5500b3fac89bf97da5aee94b1460eaaa.1773801401.git.xiaopei01@kylinos.cn>
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
devm_clk_get_enabled() for both "sys" and "spfi" clocks. This reduces
boilerplate code and error handling, as the managed API automatically
disables the clocks when the device is removed or if probe fails.

Remove the now-unnecessary clk_disable_unprepare() calls from the
probe error paths and the remove callback.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-img-spfi.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 902fb64815c9..b45c6ceaffe2 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -557,24 +557,17 @@ static int img_spfi_probe(struct platform_device *pdev)
 	if (ret)
 		goto put_spi;
 
-	spfi->sys_clk = devm_clk_get(spfi->dev, "sys");
+	spfi->sys_clk = devm_clk_get_enabled(spfi->dev, "sys");
 	if (IS_ERR(spfi->sys_clk)) {
 		ret = PTR_ERR(spfi->sys_clk);
 		goto put_spi;
 	}
-	spfi->spfi_clk = devm_clk_get(spfi->dev, "spfi");
+	spfi->spfi_clk = devm_clk_get_enabled(spfi->dev, "spfi");
 	if (IS_ERR(spfi->spfi_clk)) {
 		ret = PTR_ERR(spfi->spfi_clk);
 		goto put_spi;
 	}
 
-	ret = clk_prepare_enable(spfi->sys_clk);
-	if (ret)
-		goto put_spi;
-	ret = clk_prepare_enable(spfi->spfi_clk);
-	if (ret)
-		goto disable_pclk;
-
 	spfi_reset(spfi);
 	/*
 	 * Only enable the error (IACCESS) interrupt.  In PIO mode we'll
@@ -655,9 +648,6 @@ static int img_spfi_probe(struct platform_device *pdev)
 		dma_release_channel(spfi->rx_ch);
 	if (spfi->tx_ch)
 		dma_release_channel(spfi->tx_ch);
-	clk_disable_unprepare(spfi->spfi_clk);
-disable_pclk:
-	clk_disable_unprepare(spfi->sys_clk);
 put_spi:
 	spi_controller_put(host);
 
@@ -675,10 +665,6 @@ static void img_spfi_remove(struct platform_device *pdev)
 		dma_release_channel(spfi->rx_ch);
 
 	pm_runtime_disable(spfi->dev);
-	if (!pm_runtime_status_suspended(spfi->dev)) {
-		clk_disable_unprepare(spfi->spfi_clk);
-		clk_disable_unprepare(spfi->sys_clk);
-	}
 }
 
 #ifdef CONFIG_PM
-- 
2.25.1

