Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C18384245;
	Thu, 19 Mar 2026 02:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885872; cv=none; b=K8Kar4AsV4+YIzLJyGkKvRiY9vimddw2J5Tqrbd5FcQacEghcJLC1A0I2R+QjSChCYTyLT37AaqBts8ILrDHyJaJkCJk1DLpG6cfbm6c6IN4in1vOXxRj+OCmv+zQHT2jBUTkOOS/oy/bspHOKpLdmJuCN/cO4RE8eJtzlHujqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885872; c=relaxed/simple;
	bh=ylLgnFAHNr+C6sueQ675YRZWIAhgLynjxGpNw/eADVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWWdxq0GXTJgF/y3tYsimRqSMjZubeMnZWOgxjLdC7q8H2M3arvR3aFQY9Db2nz8tKEIdwirbI3Z25LesVu2m2jBSzJ1F7MCrB3RFmcGfBUCqqFzSXiTTo2OhGXDj9vyBbbfbf/Jt7yijUxiQqHHWiWxXEQNr8xgysEoZEuMhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f23b122c233711f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:d1078b2a-9657-4c59-b481-163762ab0170,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:b7e6ae2e2bf0bb57789677155632f165,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f23b122c233711f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 702188644; Thu, 19 Mar 2026 10:04:21 +0800
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
Subject: [PATCH v5 07/17] spi: orion: Simplify clock handling with devm_clk_get_enabled()
Date: Thu, 19 Mar 2026 10:04:03 +0800
Message-Id: <387f2fa1b3e1a356c524bb36eab07e1b431b6382.1773885292.git.xiaopei01@kylinos.cn>
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
devm_clk_get_enabled() for the "axi" clock. This reduces
boilerplate code and error handling, as the managed API automatically
disables the clock when the device is removed or if probe fails.

Remove the now-unnecessary clk_disable_unprepare() call from the
probe error path and the remove callback. Adjust error handling labels
accordingly.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-orion.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 7a2186b51b4c..a1b489b51115 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -695,13 +695,11 @@ static int orion_spi_probe(struct platform_device *pdev)
 	}
 
 	/* The following clock is only used by some SoCs */
-	spi->axi_clk = devm_clk_get(&pdev->dev, "axi");
+	spi->axi_clk = devm_clk_get_enabled(&pdev->dev, "axi");
 	if (PTR_ERR(spi->axi_clk) == -EPROBE_DEFER) {
 		status = -EPROBE_DEFER;
 		goto out;
 	}
-	if (!IS_ERR(spi->axi_clk))
-		clk_prepare_enable(spi->axi_clk);
 
 	tclk_hz = clk_get_rate(spi->clk);
 
@@ -726,7 +724,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(spi->base)) {
 		status = PTR_ERR(spi->base);
-		goto out_rel_axi_clk;
+		goto out;
 	}
 
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
@@ -764,7 +762,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 		if (!dir_acc->vaddr) {
 			status = -ENOMEM;
 			of_node_put(np);
-			goto out_rel_axi_clk;
+			goto out;
 		}
 		dir_acc->size = PAGE_SIZE;
 
@@ -788,8 +786,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
-out_rel_axi_clk:
-	clk_disable_unprepare(spi->axi_clk);
 out:
 	spi_controller_put(host);
 	return status;
@@ -799,10 +795,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 static void orion_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct orion_spi *spi = spi_controller_get_devdata(host);
 
 	pm_runtime_get_sync(&pdev->dev);
-	clk_disable_unprepare(spi->axi_clk);
 
 	spi_unregister_controller(host);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

