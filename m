Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193A386C32;
	Thu, 19 Mar 2026 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889616; cv=none; b=QkNddr8YmwnRZZp1eMNfVWKLZwFnuLWE4vCwd6a0I6lt6CzK6bGHEduXU4xcbCX28i1jclwn29OffoaBJhCMRorX8KYK9Z26EMYt1tnSu36BkLvNaSrhnca2gCq3OXTI53SAcFX6rWD+msCj9w3a/LRqrvizGrSTgf0F7vrP6pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889616; c=relaxed/simple;
	bh=JAafpXmyjNXGBTQGyplIqgmHxxumO3r4XvPmLQynYOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fcx2HLcPjjWVMnN+xRerusqQOcvDSS2dG6lGti86+BVL1T4gwwypMelri/Q4ZzZWuH0hhoZmD+mB0nsClPBEdvS9+LS/UuajwyFpPc4Jq5r0I55u2PiZwsI/3GLn98CILVmCYHFd84wkce8hjvOCi+LoEl4la3fj7/+hcTbPO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ab2f30ee234011f1a21c59e7364eecb8-20260319
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:690e639e-877b-4fe3-95a4-ed73073e0b2a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:89c9d04,CLOUDID:a1d6f5a7a82749c21544a141ff7ee261,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|898,TC:nil,Content:0|15|50
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab2f30ee234011f1a21c59e7364eecb8-20260319
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 758969387; Thu, 19 Mar 2026 11:06:48 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: shenyang39@huawei.com,
	broonie@kernel.org,
	f.fangjian@huawei.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 1/2] spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
Date: Thu, 19 Mar 2026 11:06:41 +0800
Message-Id: <d834ce28172886bfaeb9c8ca00cfd9bf1c65d5a1.1773889292.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773889292.git.xiaopei01@kylinos.cn>
References: <cover.1773889292.git.xiaopei01@kylinos.cn>
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

Fixes: c770d8631e18 ("spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-hisi-kunpeng.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 216a0a91fc47..c42d2a2cdf1e 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -196,8 +196,18 @@ static void hisi_spi_flush_fifo(struct hisi_spi *hs)
 	unsigned long limit = loops_per_jiffy << 1;
 
 	do {
-		while (hisi_spi_rx_not_empty(hs))
+		unsigned long inner_limit = loops_per_jiffy;
+
+		while (hisi_spi_rx_not_empty(hs) && --inner_limit) {
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
 }
 
-- 
2.25.1

