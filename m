Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789489;
	b=MD71po4T3yS/8uihRgS4s3BjmrhPrZ8gpN76TqnOETSwkLRkgFSL3VOGKqizJwLGLGSq
	 Vg5iGdkQ7v6i3PKddbnYMfBPsso5uAuvLIBXaRuVD1TIh5QtpizpXJiebBns4QoL4tQCS
	 D7P/+t+2F0OM4fZ0pubIRvKmQlEVA9V/YOH+KPtUXQS7wcPoBdFX1VrRbiPuSRZwAEVpT
	 juwhTgnqCTfo46UKjjad1LVAmffmT5KSKaETSm4KeZZV19KCMWaheKboOIYcZBTGq2x+X
	 v5iOvyyqyPKm0V2USQbcaClaMtVdwkID4bU+Go9r/Sz2OOz07iYMNRTaaD5B6qk6QYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789489;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=M2k46SqZeFAHhImutX8AfiF7k/5VtRokj0DSCN0ndaQ=;
	b=J1T3gVLK6eDJhs0vNkLeIe203p7a6n7WDPffC1psIbj1xVtQ5dY6MGc1VedSxzihDiRI
	 Mf56I1Qv2zSo4dAb4GIZsqFZCh6r4pEVnPe9YRE19/1zJCE2K3ThniF7L79X8u7SXoLoT
	 8GUVy4B9vWnOF5JPXAhjslXVUetyevFbr72ywFQxY0GEFTkmpMZp3o6BdFjNvxf+llNyh
	 irpPNLWKzqMqdW76KRiSJMTvX8C3hNNNj0z8TkSIrvNHXBj3MBD8J9oKYkCQsYqCwUOf6
	 lkzvqj7LBugKlodtTxhA3nwjA+FneHd4G1/bgBTxmgi6ONi7Iu1ZjBJI9le2Ay9ubSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="qLq/w5HZ";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E02606A69D;
	Fri, 27 Nov 2026 14:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E02606A69D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qLq/w5HZ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E466B1A183B;
	Fri, 27 Nov 2026 14:24:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B61366049C;
	Fri, 27 Nov 2026 14:24:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C17DC11E68FF4;
	Fri, 27 Nov 2026 15:24:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789485; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M2k46SqZeFAHhImutX8AfiF7k/5VtRokj0DSCN0ndaQ=;
	b=qLq/w5HZ31eb10uUhvMBpLQ5NKAns3tpw/zvBm1CjdBwKY6wum6rePPCIU6Qx6jQ7XlGJh
	ZLLUQTX+BUv/bRtoN5wBzgzRON8u75S5IZXVCmDh5lrqqVehTytTe+9hhyeP0jC7R9Az6J
	ewDDWqzH6IFrt5FH7NpaH4PpzR4qtVuCRgw9EP8b9dpukz12WH4JaYoDIaJmqQ8cOhxffw
	gN9LpHygIsYKbavexGfIueJdC9XGDsPzwTeqxnzWNML1EMEVTCaV9swLofwZFzS9vmaPcT
	lKNF1VjGcTLnrExFNasva/MMGOxKlR9jimuKh7muUV0nQ3ii7KEL2FVlwf97xQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:33 +0100
Subject: [PATCH RFC v2 11/35] spi: atmel-quadspi: Reject excessive dummy
 cycle counts
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-11-5c93f5e5d630@bootlin.com>
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

The controller stores the number of dummy cycles in a 5-bit field.
Programming more cycles would silently truncate the value and corrupt
the transfer. Add an extra ->supports_op() check for that.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/atmel-quadspi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index abca99b32b61..8946abaafa81 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -487,9 +487,15 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
+	if (op->dummy.ncycles && op->dummy.buswidth != op->addr.buswidth)
+		return false;
+
 	if (!op->addr.dtr && op->data.dtr)
 		return false;
 
+	if (op->dummy.ncycles > FIELD_MAX(QSPI_IFR_NBDUM_MASK))
+		return false;
+
 	if (aq->caps->octal) {
 		if (atmel_qspi_sama7g5_find_mode(op) < 0)
 			return false;

-- 
2.56.0

