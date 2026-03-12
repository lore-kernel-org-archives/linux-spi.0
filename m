Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A1381AF3;
	Thu, 12 Mar 2026 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283694; cv=none; b=eiUT4B14lXgU1XtjkYK0+Oj06gmhpB4e2wojLJ5Kbr4LWV/3UnloWeFgazI9Lj8O1KgUqYNS0qIEyWqBEMqCgj6x3yMBlv5l9HyPGwtx/WwA2+Ack30G1Yfu+X+iAfqwhJMo5NPYg9wgbVhrniSu6JyYUNU2Yx4/ePCygYC1spA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283694; c=relaxed/simple;
	bh=iHFghioCE7cSmKetu6upA8P3lfQ5brLuWlgio2SrkZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YDULU/PKcfVGEhD/wxZTMR6/KaporwNFui/zzZTxjItfi/piTghEADlJKr6e6HYByuLZYYDcK7btf1YrA7iDEG76q9bh3nxoJZRng1nWH/1rXMAj5jZ2Nxjx2epNAgc5KWCV1wSgwuLhACs0XdCs9gAqKUxQa4jOJe6DeiEDbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e1e77c641dbd11f1a21c59e7364eecb8-20260312
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:e1d21995-b045-4b73-afd4-de2725c15d8f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:4a9f9861319d5eb48fe141da4759d591,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e1e77c641dbd11f1a21c59e7364eecb8-20260312
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1118987656; Thu, 12 Mar 2026 10:48:00 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: cl634@andestech.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v3] spi: atcspi200: fix mutex initialization order
Date: Thu, 12 Mar 2026 10:47:55 +0800
Message-Id: <15a71241affc25108a97d40d9d3dd1bc3d2d69ed.1773282905.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atcspi_exec_mem_op() function may call mutex_lock() on the
driver's mutex before it is properly initialized if a SPI memory
operation is initiated immediately after devm_spi_register_controller()
is called. The mutex initialization currently occurs after the
controller registration, which leaves a window where the mutex could
be used uninitialized.

Move the mutex initialization to the beginning of the probe function,
before any registration or resource allocation.

Fixes: 34e3815ea459 ("spi: atcspi200: Add ATCSPI200 SPI controller driver")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changes in v3:use mutex_init
changes in v2:add miss goto free_controller;
---
 drivers/spi/spi-atcspi200.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index c0607193be8d..c9fc37398881 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -551,6 +551,8 @@ static int atcspi_probe(struct platform_device *pdev)
 	spi->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
+	mutex_init(&spi->mutex_lock);
+
 	ret = atcspi_init_resources(pdev, spi, &mem_res);
 	if (ret)
 		goto free_controller;
@@ -580,11 +582,11 @@ static int atcspi_probe(struct platform_device *pdev)
 		else
 			spi->use_dma = true;
 	}
-	mutex_init(&spi->mutex_lock);
 
 	return 0;
 
 free_controller:
+	mutex_destroy(&spi->mutex_lock);
 	spi_controller_put(host);
 	return ret;
 }
-- 
2.25.1

