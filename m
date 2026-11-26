Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720304;
	b=VH+5toCVP7mxeWKgKZppWfY13pMLpv6rvTPhk6PGZV4S9wPx4JUiiUlACKvU/34LFkds
	 uqvITebfsE7vxMo+WkVJlF4rjyDJ3JBg6IFxx3nsXlHbKsGMBYQf6cOwa1o61Ecgk/BwP
	 YHvGUwpVw7scTj0/6hSUcgmiVoj39yq9JVZ0z1GYZc8hfkxTaUpEgqdFBZmXxgPWq3s5d
	 M7RJQZ+m2BcsxbJbyI4jln/Ht3tz5Wx4S8B6i5ZtpUHbHnQX5yQXSdyaHx3fHalS4F2IK
	 7fUdp7TXjTwjj/JvAANfJlxqfjmFwq492wXO9WsRFrEfYGiAla7ekIrMTB1Xi9o10/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720304;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=8RwOkiBgdob7aGlWh1hftNQ45yEu/EtBNJWgoVSYZUE=;
	b=w7wAbGm1aOpK1RLET13ySH8Y1eZblFBEd/wcSHqY5qfkWR0XgsK8ObNRuVHEdUnuQE4H
	 TjLaq0BZhXvMDxju8TP19mPODFoBFAu1eplCb/gU3poIcpQAj2MXBWbxQCDK2FAYXy3Sh
	 3+cEgn6CxRFS2wJgll21JR/d3iaGCqC7UZ510ysZzqUOG6lQbQ9Q7ujZwTov3V55HL5BR
	 F7pNouC0RMraMFyqeMPSucWAvpMkgNftca8Tl/BlEUWQF3musLQJxp66Q67KU0mETPiHK
	 oMPSzKW4XULb1X+ifMDSaxjnPPrX6uIoWb9nVRExeUUdfNj8dP8QE0xjRvMxyRgiH8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FsgSmLkq;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215A4606A330
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 215A4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FsgSmLkq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C860A1A181F;
	Thu, 26 Nov 2026 19:11:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DA3160558;
	Thu, 26 Nov 2026 19:11:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FC0711E691C3;
	Thu, 26 Nov 2026 20:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720300; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8RwOkiBgdob7aGlWh1hftNQ45yEu/EtBNJWgoVSYZUE=;
	b=FsgSmLkqIh1A+50cmPoHi/cW3fRJtzziB9KEtJx5k+Xw4NEYZXvjfjXzzKkKuRrcq8eJig
	4N7fFZNMTa4/ejSp9TCuLiEhlmaT3M8zsfaQO+3FE2PfKIQ/AsScFBgPeIFsG4629PTxAU
	riWH84mIxb8b55jqIYCmSiXvOBk9SfwDk/LcTQ4f66IQjE8I2qj04zEYQ/H4CZcvQRYess
	tlEYk5t3wIp/lUnXxmDGyr40x2BmLD5sDrznJ29BaKoBR+7NLTYG9brhK5h5kiA/XXuqpl
	H4J2LdHnpDbaPqd/dc8eGIozll5Ulo8wlJIWynr6uLzrXN1jzO96NI7ittgU7g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:31 +0100
Subject: [PATCH 12/12] spi: zynq-qspi: Validate the dummy buswidth
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-12-ca8e924cca1b@bootlin.com>
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

The driver sends the dummy phase as a regular transfer on the data bus.
Reject operations asking for a different dummy buswidth.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-zynq-qspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index bfcbcfe85b91..6a845a73e74b 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -233,6 +233,10 @@ static bool zynq_qspi_supports_op(struct spi_mem *mem,
 	 */
 	if (op->addr.nbytes > 4)
 		return false;
+
+	if (op->dummy.nbytes && op->dummy.buswidth != op->data.buswidth)
+		return false;
+
 	return true;
 }
 

-- 
2.56.0

