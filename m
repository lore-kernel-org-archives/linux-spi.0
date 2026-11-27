Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789523;
	b=rxhW+Gpg97UVsBF4qWUQA+BbKp17/v7xG6zusAwNb/ZDZSgCrTl2RMQSRTFaOmTeacxq
	 ERoJZQW/6JYqk4F3HNeKUmt3aSUBeukRKUS9SL/7oww9116zTc5wwNome2XZ/sRZ4td83
	 zrOSZbvIA3Q/yupq0+LthJh45s5m0oeHAVYQ0PkdPNSbedh0QKkMmQ/S+zH9gLonTcmyq
	 /lG2S6RIjD0hos15jYyMDbigeS3wWwrnKdrWtlfqfMHhKdOUIa0pISIqjjCeELAKFLZ//
	 fFvsih0m/fc2b3LunfbHzv43V+tJxWc+BoQtANUKQ1bqZ9penWzxLVRm5wk1CeSYLJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789523;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=e/WJNef7cTCW2VuT1UlZP1gTjHoI+mrBxgO+0P5fY00=;
	b=pDVMdvyK3CVTMORNnzGf7furc7mmsQIeGr8s53CCCVhJA2ZDVWuACvxf9yu9D/YD0Cl1
	 DEubJAan0ENWbhol4KA7VL73a0M2Mcf/t/5+egmlKw1v3SXvLENNacNZP0Wb62nj0+9Yw
	 GSqwSo3Q9sHgZo4r9SXz3twnuBOdyvPwVfWQzFFfNqlxlznf2nlLWSU++nDVpCF0gdq2U
	 rw6y99egGvNHA2yrUZKl9q47Hn00Sv7ASi6qB3shG2DffyNGDW5qsNpLrr11FRvJXykhU
	 taFAm+AqBZk8Alj8HuGKXFdQaUJLh6FJaxTCBuR/bxc59rZLcHHMa28A2ibd1X66aQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oaUPKRi6;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445EA606B1BA;
	Fri, 27 Nov 2026 14:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 445EA606B1BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oaUPKRi6
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F31A21A0440;
	Fri, 27 Nov 2026 14:25:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC3266049C;
	Fri, 27 Nov 2026 14:25:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75D6911E68FD9;
	Fri, 27 Nov 2026 15:25:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e/WJNef7cTCW2VuT1UlZP1gTjHoI+mrBxgO+0P5fY00=;
	b=oaUPKRi6F8AkPi9tmgVcanDSS72d0wZ1FkqpPbsnvOwBFv1S0M0okn1+HgL+eiijMb6aLF
	enQF+QF+klQsMr4LBW2KLXWCabg2Jdn4V8DopqJgNXOldLYBY2aolFatCnegthWL5Li9e9
	sQRX2sznQtYYrcMwdnDxd71aZOHVdZjwaysB71ddBP5Y/6MKcAXw2R0/p5OEov9GqRFfzs
	P1PFHz6x6e4Qsz3yo2ZSitMiESH1qe6f5aDyiuBn8FTr1Bwhinoa0qDwnFhR/IiUIN4UDM
	ldEKAfTQcQkRRdV0i/sxtkyMo1LlGapjD4SDfnps+m2nWX5t5ppsvsYlDGLiqg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:37 +0100
Subject: [PATCH RFC v2 15/35] spi: fsl-qspi: Consume dummy cycles directly
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-15-5c93f5e5d630@bootlin.com>
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
 drivers/spi/spi-fsl-qspi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index d2c2090442f8..383915b3ed41 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -399,7 +399,7 @@ static bool fsl_qspi_supports_op(struct spi_mem *mem,
 	if (op->addr.nbytes)
 		ret |= fsl_qspi_check_buswidth(q, op->addr.buswidth);
 
-	if (op->dummy.nbytes)
+	if (op->dummy.ncycles)
 		ret |= fsl_qspi_check_buswidth(q, op->dummy.buswidth);
 
 	if (op->data.nbytes)
@@ -413,13 +413,12 @@ static bool fsl_qspi_supports_op(struct spi_mem *mem,
 	 * to fit into a single LUT entry.
 	 */
 	if (op->addr.nbytes +
-	   (op->dummy.nbytes ? 1:0) +
+	   (op->dummy.ncycles ? 1:0) +
 	   (op->data.nbytes ? 1:0) > 6)
 		return false;
 
 	/* Max 64 dummy clock cycles supported */
-	if (op->dummy.nbytes &&
-	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+	if (op->dummy.ncycles > 64)
 		return false;
 
 	/* Max data length, check controller limits and alignment */
@@ -460,11 +459,10 @@ static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
 		lutidx++;
 	}
 
-	if (op->dummy.nbytes) {
+	if (op->dummy.ncycles) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
 					      LUT_PAD(op->dummy.buswidth),
-					      op->dummy.nbytes * 8 /
-					      op->dummy.buswidth);
+					      op->dummy.ncycles);
 		lutidx++;
 	}
 
@@ -872,6 +870,7 @@ static const struct spi_controller_mem_ops fsl_qspi_mem_ops = {
 
 static const struct spi_controller_mem_caps fsl_qspi_mem_caps = {
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static void fsl_qspi_disable(void *data)

-- 
2.56.0

