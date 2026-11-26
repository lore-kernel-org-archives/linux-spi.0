Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720283;
	b=ZpZmQhMTyLCxXAgX9xZMWltMxioyO37wnFV1nw/vNJRcmiMMOgGHk0IAPu04crzindBW
	 wSJ5i9vjY8o2ZKGHEeBGV7fYh0q3CRWDoV0vsgTKXx25mR//MGd8PKCuL7E3DAbeAVI85
	 ZssyAxJV85ZXakcorb9M2uXFnN4WGZUwJpjMhfM9ZwGvVMAbq0XvGg1LHrf+Tyi14456M
	 NQCzOK5qLt+YkGXEcj7As7ZoNJa7G5z4cO/KDFBQAyD7UeiuenhPlTnCmKcSEOZ5o8Net
	 ZaN1SK4StorYz7IgCTAmtPTBnEjs2phWqMQU/YGyx2sLeQTQ9/D3PDs1RmMmCT2UPgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720283;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=toteBFJ4ezZ5aPGYGIb4HRCJ6xMk4nB0klctz7NUA/U=;
	b=ZxdDO9s2+PYc0v+rtkVPYkTBiK95Wq1Dy9UIwDLwwr4AaPLJU5jqvm2wF1eCvEE7sZKb
	 x9LqFQ/KP0oTB+92lyqCQhMsfGUL2EbL2vLxXXCcoN4TJl27RqE3+cSe+bCkVJxuK/8LB
	 DGrXqGbCN27qhHUJppK6rSEgZ5AVwrHfCMwsRRK2pPBvmaNGa1kTKA6eqrWzkk8txEf8W
	 L3YjMHHzicYUBxJeaGSDmP0QCxr5YxOrB37ZIKvsUcSTBuonid6PLn+T98wKBH7dTMm3X
	 +C1SHcJUSjrOmUUajyCqKRIv0c8Rj7uF628DzPgYJh9M9kt96Q7AbEiXqjTgAz5N0fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iZSSBUOA;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009EC606A326
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009EC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iZSSBUOA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9BB2E1A181E;
	Thu, 26 Nov 2026 19:11:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6ED9F60558;
	Thu, 26 Nov 2026 19:11:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF9BB11E691C1;
	Thu, 26 Nov 2026 20:11:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720279; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=toteBFJ4ezZ5aPGYGIb4HRCJ6xMk4nB0klctz7NUA/U=;
	b=iZSSBUOATQ0jf1GSEgkGedTsY3xVjj9Bmqth01IcKq0iQ5mxaCAvDTZ2oZBEMHvKK8eSfL
	lKd47wn3dz0W70XIZFmbZEYi43A5vXuREUiMFDNNCKfxyDcvfp/sj4SBAdrNAYxl1F96vU
	CGPFbMNmgVObZJwnfTw6uJyDDrJJgHICdBxbrTsEBqHfPvnihrAsiqnxpU5QuBniTx8N+J
	YGSxrhud2yXi52gEmySDfY45KsLc5GXM438WDyFioSFYJXotT8uTv+5YVfuyaHfiba2QaI
	6ltbJQM+wMQ91dltcnXfr1mJjX3ms+Q/ai9dKeo9eYi3Z5zi39hyU+RXd9BnSw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:24 +0100
Subject: [PATCH 05/12] spi: atmel-quadspi: Drop redundant address buswidth
 check
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-5-ca8e924cca1b@bootlin.com>
References: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
In-Reply-To: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Mark Brown <broonie@kernel.org>, CL Wang <cl634@andestech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Yang Shen <shenyang39@huawei.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Cheng Ming Lin <linchengming884@gmail.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

spi_mem_check_op() rejects an address phase with a non-zero byte count
and a zero buswidth, so op->addr.buswidth is always set when
op->addr.nbytes is non-zero. Drop the redundant condition in
atmel_qspi_sama7g5_set_cfg().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 762a3fb0fca8..c53e0488dcb6 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -712,7 +712,7 @@ static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
 					      op->dummy.buswidth);
 	}
 
-	if (op->addr.buswidth && op->addr.nbytes) {
+	if (op->addr.nbytes) {
 		ifr |= FIELD_PREP(QSPI_IFR_ADDRL_SAMA7G5, op->addr.nbytes - 1) |
 		       QSPI_IFR_ADDREN;
 		iar = FIELD_PREP(QSPI_IAR_ADDR, op->addr.val);

-- 
2.56.0

