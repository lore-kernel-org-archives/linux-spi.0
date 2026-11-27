Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789593;
	b=PwDghJq1VMbaBfMORdt7wWYfKdCYNqrVoUpLz4+Oyrj8kzufTbkQtFUoStp+XeWRM7hS
	 9C3UFwmHyirvjoXQrRw5VHYHa3nhKeE4Wg/BgUkvFcvhztoYWJnEMv5DTVSZLCqIO7dDm
	 4u5RDBqsCCrqL5j7zaSGigO3/fQ0EI3E8IMhx/Fo7aQgcBfIrD9WWBF4a3/lEdze/hgjS
	 9Dgwf78usa0/lwxchEYTsJYNjb85wClo07L5O0fiEMdx7rgLcu/MYGGSZn/DbyjU6YPJP
	 IbcfBfYHSnCCzqW1gp6rx/ziYlryDYslZ5c/+TC5uIOmQD3PsnWEQcS+9ar8fkPwDng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789593;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=y6mtK80FnUhnlIn0Ql1z1lHX72SknUFV1tBVwuKNXKg=;
	b=p3U9z6b0OhqhfdYMo03YEXJqdkWbHc5V6JGSAGIUexmClUwLTBHxBrOEe7IxPFpqX/9O
	 cP8DqgJXXCNZBdi4aR8RqkyafFZ24DvwQA1ZP5q81pID5gTSNQnSKe2Md0sMnCcCjzB8a
	 IE8uwOCkyf4XZ2C7/R4Ds5R7GgejBh1eKQ/9l4xCTMfOaDUIiNA9v5m3WjvicQNmsD0Oy
	 UAtHNHcbEEcnt07n71jAjm3vH4dMtL0luqHqOoupukz5XIzkJDRXylMJezQBzJR/gZ/C9
	 sgMJG3VLVQyCpb1SVAKIeY49NvD945y0s77LL2mLUmn6Or/05chGUrJvAwfxv2BYEkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lQKM2amg;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F594606A6B1
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 14:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F594606A6B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lQKM2amg
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9653BC2AC4C;
	Fri, 27 Nov 2026 14:26:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB1496049C;
	Fri, 27 Nov 2026 14:26:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AA5D11E68FF4;
	Fri, 27 Nov 2026 15:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789589; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y6mtK80FnUhnlIn0Ql1z1lHX72SknUFV1tBVwuKNXKg=;
	b=lQKM2amgQFt+qbow/bVvK97yA20xp4kq016KopWI69AOOJPDun1cwWGdh9I1ulznEOXlVe
	sHTH6JUSlQvNv2Moj+X3Bi9eVGqR9Dg1TTHHJ0C2yf5089OMOSAgquvAMlxnVpOYBr94E4
	kY5lS5VtmvVpqHCGIB6+7dYK04tbU5U4kWY+tUlDpuUCeuarMnQ0Y1zxZbzcdB0/k/Nyyf
	rJt4XrXfZwncPj35KuznnrBMDGnMZxBSqShOOuCcrGxMZBP3ozHZUQJ5QJhbF7smvBGjr3
	KjfjlDP5zKvaLggZerDldAgfVCfbZBPJlKEttuvSQkYTimN7Kkc4XGYjnXl8Rg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:45 +0100
Subject: [PATCH RFC v2 23/35] spi: realtek-rtl-snand: Drop redundant check
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-23-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-realtek-rtl-snand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-realtek-rtl-snand.c b/drivers/spi/spi-realtek-rtl-snand.c
index 61fe54d8167a..e2394842800b 100644
--- a/drivers/spi/spi-realtek-rtl-snand.c
+++ b/drivers/spi/spi-realtek-rtl-snand.c
@@ -54,7 +54,7 @@ static bool rtl_snand_supports_op(struct spi_mem *mem,
 {
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
-	if (op->cmd.nbytes != 1 || op->cmd.buswidth != 1)
+	if (op->cmd.buswidth != 1)
 		return false;
 	return true;
 }

-- 
2.56.0

