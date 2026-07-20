Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD13AC0D0;
	Mon, 20 Jul 2026 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527745; cv=none; b=QF6MEIsIvWdI4A9MBI1mY0dJqzyDFkfngqS0q4yLJaXt0W+xFefA+KYJ6y7tvDpxiKqI07+0Xb5FxnpSk2i2RWBl/SE0KM37g3OVrZTUcatllr04PmpRFAtyppiE6hF/bJGCtElbU3YzjyjakoKV+HlWPeM/LG2s9gF/a2iUjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527745; c=relaxed/simple;
	bh=mrGcT3Wk+BStHgsLHZw7QugJCYsAOpAISl3JDVFr0fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lThF2qF6rbRBgGyeZvN6JKnwbp6kM65QLFnRiZk16zFPN1NZwDZPS1JLY5sJgEd/EMxskOFDiD2vTvN+Igui0XuluptKJnsxJ2S4BZw4tdbX0XZ90bp+TJyq8ZVLvrv3BF5LT+umZWtCMCj+ImpFth5qSu9PCreuUfdLzvHxcwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7a30e97a840111f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7d45252c-8b4d-47a3-8d16-5d413afd813b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:1360bb2546396b697bd7e98b8f29a7fa,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7a30e97a840111f1aa26b74ffac11d73-20260720
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1629856269; Mon, 20 Jul 2026 14:08:50 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: broonie@kernel.org,
	dlan@kernel.org,
	elder@riscstar.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH 2/2] spi: spacemit: drop redundant dev_err_probe() around irq helpers
Date: Mon, 20 Jul 2026 14:08:44 +0800
Message-Id: <119b5f8e3ac68221307cbfcd227dc8546be0eaeb.1784527556.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1784527556.git.xiaopei01@kylinos.cn>
References: <cover.1784527556.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_get_irq() and devm_request_irq() already print an error
message via dev_err_probe() on failure, so wrapping them with
another dev_err_probe() results in duplicate error output.

Return the error code directly instead.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-spacemit-k1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index cd2955949c5c..4348d77ec77c 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -737,12 +737,12 @@ static int k1_spi_probe(struct platform_device *pdev)
 
 	drv_data->irq = platform_get_irq(pdev, 0);
 	if (drv_data->irq < 0)
-		return dev_err_probe(dev, drv_data->irq, "error getting IRQ\n");
+		return drv_data->irq;
 
 	ret = devm_request_irq(dev, drv_data->irq, k1_spi_ssp_isr,
 			       IRQF_SHARED, dev_name(dev), drv_data);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "error requesting IRQ\n");
+		return ret;
 
 	/* Initialize the host structure, then register it */
 	host->dev.of_node = dev_of_node(dev);
-- 
2.25.1

