Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629192;
	b=U6Pmx2E6yDrj0uC1tARWx/KNr1Q+yJo+uObH6YM6zAymxNE08REsgH8s42+jwZ7KuljI
	 zirHrzL5gTuuZTb+b2WcRXd3pdu+UcANdqZnD3R6fbMTFlPn0wEj/OCbzZL3T9XlSkuIr
	 MYmRzNEsIzZWGPmGjf4J5+v2HkRsnn1cTOfQIJ2K/Ezeg1u0B1FOs4vrR7/VUuo9+CrtC
	 o/H8OjVUPCseVXBX96S5zsYzRkYjist2nM1LJCyluNr7AzlGmWSTWkLM3NBmRpaDeIWjX
	 DP/lwmC5uuxWUyQLPlSdR37gqHj/W6z3vPmabrjr3D9GUpQ5BxwdlBeGYev/8kdHKLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629192;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=4e/RWoOHhDL2sVy5LbDO8W9W8W0olcvrU1DPDGSNAcg=;
	b=nqaPyzHmHmb/mwAyjJwiRzd+F+UukmUuPGt1ooIJ9jd/6Be4dHiMU3+s0T+aoBTpNOb6
	 eRDV99j8xt/AAYgSm/bjne6BgKCu697LBPmV/MRGXffm7EHxpmgKzBKXJHqy+mEx9ugxw
	 IqM7s/R58Ld3i/SL1mR5UfNuqxIekZlTvsMWnUtmccEnLc2g9yeQvClKQXM01AFQnQN6t
	 DB7d1lgwBxb1hEq98v2SslZyAjY5pmJnrfdokNuECYG4btqwWL6CtxQeIMVbyH1qfvPdw
	 8zeE+6fPri7TzhIyybTW5VEchqNcLXTIQpIfPvqhpzxyQoZnGSnTJQWGg6e+aw+h75A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0I9axvAt;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D160A260C
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C11D160A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0I9axvAt
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A21201A17FD;
	Wed, 25 Nov 2026 17:53:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6DC9B60480;
	Wed, 25 Nov 2026 17:53:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A31611E6B0CE;
	Wed, 25 Nov 2026 18:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4e/RWoOHhDL2sVy5LbDO8W9W8W0olcvrU1DPDGSNAcg=;
	b=0I9axvAtYjofLkkZCOhpkZRXZO9wrCEJ9W8xd0tJka7dFgvXC9ZZM3ONe8yTXqcbmWdvmU
	2u0mC3vpvM8T1YH13qF+TwMiyqy4HUMouxTgv812jL9BdodUDrmSJh+5DlxTB8eTJWCkCp
	rDMjiGhgogKRV3B9FSVGqeE/jtnNyClRK3hFiSQ+x1v0LB3Ej1kjp8qdQT5IkX1KUGcV90
	iqn37JYOcUO43avU/it4dEEZ25Lu3wpqlZW6pfJQNCGZfSnkv1IJuCRH3HVTAYlePx5now
	YOLAwRlHqdIagHAqfLWoZE2oNxTwIAlohyg3QGNtn4pIx4KhaFiynLXm3ndyyA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:29 +0100
Subject: [PATCH RFC 15/16] spi: stm32-qspi: Consume dummy cycles directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-15-fd036402fd37@bootlin.com>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The spi-mem layer is now capable of providing the dummy phase in cycle
units rather than bytes, provided that drivers advertize the dummy_cycle
capability. Since this controller is consuming cycles and currently
converts bytes into cycles, flag it capable to consume cycles directly
and drop the extra conversions.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-stm32-qspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index b77daba6db83..993b09cc5124 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -393,9 +393,8 @@ static int stm32_qspi_send(struct spi_device *spi, const struct spi_mem_op *op)
 		ccr |= FIELD_PREP(CCR_ADSIZE_MASK, op->addr.nbytes - 1);
 	}
 
-	if (op->dummy.nbytes)
-		ccr |= FIELD_PREP(CCR_DCYC_MASK,
-				  op->dummy.nbytes * 8 / op->dummy.buswidth);
+	if (op->dummy.ncycles)
+		ccr |= FIELD_PREP(CCR_DCYC_MASK, op->dummy.ncycles);
 
 	if (op->data.nbytes) {
 		ccr |= FIELD_PREP(CCR_DMODE_MASK,
@@ -593,7 +592,7 @@ static int stm32_qspi_transfer_one_message(struct spi_controller *ctrl,
 		 */
 		if (transfer->dummy_data) {
 			op.dummy.buswidth = transfer->tx_nbits;
-			op.dummy.nbytes = transfer->len;
+			op.dummy.ncycles = transfer->len * 8 / transfer->tx_nbits;
 			dummy_bytes = transfer->len;
 
 			/* if happens, means that message is not correctly built */
@@ -773,6 +772,10 @@ static const struct spi_controller_mem_ops stm32_qspi_mem_ops = {
 	.poll_status	= stm32_qspi_poll_status,
 };
 
+static const struct spi_controller_mem_caps stm32_qspi_mem_caps = {
+	.dummy_cycles = true,
+};
+
 static int stm32_qspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -856,6 +859,7 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	ctrl->setup = stm32_qspi_setup;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &stm32_qspi_mem_ops;
+	ctrl->mem_caps = &stm32_qspi_mem_caps;
 	ctrl->use_gpio_descriptors = true;
 	ctrl->transfer_one_message = stm32_qspi_transfer_one_message;
 	ctrl->num_chipselect = STM32_QSPI_MAX_NORCHIP;

-- 
2.56.0

