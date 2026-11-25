Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629154;
	b=grL+2vBw32r2xIKeCZ/jEQ7IHZr6Tj+1jPYBjWDCPR+qUaU9HHvLTFoQknySIPCI4y3+
	 6xjkHztwLl8FcfvvdDfmXmBkozThYXfM9PUFXqiFZ37OShO/qxIAv/51vmsGMP2Y7+xXN
	 Hvu1P7WCpDiZHiYXpMXAAbt7A2/bmwB6KxuP//8sPLJreZ5wwOHoYhv5fjNN1faKDs50f
	 EaWHTLWzJ2poaxHQtVumpbC/aNpQwzGv9WIbqb6SMMfaXV6ARctHWWxnNLAmu4MDEATvV
	 r15U1ZFxB7ETCvTvI5zIfv19I4szn0iw0pdrH6QzvHgA4yenSIKwD0oeAYjesWPAuCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629154;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=ixszZ7M0PTlVyltcKUJakePlFubDowyK1dd2rUosb7c=;
	b=zXDjbEm52xWzI3xfpv9yZrVkNGc1QFOAJgcjQjSO1IjJEoiWNt91wOlDtYooquMDHXbb
	 r5Bydg10kFEp0h6vmSLv8v+11JWzzCD/DP26zytamCAGtZmRTfM2TsWJRiiF0KIwdPJso
	 PXujH+RJCw44PN6f8cvo3ttOCdSnw421pWieoDKA+DlGWGoKO0UwmFtjqsMdtnjTlF4OO
	 VVM2YtzxNB+GmBKoxWbXOqPQW0rgPoa0ebcTCpHV6Nie2gPY1+j+z+sRlDZY8PMnrKZgA
	 Ea6Iy3MIaHxOOg8sgcju63GX/65ytV6NpzqCYjMkSsCILq8T0SjZRQ3BpYbnF+E9iqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=K5f7lKnd;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2892606A32D;
	Wed, 25 Nov 2026 17:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2892606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=K5f7lKnd
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B284D1A17FD;
	Wed, 25 Nov 2026 17:52:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8543A60480;
	Wed, 25 Nov 2026 17:52:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36F4D11E6B0D0;
	Wed, 25 Nov 2026 18:52:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ixszZ7M0PTlVyltcKUJakePlFubDowyK1dd2rUosb7c=;
	b=K5f7lKndckyVqW7Oldk429u4bv4WzY7Lj1lCMkhTI/QOdQr/M87qeBuLpSAFZQUr+8xpl5
	loh0VZBh2Fm2JaBcNjnlEOq91CpycSzoMnzKKE6e50Dg70I0ydm32AlBhvhypCjWu+8vdk
	hU6H7TWfF2PZjJawR4wTFH7ZZvIw+gnWs5PFfl4dTgknS4z8MeldZPh7JWxNo2KUqy20Ig
	LeIuWWuLCeYQzPUWfLiMJvjhNUw94ohk26HqHQbttU/vVfU2FTf2azJ2Cyx/wuLVe7FAA2
	JGPFzq96IcuSF2HZAiSCxemes67V2qyv7kJnf2BdhG33b0mWY9F30Yn+qgRBug==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:23 +0100
Subject: [PATCH RFC 09/16] spi: microchip-core-qspi: Consume dummy cycles
 directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-9-fd036402fd37@bootlin.com>
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
 drivers/spi/spi-microchip-core-qspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index c0ea65014d2e..2fc1df738062 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -420,7 +420,6 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 
 static void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
 {
-	u32 idle_cycles = 0;
 	int total_bytes, cmd_bytes, frames, ctrl;
 
 	cmd_bytes = op->cmd.nbytes + op->addr.nbytes;
@@ -459,11 +458,7 @@ static void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi
 	writel_relaxed(frames, qspi->regs + REG_FRAMESUP);
 	frames = total_bytes & BYTESLOWER_MASK;
 	frames |= cmd_bytes << FRAMES_CMDBYTES_SHIFT;
-
-	if (op->dummy.buswidth)
-		idle_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
-
-	frames |= idle_cycles << FRAMES_IDLE_SHIFT;
+	frames |= op->dummy.ncycles << FRAMES_IDLE_SHIFT;
 	ctrl = readl_relaxed(qspi->regs + REG_CONTROL);
 
 	if (ctrl & CONTROL_MODE12_MASK)
@@ -601,6 +596,7 @@ static const struct spi_controller_mem_ops mchp_coreqspi_mem_ops = {
 
 static const struct spi_controller_mem_caps mchp_coreqspi_mem_caps = {
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static int mchp_coreqspi_unprepare_message(struct spi_controller *ctlr, struct spi_message *m)

-- 
2.56.0

