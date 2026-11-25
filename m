Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629150;
	b=zd7hXTpQtduXH7MS/M+vPM5S8pTLSj3CU0GBZOHPy8U5Akq51khNCMgwnGGIq6yez7AC
	 +uIa5YN4H1Xizjt82aSk8+dYdBqzzHb45PNSKpy+aLfg8fLphv/qtK+J0by3hrrD1/sSe
	 V80W1VnMYb/wc+Gw3AuFFBzJeh4d+IMnTvsCCsb8P6TkabMQ5EjdWWu8W/625Um9FUuEy
	 1VQJ0Kw5BN6/8dJUo6UpNzc10N97oIoMzEushdYwW3OeIderv+643q/5tIU0B1XO0emlU
	 IkwbmCYMn+9FSK93PrRNMNZyXTtOpSqt2llepahu8KKtPGL7QrkGKAWwhZOpNRgQFQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629150;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=/akqnAhi4N7PD9g+GVLxR2YwtuVfsoR7dj296LmnLrw=;
	b=opB1NdeoYWNXTXFvQCCj3qyo6278qhaiB7H9Ak1bmndyVLjR4foYkm7g/TjDivboiEdQ
	 SPA4m4t1zRbmJwcNlmgkZ4XHyl2xrIER2JH7xvXA40vLAPfFBf//fccrwdoYwTY/Wu1If
	 CXGopjMSV0cVAUveZPMM567mKrUz03sXczc6cKhWB0gWwwXe8a2fMQqfaz5rRPU7fLa4y
	 EyczA2vc9c2Ii7a2SOScxjLEus1t8UnB5MkQeV+f/1HCzh1U+ZRH7xexxq1/fUOm/QoX1
	 HKjO61swrRrYw+yzExw63OJEBn+bZayG8obxKgWNalEOLdtzltgZRjb59L75X26QWRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pf4YnvL8;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8A606A333
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:52:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAD8A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pf4YnvL8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8805AC2BB3D;
	Wed, 25 Nov 2026 17:52:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90D9560480;
	Wed, 25 Nov 2026 17:52:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C27511E6B0C5;
	Wed, 25 Nov 2026 18:52:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629144; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/akqnAhi4N7PD9g+GVLxR2YwtuVfsoR7dj296LmnLrw=;
	b=pf4YnvL81dMdsb97g/DQYIk8S9HhrDd4MopcjKOnJrLk++4gDNxi8ouoGlm+etBpI+eNsm
	84kN9Gobi+rboeZZbVRrV9II7pZ3wim23o3nrwLX4Ipr8yV2ZnITsCfsulHi00yvnAdSvT
	4zCDhBrhcLMAb6o7mNIEktEPOxK+Zg2SUvMbAAR1Gr0IjsLPJH6k2GJgzfbwyXJk+3uQ3n
	cc4MJvqLbwDQeN8MWqKkZ01Yl8RwYhiNWZM7HsrHys7d42/5fEo1G+qaHmtgzHXEJ7Es/Z
	TMKEl1nZxy+PDtSa4hopGIy2EW4pfDUzWPMoDQdClp4exUj3CgNW1VFdoBSTyg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:22 +0100
Subject: [PATCH RFC 08/16] spi: fsl-qspi: Consume dummy cycles directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-8-fd036402fd37@bootlin.com>
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
 drivers/spi/spi-fsl-qspi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index d2c2090442f8..a1d6357e3203 100644
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
 

-- 
2.56.0

