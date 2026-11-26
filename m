Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720263;
	b=Y5PfzePN9SMrJnlCyYkkIt6U7OyMmq/aAR0PPzr8X72egJHL+FPponvJKeV7Y7T2XJDs
	 g49O0g6Y8+nte5GV9zirV6FT9GEfhptfudOCzYKZ6dZybLCm6e2N0MgcP+MU1EH0Z780U
	 XlOZOIFuwQHkcrQRqVhxKLxBvTr3ZVtzDdaByguQcfmWCjNIYbzA4tq7lj1GUC2LzIuzC
	 94PMNIvksmlWoMiDMjQ4ky8LP5AKdRchTyfmSLkUUMUra1QRLT4TT+U9kI6G+t0UsG/u7
	 CZMU+n20VVpTH0WWdOrAF243yoMV4EQJ8RZw19UTsFEOyDld/ttjz6IXEGWigrkwjiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720263;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=u/go77fGa6BBlrSXB/4W1ywT2MY9Zfsd5kv0omZx16A=;
	b=vUfE2+iQRAPgSBWMKs/5V+nvDwv8u/fvWvmHBas+QJHCs9MndFbAK61gjPI6tZxVft+/
	 /tHuXMTO6856nLda9wES3Km5rz1NSZYrdRIgmiB68GvJ9IzDVzVI2Lt/YuK4LhfVTpsuy
	 TIIIfT/NKKps8uhQPWpBuZTEO56HIW7z+Kf/FND2kFKulCLbldXzQeyPMAHFi7A/F0eI5
	 uCFXrgdwJuNMckk73xxOFL9Hn/F7wH4hfmN0Is8FzTAoiwntNExvyWCQ3ThLBviasYx69
	 9Riz5tS8mWYr73RbGygymDg3KK/u9r07VvLjj7wBfMYbJMQwZx2ovF/nvkNsb2vnstA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Rcje2CF+;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14422606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14422606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Rcje2CF+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8E9C31A181F;
	Thu, 26 Nov 2026 19:11:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B33D60558;
	Thu, 26 Nov 2026 19:11:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD73111E691BE;
	Thu, 26 Nov 2026 20:10:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=u/go77fGa6BBlrSXB/4W1ywT2MY9Zfsd5kv0omZx16A=;
	b=Rcje2CF+Rc768pJDqRn1xd37LOi2ZIWrxvd33CG/i9GDTQ0Z/EJe+AolhDRapjXHvUkKU4
	PSHE1y7kkqv/OUQU/TIc4jMD2rQuT2wjnvS2u/sgriHXlls4JIwSW3Ni3kXsnhZ5bWctyb
	nVdjMtMlYHzTl6mJsuxFo+Y2XheJr/bn3+JDUH4frs4MhtQ0PVyyWNH3QUyOEkumCYUHLT
	J0yKXlJrC/JniAPkCb1q4N3041OYRixmtCFzrNTdlRI6B4dgEFz9twZ3CTLF0vycvS49RY
	IJ6ZdCUiipuYtudozCl6ZJP9t+Top9GY6XCEdTgXKkVPyGe5Gd08u85xMdREUg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:20 +0100
Subject: [PATCH 01/12] spi: amd: Validate the dummy buswidth
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-1-ca8e924cca1b@bootlin.com>
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

The driver clocks the dummy phase with the data buswidth. Reject
operations asking for a different dummy buswidth.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index d3953de255be..0c56d5b2a6db 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -459,6 +459,9 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
 	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4)
 		return false;
 
+	if (op->dummy.nbytes && op->dummy.buswidth != op->data.buswidth)
+		return false;
+
 	/* AMD SPI controllers support quad mode only for read operations */
 	if (amd_is_spi_read_cmd(op->cmd.opcode) || amd_is_spi_write_cmd(op->cmd.opcode)) {
 		if (op->data.buswidth > 4)

-- 
2.56.0

