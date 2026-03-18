Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13A377ED5;
	Wed, 18 Mar 2026 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820976; cv=none; b=A8Sd6PNVgR6ahAaZO6b5HraY7YRQpQGjCzJDblglAHEKzSy0nvMAX8Z6Y/l5m1S2Ut1gHp4qB2w1zdAi9hGCBcgEEUgkvgsniH3X/mn1A5hnah/PhpoFnlEhUkJzb3+z/Ah9iPxi+TLGH36W3G+4RPf+vOsuu4BneWS36oC7Zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820976; c=relaxed/simple;
	bh=+FoqLs9wp10nbH8n86rMaUeZyef9aXqfopQ2B/cTqzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUwILf6P3iTbA1Bu5hfGYaf6xBJYssfGE0xMc2mQmfbGdzzpak12obRpG7Dd8qNvkQIMOwZeBlT9zsbCTx494ZVnVWtx2wN5w/pFqhbQ2ihsAXN1KLiyPEEFPmFveeceJN4T7g9o43dUEqNu1bhrYoRHKhzchFLPJ2HGVWNAY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d9dab58a22a011f1a21c59e7364eecb8-20260318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:ed2e6b62-ed24-4144-be66-1f36421b7210,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:97b96f502b745670ee5d2f8660c4f1ea,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d9dab58a22a011f1a21c59e7364eecb8-20260318
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1662788400; Wed, 18 Mar 2026 16:02:47 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: shenyang39@huawei.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
Date: Wed, 18 Mar 2026 16:02:43 +0800
Message-Id: <d50f1f46b2ee2bba05de9e2d4199353b545194e3.1773820898.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hisi_spi_flush_fifo()'s inner while loop that lacks any timeout
mechanism. Maybe the hardware never becomes empty, the loop will spin
forever, causing the CPU to hang.

Fix this by adding a inner_limit based on loops_per_jiffy. The inner loop
now exits after approximately one jiffy if the FIFO remains non-empty, logs
a ratelimited warning, and breaks out of the outer loop. Additionally, add
a cpu_relax() inside the busy loop to improve power efficiency.

Also add a ratelimited warning when the outer limit expires, to aid in
debugging hardware stalls.

Fixes: c770d8631e18 ("spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-hisi-kunpeng.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 216a0a91fc47..b3359ac3a366 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -196,9 +196,22 @@ static void hisi_spi_flush_fifo(struct hisi_spi *hs)
 	unsigned long limit = loops_per_jiffy << 1;
 
 	do {
-		while (hisi_spi_rx_not_empty(hs))
+		unsigned long inner_limit = loops_per_jiffy;
+
+		while (hisi_spi_rx_not_empty(hs) && inner_limit--) {
 			readl(hs->regs + HISI_SPI_DOUT);
+			cpu_relax();
+		}
+
+		if (!inner_limit) {
+			dev_warn_ratelimited(hs->dev, "RX FIFO flush timeout\n");
+			break;
+		}
+
 	} while (hisi_spi_busy(hs) && limit--);
+
+	if (!limit)
+		dev_warn_ratelimited(hs->dev, "SPI busy timeout\n");
 }
 
 /* Disable the controller and all interrupts */
-- 
2.25.1

