Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789546;
	b=O1qo0Dv2fAznMC2V32ZJ06w0gQ6vt1p5nciqMu/lN0dV3hP/iS+v9msCxN9jaFJtMEak
	 gBQVb/EYVIX0oZ1ENfcDVCr+k+v9dH+uoucZ2fHDjUhcV6l3At3MB2Hi9bBUYOmxD2/Kt
	 pnEh+LOvo25UqbX/nUm7N/s/gTw3XkaZJcNR8nXjWJ2rnvdyS/yDMaRHWaZPZZm+gQZD5
	 J8VE81e1ZM/KARco7+uJY1CNltuQEMOKjNqmMSLIt+8icxNEil+IndrEpzyTCbWrO0Ryx
	 8xMdKnh8gB3KnappQUeC5O41QYH4f1gJlzP9Dc2XSQBmECtsWBkWT86vpsb1HDZAVHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789546;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=itr59vks4zx4d5lnDDhWZZRn0Ff4Dta53BrZPgDcrec=;
	b=EAdtsXhmiOloMnsKAWdmcbGwPkuCpMcIcQ/Q30pnnCPX+qcIvDhfVlOgMj85zdyjRnNL
	 FURNQZaNAwkB9NcppLfRT158QvcSgxCsqZ/TYQI3F1awmMh3dezgbCz3gTVcC/lDxsphu
	 VmpoxLW9o5lhVtDMe2nou+CHIcBZN2/ZpgRs7XOi5NeRHbhZJStVbSa0MkTtqHKDF5n8A
	 c2v13BxnICJbtyiTbLjnWQWvt9LTZ/sqsl8AAvP5JmTo6CEx6NLJhZhZc8i2gL6MRguWc
	 byqADf93npd7wAT/ovgpySKQpeXhr9aSi0Z/KeD+iCcFFD83yLZST8t55NrwjYM29Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wJjlxrXN;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB8606E120
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 14:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2DB8606E120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wJjlxrXN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EC89BC2AC4C;
	Fri, 27 Nov 2026 14:25:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2594E6049C;
	Fri, 27 Nov 2026 14:25:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4210711E69021;
	Fri, 27 Nov 2026 15:25:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789537; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=itr59vks4zx4d5lnDDhWZZRn0Ff4Dta53BrZPgDcrec=;
	b=wJjlxrXNjmNI7oE3odshRqej/oKORm9WSxGYrkKZQBZSCTl5Bjn9zL/qGpty4WIge7yr5a
	/L26wF3D/dQItMQB0Jw5p/IxgXTErNHXhTGZiKdfisq1jB/WN0Y6kDX6XFrhdbaCFrazRe
	RNpFLWShejl2BQq7qoq+09Ptu5YW9vbQicS3L6PtfQWaEJ8fCWsdeH+K25P8S8EtV+0nl3
	xTgql+2fCasgqNChE+Ea21XoHtz0PdGidJJlE2/qqMsd4o0UoJm7t6bbGdeSxzciRTHGt/
	BXcC0xn1a+9K7eihG2pP4tpcw2yppEQf8yZK2q100Bhz/brnsRdBRQE54Z7SFQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:39 +0100
Subject: [PATCH RFC v2 17/35] spi: mtk-snfi: Drop redundant check
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-17-5c93f5e5d630@bootlin.com>
References: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
In-Reply-To: <20261127-macronix-upstreaming-spi-mem-cycles-v2-0-5c93f5e5d630@bootlin.com>
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
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 linux-trace-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 openbmc@lists.ozlabs.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The core already sanitizes the spi-mem operations, this check is
redundant so let's drop it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mtk-snfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 6e96e50fedad..882c64341e6d 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1243,7 +1243,7 @@ static bool mtk_snand_supports_op(struct spi_mem *mem,
 {
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
-	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+	if (op->cmd.buswidth != 1)
 		return false;
 	if (mtk_snand_is_page_ops(op))
 		return true;

-- 
2.56.0

