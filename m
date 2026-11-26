Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720269;
	b=Gh+ew5W3qikc6SGx2+lUV7x4WtQHqQNeA9Jdx3cUS0+XWP9N6/xA+2L1Bgg1SDKEyAnD
	 nM6LKGPCmZkMjtGMnYOavUxpDuqH3UuvleCUJhnwkSJRztfpTLmBTzFQyB3Kd2ZBarbx0
	 yhzImsyta8N12pUq6m/52e+NgCxAyTk401yyal4rcPe5QcvbG729LwmonE4b1lyvnfkrL
	 Tukysm/h2KtO+j1N2523vrrIvM4+SGm+WqxgbgsUJp3lBn1YpnrKQODOUalvYkXbpO75A
	 M2Sf6gy5zEUbZqUuIqKcJgWWUoWHrHT0bI4IweGpppNb4Fco98ny+Wy5DlWhMl7yAZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720269;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=/M+HfMNi3TcbhGwOrAuJ9bcXyilkjFKwqsxMBnv5EpI=;
	b=1uhNrmYUcsA+6IhJ4jmpB6sL4RXyL7cjehgnyIDGzVqqf31KLDdimqNQqB0xNsZJ8HY8
	 wh1GqSpZ6CBE/BiTKyy+YEv5HZ9Brb2RO+cVBE+kUv3k2yhYgZT5BqpIRjWdfHUb8ND84
	 TK80SWdo2CJ25KQmAexuUGw0ilMjpgi2fgZIGGOD1mBx63BnJUHrghVbh7cbiuJ4S4kPa
	 oIebt7T/YFPDzCSrrKGUpt9ttOj6zTj0RmrmSIUV5NyrknhBcxyRK4kQx8pyla3aeZIcu
	 MiJo7KvaFKnjHBsoRZ0Ia5J3foqkR3VnIs2bIEQf+cIugGNA2uRHaHJMdK3K4jjUbng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Mmv91+qO;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63518606A31C
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 19:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63518606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Mmv91+qO
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 687BFC2B9E2;
	Thu, 26 Nov 2026 19:11:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0073F60558;
	Thu, 26 Nov 2026 19:11:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7E7211E691C2;
	Thu, 26 Nov 2026 20:10:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720262; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/M+HfMNi3TcbhGwOrAuJ9bcXyilkjFKwqsxMBnv5EpI=;
	b=Mmv91+qOiLKrIGNBpZKd6M+eVyf+7sO0JRHY0vUhU+ENb3oO0WfPB99X2BHhnbihfSmm0J
	v6V2vLx93smS0GkTp1XPcMcMunQA9ifroOL8gmYvVJO8lBDcWRPrpiAlWz9Wf6hfglZxGr
	Bup9d9XxjNiyms+qumpmt0iiXT416j/CPONuMU5HusooMDcIRhECS3iAej4+nHqIi1LNEH
	zRUurl+UTTCfPacswOM94xvnPc/Y4DO5w1CaDoIowe9ficpWxPNb/T5N7QqZS3U+q+dTSO
	VbT5eemGG7ygC7Tic7RdvcnGwM99CX+AF3C6NtKCAnuzA9VJZLg3wPaZKSWTwA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:21 +0100
Subject: [PATCH 02/12] spi: amlogic-spifc-a1: Fix a typo in a macro
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-2-ca8e924cca1b@bootlin.com>
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

Correct the macro name: sycles -> cycles.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amlogic-spifc-a1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 388bd2472dc0..c7cccc8de6dc 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -43,7 +43,7 @@
 #define SPIFC_A1_USER_CTRL2_REG		0x208
 #define SPIFC_A1_USER_DUMMY_ENABLE	BIT(31)
 #define SPIFC_A1_USER_DUMMY_MODE	GENMASK(30, 29)
-#define SPIFC_A1_USER_DUMMY_CLK_SYCLES	GENMASK(28, 23)
+#define SPIFC_A1_USER_DUMMY_CLK_CYCLES	GENMASK(28, 23)
 
 #define SPIFC_A1_USER_CTRL3_REG		0x20c
 #define SPIFC_A1_USER_DIN_ENABLE	BIT(31)
@@ -90,7 +90,7 @@
 #define SPIFC_A1_USER_DUMMY(op) ( \
 	SPIFC_A1_USER_DUMMY_ENABLE | \
 	FIELD_PREP(SPIFC_A1_USER_DUMMY_MODE, ilog2((op)->dummy.buswidth)) | \
-	FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_SYCLES, (op)->dummy.nbytes << 3))
+	FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_CYCLES, (op)->dummy.nbytes << 3))
 
 #define SPIFC_A1_TSLCH_VAL	FIELD_PREP(SPIFC_A1_TSLCH, 1)
 #define SPIFC_A1_TCLSH_VAL	FIELD_PREP(SPIFC_A1_TCLSH, 1)
@@ -195,7 +195,7 @@ static void amlogic_spifc_a1_set_dummy(struct amlogic_spifc_a1 *spifc,
 {
 	u32 val = readl(spifc->base + SPIFC_A1_USER_CTRL2_REG);
 
-	val &= ~(SPIFC_A1_USER_DUMMY_MODE | SPIFC_A1_USER_DUMMY_CLK_SYCLES);
+	val &= ~(SPIFC_A1_USER_DUMMY_MODE | SPIFC_A1_USER_DUMMY_CLK_CYCLES);
 	val |= dummy_cfg;
 	writel(val, spifc->base + SPIFC_A1_USER_CTRL2_REG);
 }

-- 
2.56.0

