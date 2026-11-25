Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629182;
	b=dVi6LL4NzL/V+jQZ7JX9+rmOSYjSutNHcQEcljUkiPN/cvWRVp2odb0Y1LG6Hu4n+zom
	 jEU3Dmb4VV2GRGZbvDENMQxNkM6dopBN4IjRRvPfiFT7Y4zahp7v43MANESMAhTBaanAr
	 QZcjvkj7MP2Of7CKCWr7kr1uENOGoNjOY/ZqpMK9sFj+0WVRHsiGVeIq0QJGYjso0q9eb
	 LdmKZ0eXwXlBB+/gug0D9DEpocOJf72uGM2jt4wnYVBoGA6LOa4+8QwPFBU2+nl622Dd0
	 4K3QnkfjXZGvtCBXqOSkBYXaAIWccAx+q1ssAnAqKJPMaq3AvU+AYDUieFACeNJlBPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629182;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=JCAVXopcRhsu0R7W2AJRcPS4xlZfnpyxLhZGemjrQaY=;
	b=nf4E6uXj467sYrbaWRVHvQpdY4WfDqFE9mYZH630zWoKkq77FSC/iWB/+Ud0PGF+ljdm
	 anASMzQmlmIp1aI+9igXrhRC7lpCV17xNpFBVe+6fLy6fcIA1pEh6IwLOZ+w2NURdzPZr
	 UY9n+Vja5MjBmowoota9pB5R/EjNg8ip/x9r2P/RO+muPGweLisYaegU0PbywzU1cfeit
	 3Udss2VO5vZxELVUA25lRSQcsxNcCcHdJAmOfbjQnUcw+CKL+XGWfGc0Xpds7RiBt5Iox
	 zZzVWXHIpi+pjukn6wjAbAsDOouXjr4WLkm9o8eH7IjDbR5VxiFv6T0yMMF/mHVfEmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KYGCCatk;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA61606A326
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DA61606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KYGCCatk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 41B144E40B00;
	Wed, 25 Nov 2026 17:53:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D09660480;
	Wed, 25 Nov 2026 17:53:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA5F911E6B0CA;
	Wed, 25 Nov 2026 18:52:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629174; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JCAVXopcRhsu0R7W2AJRcPS4xlZfnpyxLhZGemjrQaY=;
	b=KYGCCatkpDwAP39xFucHg5OhSZCQx2BzoSiOJhGTIvhyjU0iH9MR3Nou9ORwOoHqcQnXWZ
	k8WtGng3n56RvyZGJYrcqIQmYvx22XJkDzMlShSyJBKI1pVqipDqav+hHfIZm2R/LFJK3Z
	R6orNWggySMk4Bc/p8PcSNb1BxXblXaYw9rHsTY/CnCvJeuoEbwAJNPf2WEx0KM/Hyp5pe
	0hJTCcMIveklGb7007f++ldutFB9U0ere1MsT+1fGqCRqCdDgCnONrX7FzjaT87hZFmq75
	e8h0wMhWaaGOEr+pML/ay1JGJuzjfo0QVZXl39N8Dn+JQqgG8evHxLIQmzJ6BA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:28 +0100
Subject: [PATCH RFC 14/16] spi: stm32-ospi: Consume dummy cycles directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-14-fd036402fd37@bootlin.com>
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
 drivers/spi/spi-stm32-ospi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index fa0e8e83cb1b..9b28d1f24482 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -492,10 +492,9 @@ static int stm32_ospi_send(struct spi_device *spi, const struct spi_mem_op *op)
 	}
 
 	tcr = TCR_SSHIFT;
-	if (op->dummy.buswidth && op->dummy.nbytes) {
-		tcr |= FIELD_PREP(TCR_DCYC_MASK,
-				  op->dummy.nbytes * 8 / op->dummy.buswidth);
-	}
+	if (op->dummy.buswidth && op->dummy.ncycles)
+		tcr |= FIELD_PREP(TCR_DCYC_MASK, op->dummy.ncycles);
+
 	writel_relaxed(tcr, regs_base + OSPI_TCR);
 
 	if (op->data.nbytes) {
@@ -691,7 +690,7 @@ static int stm32_ospi_transfer_one_message(struct spi_controller *ctrl,
 		 */
 		if (transfer->dummy_data) {
 			op.dummy.buswidth = transfer->tx_nbits;
-			op.dummy.nbytes = transfer->len;
+			op.dummy.ncycles = transfer->len * 8 / transfer->tx_nbits;
 			dummy_bytes = transfer->len;
 
 			/* If happens, means that message is not correctly built */
@@ -784,6 +783,10 @@ static const struct spi_controller_mem_ops stm32_ospi_mem_ops = {
 	.poll_status	= stm32_ospi_poll_status,
 };
 
+static const struct spi_controller_mem_caps stm32_ospi_mem_caps = {
+	.dummy_cycles = true,
+};
+
 static int stm32_ospi_get_resources(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -933,6 +936,7 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 	ctrl->setup = stm32_ospi_setup;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &stm32_ospi_mem_ops;
+	ctrl->mem_caps = &stm32_ospi_mem_caps;
 	ctrl->use_gpio_descriptors = true;
 	ctrl->transfer_one_message = stm32_ospi_transfer_one_message;
 	ctrl->num_chipselect = STM32_OSPI_MAX_NORCHIP;

-- 
2.56.0

