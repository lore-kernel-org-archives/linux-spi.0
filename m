Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789575;
	b=w2A9KFl+HWC27pZPPvojxpUEf+JSAmCcMXvLnT58AbtyI0iaQSs1ZCNyfZTpuJa2Y1y2
	 S+/zd0iyFbYzlmeye4gga1o1siX7E5F/m26uN0sWTmcs+jXC7SRZGxzs3H+97K6WJe2QN
	 ++UfKOEjq+bmFoYqWw8PErkjSwqNyKSeNZUmfA7+Bv9961npiagu9lyqVWrLvsF1UICb+
	 uSMge42t/RNvT9HW61yZ96PgAy5kA4ql9O59NERRYqP76qoLC4D3dxZa5bB33f6zFoV5k
	 VhEBt9Vw6Ss2kx40BOtBPwK9Di5VAF6n14+MqtE/hC96JYOqYkWOurrOw2/WRN6OyBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789575;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=AoxU+JhvKBTXrYbtTbJzsGk9QEyditaab6z3oGK2TJY=;
	b=rDAV+at5JQ+CwXwwfU8KN6cYG5LrpBgCZK9badnyuIck+tBvBK84dIfsAYnyyaowQILI
	 isEneABFmLlqhRXhnUwWRM3COOX7S7YsVRz7f/LALe3HDFILaoyqSy/st05hEBZE382cT
	 43uvwNnQdZwdb+3yZ+eEwfXmAHG0uo09+trpvBl5nWtN20G6HlAmIBHDohuevhnHXfx0m
	 vrC0+ytNHVhyKKoACNUsNk43om1cR1gOfj3Xo9luyN+AQuv3ETyYAlqqwwc82+Iv2VjZj
	 sRBiOm+s145MPoD92TkYwc+9aiiphg1Ov0u4XHrb04AemEYLdBcks3W/q8wVJCc3ReA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zAkwwjJh;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34408606A686
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 14:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34408606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zAkwwjJh
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E1E081A1838;
	Fri, 27 Nov 2026 14:26:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B32536049C;
	Fri, 27 Nov 2026 14:26:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC5DB11E68FF4;
	Fri, 27 Nov 2026 15:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AoxU+JhvKBTXrYbtTbJzsGk9QEyditaab6z3oGK2TJY=;
	b=zAkwwjJhwVG0zSV6YA46JQojW1bolXRH0EAHLZlwyqXLXtk9FaxqcsUZKb+OQ07CO9PpA4
	KfDre7rmcmytfCYVyYQ/OPPYrgRL6OYfPg+JczDL2rRTLqgsiKqd8JeYHfs7JrB8GOsNf8
	kl17IMq1kAfobSqitEG6cidb+v+vQDJ85/q88WXuQEB+rNQg8RJyVPQA6f+UfBnf4WRIBc
	IGFxwV1X5/oObK49PmVtOCrbpeahRDC87AewuGKejSG2iCgDQZoLexg4JQdwtq76TRMFbI
	pA+e5j/GlD477cxLSbyqWFl/HVZGTzoDgvxYow1S58Kv/pjmgX0fa86bkaMgpw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:43 +0100
Subject: [PATCH RFC v2 21/35] spi: nxp-xspi: Fix a comment
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-21-5c93f5e5d630@bootlin.com>
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

Looking at the i.MX952 TRM which is I believe one of the SoCs with this
controller inside, the maximum number of supported dummy clock cycles is
64 and not 32, so the code seems more accurate than the comment, which
needs fixing.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-nxp-xspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 8b836662a5da..ccd00c744d18 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -407,7 +407,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes > 4)
 		return false;
 
-	/* Max 32 dummy clock cycles supported */
+	/* Max 64 dummy clock cycles supported */
 	if (op->dummy.ncycles > 64)
 		return false;
 

-- 
2.56.0

