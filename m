Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629168;
	b=MwppaUIVQcawlwXIQkzRJjr3E0z+m5yFcze9FmqDIiM8v0DZZ9as8wSy3F60mAD+NfzT
	 ZLQ0S4JLDfaoE4IKGIe7+/IAAC2yuwyCmBAFPsKjcrLIwZMGzyHzasyzm3lPKfbT0xNMZ
	 pCHQvAYb7X7YtR0qOhcQdLgFWg3xfZBOmo3tauoWc0g9grnJHFNqhiGJDeRv6BHSmHeMP
	 ll9QzaMuGscqzsOysUiycnAvVpkT+OTJZ5/bvv4UNS04W6WzAt9SAWMJHHFi1KiRERrlc
	 ZSThdPst0dg0X/itZfQ28QoydKzXQno/s9t9p6g4DyP0QUiRbph5BKNdRivVznDNzNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629168;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=3kouSNyK9R23I+qZ3mr2DQ2vQHuvZbqCaS8A5GKpSiI=;
	b=DBPtaHaOYO1DuI4K1f8DA+ZT1JOCwrbIVsWksK5+AeyFuFvr4PxoFlnxZHThW+k6XMu6
	 6iB6f2AkG/R9nMmo1rFOu7asgA9EdgR7xfOmx2vs1xdNnkHiT37RCLoimLSV6cwN3dbHH
	 LcEblxu0zw9Xj2W/nXxBz3gezBqNbzY88J9YYoP5QeCUnVBz4QW0aj5Lg/yEy2ylF68BM
	 TaPOFl7MGNsrlzM8YnsyKjviVm2ROgs5YUw/sd4dBmhbfzoyMojm8DChy0AlHMk+hficW
	 c6i0GnGsReTvi3CestMtp7qoye1/HNbRwtVISF4+P07zYkho0YjCe4rLO9dKMgV38dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RYp9veoh;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23890606A339
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23890606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RYp9veoh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 033911A17F9;
	Wed, 25 Nov 2026 17:52:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0E9260480;
	Wed, 25 Nov 2026 17:52:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B65A11E6B0D2;
	Wed, 25 Nov 2026 18:52:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3kouSNyK9R23I+qZ3mr2DQ2vQHuvZbqCaS8A5GKpSiI=;
	b=RYp9veohHs2JdLBosL+OsjxwlR5ySlzQOAAtmxVHB0PF+kGJfjYwbk9Zr8zNeXJ6OlEbgv
	6zMyoPjAOXUJULNnrP5XuerZtky0pwNWlOa/oUwIASW95rOPRxAwmAdBoEfqWhjloAAkRz
	+af48+G//LVpdAxvoMbQb1UibBI5CwcDQtJVmcpSki4kh3KMYcxwHtCgaBDn2SKGwmhk12
	Ayf5LyU9tRq5MLbV+cfO5AoxQxPhP0QmO9Hhnel5CvxyUPfGLyrWQpzO6gCul208u8Whpu
	KTRVmtC3+gA1XP/32Aztz+aRTBVY/MvNjItZCiK/GLlZt6TFoHBApm7tO375vw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:26 +0100
Subject: [PATCH RFC 12/16] spi: rtk-nor: Consume dummy cycles directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-12-fd036402fd37@bootlin.com>
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
 drivers/spi/spi-rtk-nor.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-rtk-nor.c b/drivers/spi/spi-rtk-nor.c
index 55ea7c371854..6febeee2541d 100644
--- a/drivers/spi/spi-rtk-nor.c
+++ b/drivers/spi/spi-rtk-nor.c
@@ -92,18 +92,10 @@ struct rtk_spi_host {
 	size_t			dirmap_size;
 };
 
-static u32 rtk_spi_calc_dummy_cycles(const struct spi_mem_op *op)
-{
-	if (!op->dummy.nbytes)
-		return 0;
-
-	return (op->dummy.nbytes * 8) / op->dummy.buswidth;
-}
-
 static void rtk_spi_read_mode(struct rtk_spi_host *host, const struct spi_mem_op *op)
 {
 	u32 opcode = op->cmd.opcode;
-	u32 dummy_cycles, val;
+	u32 val;
 
 	if (op->data.buswidth == 2)
 		opcode |= DUAL_MODE_EN;
@@ -113,10 +105,8 @@ static void rtk_spi_read_mode(struct rtk_spi_host *host, const struct spi_mem_op
 	val = readl(host->regbase + SFC_CTL);
 	val |= RW_DATAEN | ADDR_EN;
 
-	dummy_cycles = rtk_spi_calc_dummy_cycles(op);
-
 	val &= ~SFC_CTL_DMYCNT_MASK;
-	val |= (dummy_cycles << SFC_CTL_DMYCNT_SHIFT) & SFC_CTL_DMYCNT_MASK;
+	val |= (op->dummy.ncycles << SFC_CTL_DMYCNT_SHIFT) & SFC_CTL_DMYCNT_MASK;
 	writel(val, host->regbase + SFC_CTL);
 
 	readl(host->iobase);
@@ -192,7 +182,7 @@ static int rtk_spi_command_read(struct rtk_spi_host *host, const struct spi_mem_
 	size_t len = op->data.nbytes;
 	loff_t offset = op->addr.val;
 	u8 opcode = op->cmd.opcode;
-	u32 dummy_cycles, val;
+	u32 val;
 
 	writel(opcode, host->regbase + SFC_OPCODE);
 
@@ -203,8 +193,7 @@ static int rtk_spi_command_read(struct rtk_spi_host *host, const struct spi_mem_
 	if (op->addr.nbytes > 0)
 		val |= ADDR_EN;
 
-	dummy_cycles = rtk_spi_calc_dummy_cycles(op);
-	val |= (dummy_cycles << SFC_CTL_DMYCNT_SHIFT) & SFC_CTL_DMYCNT_MASK;
+	val |= (op.dummy.ncycles << SFC_CTL_DMYCNT_SHIFT) & SFC_CTL_DMYCNT_MASK;
 	writel(val, host->regbase + SFC_CTL);
 
 	return rtk_spi_byte_transfer(host, offset, len, op->data.buf.in, true);
@@ -346,8 +335,8 @@ static bool rtk_spi_supports_op(struct spi_mem *mem,
 	if (!op->addr.nbytes && op->data.nbytes > 1)
 		return false;
 
-	if (op->dummy.nbytes != 0) {
-		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
+	if (op->dummy.ncycles) {
+		if (op->dummy.buswidth > 1 || op->dummy.ncycles > 7 * BITS_PER_BYTE)
 			return false;
 	}
 
@@ -464,6 +453,10 @@ static const struct spi_controller_mem_ops rtk_spi_mem_ops = {
 	.adjust_op_size = rtk_spi_adjust_op_size,
 };
 
+static const struct spi_controller_mem_caps rtk_spi_mem_caps = {
+	.dummy_cycles = true,
+};
+
 static int rtk_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -535,6 +528,7 @@ static int rtk_spi_probe(struct platform_device *pdev)
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_TX_DUAL;
 	ctrl->bus_num = -1;
 	ctrl->mem_ops = &rtk_spi_mem_ops;
+	ctrl->mem_caps = &rtk_spi_mem_caps;
 	ctrl->num_chipselect = 1;
 	ctrl->auto_runtime_pm = true;
 

-- 
2.56.0

