Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720286;
	b=dGqLTrznvg/Evrz+fvWuN/T/cnG2vkElWNGfzMDtT5qhh6ABIFmD739witt//KQ2zgCR
	 pjhQpR2cQyYycvVxBYPtp7jbugJ1M3geLCJ+gbB1NpuV5832Yn3ymoASoA+oPCzfbLCBW
	 VHuUJP6fPrZKKuRutEXvwVS2NqQPvifvRpONC898wh9hCfqus1MBVudkTJfuXbOj0sZdq
	 QCO86PnYtqQw45BKYdsugMvBiiYPC8pqb3ETX1S5AdwwbRQCHMegTJHxHuVEUWuO65dMK
	 /EmqobCXspjqhb5XOfk7r0Nr8lnOiYuYcv0yC4W6Y43MLKDbM3nj8Xc7rccVSYofB5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720286;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=MVolsYhpJ+LMj7zbkMJO+vkL7gKe8OaboFkkUgoisuU=;
	b=MzyIPkSl1IXG04alg2ZycOn1o76CvZNmsEZr1b0rYmbEiiLQnSXjUxbvc0AGPR2oldGM
	 LqO7BNf2Qiy6AenfC2LLcTy+jUObFcn/I37mh9XPCtTZsr8StB0ScsD8VqdDMKePpR2S5
	 K643BsCLY2PtPyZszk20rX4nknA25eGen2quQ+srO7QwGg4GJBY5ZBrqNCptqOwqiWWM+
	 b1EeVSu44C9vrJueqCZuLJtJ81qZhlZ/RRyWNEdpxCaiUwgphiV4M5PP7o39BkCciBGXu
	 4Da+fpTaDsQKJiAbXXULWZI9X8ugd6t/VfNBLy41ntuuGW2u1GG+wOB4xDkbHHISbCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oVdgznY4;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA2606A33C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDA2606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oVdgznY4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9D79AC2AC46;
	Thu, 26 Nov 2026 19:11:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3501B60558;
	Thu, 26 Nov 2026 19:11:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2BCB11E691C8;
	Thu, 26 Nov 2026 20:11:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720282; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MVolsYhpJ+LMj7zbkMJO+vkL7gKe8OaboFkkUgoisuU=;
	b=oVdgznY4cncQO4LxIA6PTOarFbIKnztq2WlsXPDdjaXbCXY8e+CWlxwH+vVgyNHkBmDt3s
	5GBmPDFWdispnQDzsXqSWMrVzAQdgmN2aDXhQY2rBBgaw6spmrya+oGNMo5VK40RCapoXw
	ekJ7zxGX6B6ePRDG6koDzptHe5rdJelTZM+sMZIxxE5cOeD01jg4W2KLawu7mIZjZr96U2
	GaIwIQ8s/C2pttrfvpOnp2wKzpqxuzL2+E+JuUVzoFM5kmpHmgOOb4vK7xNjwZhSSCiYE4
	hGPkphcrkDgjfXSf4VOQl0c/tJBL9nkMMZB/VJGWSZPWTsIiWznDcX37vlkthw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:25 +0100
Subject: [PATCH 06/12] spi: atmel-quadspi: Reject SDR address with DDR data
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-6-ca8e924cca1b@bootlin.com>
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

The controller enables DDR only when the address, dummy and data phases
are DDR. If the address phase is SDR while the data phase is DDR, the
data phase would be sent in SDR, corrupting the transfer. Reject that
combination in ->supports_op().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/atmel-quadspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index c53e0488dcb6..4f3ceef67b40 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -487,6 +487,9 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
+	if (!op->addr.dtr && op->data.dtr)
+		return false;
+
 	if (aq->caps->octal) {
 		if (atmel_qspi_sama7g5_find_mode(op) < 0)
 			return false;

-- 
2.56.0

