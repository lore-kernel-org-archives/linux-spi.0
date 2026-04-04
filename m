Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970913382EC
	for <linux-spi@vger.kernel.org>; Sat,  4 Apr 2026 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274315; cv=none; b=WVJwbKfHfamYxFJs3nFhCehVGk6djdyTch6YyPQpjAPtRp/EyuSPbpr5YAnf+8FSkrzwlrLBnGTGiCk+obPZEN7M138Vd5VuhpTPqwivIU4Fg0KJ8DCHCFhUrUrCBp2R3/WPL+TO4IyoI87ANjDYFynOOEiS4h/UODIh07Ac0CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274315; c=relaxed/simple;
	bh=b4T1j1aSPgI7qabYJwd0GrOVdEmnZSy79O6CWpZ476E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnWZPEXwav4iTRZIK/lpil6dJ/otAADUO8ZhNEvps198ISN51WoDDIdDtSJnF4u1OtkyV2OYf1fGGu3uis1yhCvs1mNvAEfQjE4DJjlzKmEGqqJkac7H7YCTq0g8OT9jjzqK3jeaFWdP1VQ+EKe8gPjTae0vA2RB6q+95V7KZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab33409a2fd811f1aa26b74ffac11d73-20260404
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:e74d3271-af13-49b7-b58a-3aa148f31397,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:3bd7b7895dbc23d3ca19204f907c1050,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab33409a2fd811f1aa26b74ffac11d73-20260404
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 537749328; Sat, 04 Apr 2026 11:45:05 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	gch981213@gmail.com,
	linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 1/4] spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback
Date: Sat,  4 Apr 2026 11:44:58 +0800
Message-Id: <09ac1024a0f1626efaa47ceefc5cfb8ee5dd9418.1775273351.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1775273351.git.xiaopei01@kylinos.cn>
References: <cover.1775273351.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_snand_probe() registers the on-host NAND ECC engine, but teardown was
missing from both probe unwind and remove-time cleanup. Add a devm cleanup
action after successful registration so
nand_ecc_unregister_on_host_hw_engine() runs automatically on probe
failures and during device removal.

Fixes: 764f1b748164 ("spi: add driver for MTK SPI NAND Flash Interface")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-mtk-snfi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 437edbd658aa..3973b5f9a9ca 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1303,6 +1303,13 @@ static const struct spi_controller_mem_caps mtk_snand_mem_caps = {
 	.ecc = true,
 };
 
+static void mtk_unregister_ecc_engine(void *data)
+{
+	struct nand_ecc_engine *eng = data;
+
+	nand_ecc_unregister_on_host_hw_engine(eng);
+}
+
 static irqreturn_t mtk_snand_irq(int irq, void *id)
 {
 	struct mtk_snand *snf = id;
@@ -1443,6 +1450,13 @@ static int mtk_snand_probe(struct platform_device *pdev)
 		goto release_ecc;
 	}
 
+	ret = devm_add_action_or_reset(&pdev->dev, mtk_unregister_ecc_engine,
+				       &ms->ecc_eng);
+	if (ret) {
+		dev_err(&pdev->dev, ret, "failed to add ECC unregister action\n");
+		goto release_ecc;
+	}
+
 	ctlr->num_chipselect = 1;
 	ctlr->mem_ops = &mtk_snand_mem_ops;
 	ctlr->mem_caps = &mtk_snand_mem_caps;
-- 
2.25.1

