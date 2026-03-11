Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC435F61E;
	Wed, 11 Mar 2026 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194167; cv=none; b=r8MxWVNZjrzoUlXfqwbCosVtQROTMHywYPOg/mCkrhMEzhw9rxWfUA32kMbkuf6pihAnisSgXGl4w83hPtBa6JtK2ucP/TyIrduC+XcY901CmL8lRNaGCCeYXTtaxCY2LZbZhcynjB+km0JKCHjaYVhc4Ni/BbGSpT9rZF+GPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194167; c=relaxed/simple;
	bh=ewGmRBCPgoDEzhcQn7cmWLnXQ/qtRgp2sybQv50mmTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arl+CvLDHjF2A1qnT/BeCr6hyUONHjo8jLfjvsE+Rz6Nu0DgzbhFqRbt3UyTyt+00EyZkOo/+ropkvPEG20vtRUP6SSbjRxZOOMrVGCtd8uOXePkUBt9/7bvOa+fEtQ5SbwOtAvizLOF/nww8aIew5UMWHJ7AzTANT7MsiCs2tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 73b326241ced11f1a21c59e7364eecb8-20260311
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:bcfdd041-df16-4b34-91dc-be4fcbd1230d,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-20
X-CID-INFO: VERSION:1.3.11,REQID:bcfdd041-df16-4b34-91dc-be4fcbd1230d,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-META: VersionHash:89c9d04,CLOUDID:060ffa5aa74f4f2b17921ea65219a778,BulkI
	D:2603110956027ITGUREF,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|850|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 73b326241ced11f1a21c59e7364eecb8-20260311
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 652833890; Wed, 11 Mar 2026 09:55:59 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: cl634@andestech.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2 2/2] spi: atcspi200: fix mutex initialization order
Date: Wed, 11 Mar 2026 09:55:14 +0800
Message-Id: <f47d4c292bdff7a0bad8d316c28c83c0fda36a0c.1773193726.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1773193726.git.xiaopei01@kylinos.cn>
References: <cover.1773193726.git.xiaopei01@kylinos.cn>
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
before any registration or resource allocation. Also replace the
plain mutex_init() with devm_mutex_init() to benefit from automatic
cleanup on driver unbind, preventing potential resource leaks.

Fixes: 34e3815ea459 ("spi: atcspi200: Add ATCSPI200 SPI controller driver")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/spi/spi-atcspi200.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index c0607193be8d..dd1292c5bb98 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -551,6 +551,10 @@ static int atcspi_probe(struct platform_device *pdev)
 	spi->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
+	ret = devm_mutex_init(spi->dev, &spi->mutex_lock);
+	if (ret)
+		goto free_controller;
+
 	ret = atcspi_init_resources(pdev, spi, &mem_res);
 	if (ret)
 		goto free_controller;
@@ -580,7 +584,6 @@ static int atcspi_probe(struct platform_device *pdev)
 		else
 			spi->use_dma = true;
 	}
-	mutex_init(&spi->mutex_lock);
 
 	return 0;
 
-- 
2.25.1

