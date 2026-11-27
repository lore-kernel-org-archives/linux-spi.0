Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789563;
	b=Cp5oTpxBmHK19sHvRVP0iO0tHhkgyXHieoK6iTCLeoafZ9ZK2E0d8CjRpCS5gz36ip+8
	 t0hKYqswXiKIg4aYXwm3r3GkfUF1ZdgPh9XfhdT/Zpx+LGQmvbyJaoAuMiEvfOZkv6CvY
	 Ni9oDvC06KWuTIj/TcoLY1rkS/8WHsoGPcl+sJ5gWiEUIaPa4AWrQq/9kb92XhRIE+I5/
	 TVV8aWS/GRfJwCd6EjjgABrXKMmKQ6EW8iW+BoXdEIZTbn1lQwtOLqtVT6rdKMc1Fg+Bv
	 vZkp0CX8FPp40rvBaJT+P9nXhxiGySTCnAXyz0x5OPHVJBNj96gvM8Iz4EMcTk5KAWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789563;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=PiBNWoqH2zie2QW5L9CTTLxi83g0iqOaBLwfJeY29Ck=;
	b=nqkyCA7uVpVhJPrkmHm0FUTHF6sMMzS5hQ9b+3gW6YdOm7DquUdHo8SMyteAYLI8c5dl
	 GlWHlPN/ZOM1faVWNwuB04mxNr0Qvgk+dYQzdyuDSAHYYqy8gRBToTh3RIxc3/SZBc4KS
	 QEuLPB7TeNsIVg1OfGVHmizLtlgIMboZ7LaDhjSToTdb5ekI8i8fQjVAxetGuddJrCT3O
	 UEnW4MJs1qLTzCSDGjfEw6D+0kA42/yHcEgNMWhj3o5grL5KWNILMClhG1w9iTwLddiVm
	 tt2mwrsbq9DjFmqAjdue9G4+RLkKQzty5gOFQIh4IwFdQ19WmJnOOWBIwgcMDVYhF3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hnB3HhFJ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A541606A326;
	Fri, 27 Nov 2026 14:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A541606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hnB3HhFJ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EEC1E1A0440;
	Fri, 27 Nov 2026 14:26:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFDAA6049C;
	Fri, 27 Nov 2026 14:26:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90ACC11E68FDF;
	Fri, 27 Nov 2026 15:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789558; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=PiBNWoqH2zie2QW5L9CTTLxi83g0iqOaBLwfJeY29Ck=;
	b=hnB3HhFJhf4zGU0zpC6VqpiHx+byjW2HUGZCf4Qyaq1vE/bjZJhYoFxanpA2wmLeIrbuaG
	0Xx7wq1gSL2Ft8dveHN+EYbUNnuICpHAlMEKo/SP3mprwK7EsXZk6KdaGh5YT4DoVZQAxg
	Pwm58K0Dc4IIUZx5vsvKa4FT3K96uoFf2GuP6560wYeNZFiQkLjPUdBcv2ZKIyGbkUqi8e
	6S+9NtIGqz2OmATyF4t1N2WM8rpfZchUtih5TEG9xA1wb5bAvvN8/vQWfSiT17o96r7TPV
	0AtxLT9qRF5M1a3Ge0N6Ge/deHqomKtoIDPvmRrseP2zuYDUjqirHpQYfujKFg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:42 +0100
Subject: [PATCH RFC v2 20/35] spi: nxp-xspi: Consume dummy cycles directly
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-20-5c93f5e5d630@bootlin.com>
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

The controller programs the dummy phase in clock cycles, but the driver
converts the legacy dummy byte count into cycles. Advertise the
dummy_cycles capability and use op->dummy.ncycles directly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-nxp-xspi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 38c8d6269aad..8b836662a5da 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -392,7 +392,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes)
 		ret |= nxp_xspi_check_buswidth(xspi, op->addr.buswidth);
 
-	if (op->dummy.nbytes)
+	if (op->dummy.ncycles)
 		ret |= nxp_xspi_check_buswidth(xspi, op->dummy.buswidth);
 
 	if (op->data.nbytes)
@@ -408,8 +408,7 @@ static bool nxp_xspi_supports_op(struct spi_mem *mem,
 		return false;
 
 	/* Max 32 dummy clock cycles supported */
-	if (op->dummy.buswidth &&
-	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+	if (op->dummy.ncycles > 64)
 		return false;
 
 	if (needs_ip_only(xspi) && op->data.dir == SPI_MEM_DATA_IN &&
@@ -453,12 +452,10 @@ static void nxp_xspi_prepare_lut(struct nxp_xspi *xspi,
 	}
 
 	/* Dummy bytes, if needed */
-	if (op->dummy.nbytes) {
+	if (op->dummy.ncycles) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
 					      LUT_PAD(op->data.buswidth),
-					      op->dummy.nbytes * 8 /
-						/* need distinguish ddr mode */
-					      op->dummy.buswidth / (op->dummy.dtr ? 2 : 1));
+					      op->dummy.ncycles);
 		lutidx++;
 	}
 
@@ -1307,6 +1304,7 @@ static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
 	.swap16 = true,
+	.dummy_cycles = true,
 };
 
 static void nxp_xspi_cleanup(void *data)

-- 
2.56.0

