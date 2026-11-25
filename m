Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629136;
	b=bd0TgvN7QkH1ZBD3KzqdO/Rq7BX+D62D2GO4etPTfHGx/sYTrcfc03QwZlba5PYb4mtF
	 rradIuedqmqD+5YH3GT9zxlfZhTa5aZx1DZFTVD+IkvElOF4257ImjpWbt0azUMKmnFeZ
	 iiTWw9DiIluB4fMwZAAO1wIHG7KdxiswdbWHCkTCGlc9uhIwIHv9bCOCG1Gwhc68DGl5z
	 TvYFBGWqYbh6tIBINcSiix3144kZeL1FYlpIKiTXVQtaCn0cJ+Czs3ukDVWSI9g4ZSnMz
	 OVL70y7FlHhsHf3ctclQMznKbSg3v94/LJJoEpKjxxoFJ2o1szr5pidtxrNFAM4ma0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629136;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=0jHuOkcW+tUuXEgN+rjlY+VwX3B9wkvVTb2a5wTh6Hw=;
	b=aWuT0eMzGW7uBSCrjLo1Diea9u9rCCwwv/hM7Qc2u7y50pY7wvzg68lQv3Wiwel38GA8
	 /bNlmhp8y9vVP41GNl1/A9N6GE14oXJC3hIznf4tPJ2fFtz+JE8oNFLmZ1NU0+OLk7aTK
	 w8rKjcz93mbaeD83w5jkKw+noH8y0EdlEvxaBns/HW6OeL7a3q0lj7tNPSwLz22H6vfwL
	 soN7q2rF6TWZr0pMeQEDXmJ077v7DzFIV2Upn47J7JdPybOs90rFpJIILMQ+ZlpO+JhAw
	 2ZkmttplaMSXizYKFDPtM20zvoqaHhDKdhKX9LArqzTXXZd/T6pTWEUNbb9y3uSLrVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wmBirQqP;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B919606A339
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B919606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wmBirQqP
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E3F3FC2B9C1;
	Wed, 25 Nov 2026 17:52:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EBD1760480;
	Wed, 25 Nov 2026 17:52:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E9BB11E6B0CA;
	Wed, 25 Nov 2026 18:52:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0jHuOkcW+tUuXEgN+rjlY+VwX3B9wkvVTb2a5wTh6Hw=;
	b=wmBirQqPwYrB8cMXgwKVXCQ+dRgEdqiLvomU2P2fI5aIOAtcy3iU7XbOUAhwM3IizD201/
	C3XFza9eM2aD+WwEWX+dWOUkceFb5V6jKXGVvahBq7f/MipyZOPNQ8bTKCkB3nBcYHkmMS
	dAatQ6aOTwgKEQdqhjbyNPD8TxLt9uECyAQj8nIKQ9y2z1S72bQhmIJBS4tnOhr5JNUB7f
	dgdQYHYT7jWrKIymy4D4Y2E9hE7q8cOQz6vcPX2tR8nnVYtLPMlreafxGz/9GfgQw+1e/b
	coqZKJH9p4b5z0I4Cn31ov6B67gWCgfbZxiL8cpWv9ZcFNXHu25n0On5CX480Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:20 +0100
Subject: [PATCH RFC 06/16] spi: amlogic: spifc-a4: Consume dummy cycles
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-6-fd036402fd37@bootlin.com>
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
 drivers/spi/spi-amlogic-spifc-a4.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 16346f50c7d9..ac06ea735133 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -361,13 +361,8 @@ static int aml_sfc_send_cmd_addr_dummy(struct aml_sfc *sfc, const struct spi_mem
 	if (ret)
 		return ret;
 
-	if (op->dummy.nbytes) {
-		/*  Dummy buswidth configuration is not supported */
-		if (aml_sfc_is_xio_op(op))
-			dummy_cycle = op->dummy.nbytes * 8 / op->data.buswidth;
-		else
-			dummy_cycle = op->dummy.nbytes * 8;
-		cmd = CMD_DUMMY(sfc->cs_sel, dummy_cycle - 1);
+	if (op->dummy.ncycles) {
+		cmd = CMD_DUMMY(sfc->cs_sel, op->dummy.ncycles - 1);
 		return regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	}
 
@@ -803,7 +798,7 @@ static int aml_sfc_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	dev_dbg(sfc->dev, "cmd:0x%02x - addr:%08llX@%d:%u - dummy:%d:%u - data:%d:%u",
 		op->cmd.opcode, op->addr.val, op->addr.buswidth, op->addr.nbytes,
-		op->dummy.buswidth, op->dummy.nbytes, op->data.buswidth, op->data.nbytes);
+		op->dummy.buswidth, op->dummy.ncycles, op->data.buswidth, op->data.nbytes);
 
 	ret = aml_sfc_pre_transfer(sfc, DEFAULT_PULLUP_CYCLE, CS_SETUP_CYCLE);
 	if (ret)
@@ -1057,6 +1052,7 @@ static int aml_sfc_ecc_finish_io_req(struct nand_device *nand,
 
 static const struct spi_controller_mem_caps aml_sfc_mem_caps = {
 	.ecc = true,
+	.dummy_cycles = true,
 };
 
 static const struct nand_ecc_engine_ops aml_sfc_ecc_engine_ops = {

-- 
2.56.0

