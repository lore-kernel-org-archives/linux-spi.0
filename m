Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629143;
	b=Dgj94r5Svzd5ZCJxpKDUFXfxkbTigWIyZ+gDypHe0b2bw8diIYP8nKkUX5lYe8wJcVtb
	 AfK+BZf3oOq99X6nksTmNezLNOIgk3OXbaoITzxqVAeDHEiMgF+zYZX+qZdkGF+d94SS8
	 I2JJbIWB+iA3zpxzvyhHxnfdBqFPE5I499l+hW6E9EAsl/NDSEQixVyV5/obV+QyZr3RN
	 yTH5a4xooNUlUa3593sGdlXmRQEtJ6spTlhM7vqYGjykbMaUzLZHP2rafSQbNdhS0+t/V
	 68u+u4HhCAy2XUSzS5AZJtZTJcGqGcSNzmonolMtzeFyqnrcRsq1B8LVL03tKqaF1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629143;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=jCUxGWBmv4RksFsXo6xHOnvrHIscL64ZTXdKjZ8tDac=;
	b=4W/pAzQ5VIuSD0fuhRoZBAMffzl4Qmiq7VALCS3isqWGr21VNeKBmtAynm3bcClvNctc
	 MouIkitZ/isWOf3v7NBFawtyqIlX6M5iP6EpQ6zMz+MfYfpLmbVbHExeVDoIUcaTCTT/u
	 /bxhTu8U7P8tfZl1UheigGxLTeu+nN9/405WnaZ2PRAXOQgkNmgHAkKl/7TGVzwmYel0+
	 MCquQpWr48SHadzYDir2q/2t8fVm7qTMmJsOhPdQAR9M7ah7/wfb+xNhrI/O2vkGjJfbx
	 8jksIUlPehJYbQxc+rhiqzIcew0rELiyf4Hq1Yix/11l2YAeotft715fYBhfoo7Pm+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="08jSwX/q";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25641606A339
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25641606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=08jSwX/q
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CE1771A17FA;
	Wed, 25 Nov 2026 17:52:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9D9EB604C0;
	Wed, 25 Nov 2026 17:52:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FDE611E6B0D4;
	Wed, 25 Nov 2026 18:52:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629138; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jCUxGWBmv4RksFsXo6xHOnvrHIscL64ZTXdKjZ8tDac=;
	b=08jSwX/qrR/kl/IHIopVYsD4umanGbaUHFOUFuPFYhXk3Rc9rYtqlCQp/g9E/fSdJrLTBW
	gA00YXONY/bkZ8UYpTtaGxtquhleGOgvbhdESAcGRCj467v9FTPYTchbUoor4ObhwAg9DD
	vPxmP+lhzsgnETi0W5QrmZh0AxHYEtJA8epjSK7IapKp09DPeio5MaqYNP3YSX8knLN73l
	Qw6p9V6J9fE7VBNp3vh04Fb0ZpR3FSYnz2h8wkALFafNkGYRL80xCJ2bVA3+vXzEt9y30R
	TZ12USBkg1BH4H5n30eYV15FAOqpQYmn/pjN7q38ILpeewkK+DE1flD6vTh7mg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:21 +0100
Subject: [PATCH RFC 07/16] spi: cadence-qspi: Consume dummy cycles directly
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-7-fd036402fd37@bootlin.com>
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
 drivers/spi/spi-cadence-quadspi.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 44d96b8cf8f0..1bf21cadd1da 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -410,20 +410,6 @@ static unsigned int cqspi_calc_rdreg(const struct spi_mem_op *op)
 	return rdreg;
 }
 
-static unsigned int cqspi_calc_dummy(const struct spi_mem_op *op)
-{
-	unsigned int dummy_clk;
-
-	if (!op->dummy.nbytes)
-		return 0;
-
-	dummy_clk = op->dummy.nbytes * (8 / op->dummy.buswidth);
-	if (op->cmd.dtr)
-		dummy_clk /= 2;
-
-	return dummy_clk;
-}
-
 static int cqspi_wait_idle(struct cqspi_st *cqspi)
 {
 	const unsigned int poll_idle_retry = 3;
@@ -549,7 +535,6 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	size_t n_rx = op->data.nbytes;
 	unsigned int rdreg;
 	unsigned int reg;
-	unsigned int dummy_clk;
 	size_t read_len;
 	int status;
 
@@ -574,12 +559,11 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	rdreg = cqspi_calc_rdreg(op);
 	writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
 
-	dummy_clk = cqspi_calc_dummy(op);
-	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
+	if (op->dummy.ncycles > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
-	if (dummy_clk)
-		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
+	if (op->dummy.ncycles)
+		reg |= (op->dummy.ncycles & CQSPI_REG_CMDCTRL_DUMMY_MASK)
 		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
 
 	reg |= BIT(CQSPI_REG_CMDCTRL_RD_EN_LSB);
@@ -696,7 +680,6 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	void __iomem *reg_base = cqspi->iobase;
-	unsigned int dummy_clk = 0;
 	unsigned int reg;
 	int ret;
 	u8 opcode;
@@ -714,13 +697,11 @@ static int cqspi_read_setup(struct cqspi_flash_pdata *f_pdata,
 	reg |= cqspi_calc_rdreg(op);
 
 	/* Setup dummy clock cycles */
-	dummy_clk = cqspi_calc_dummy(op);
-
-	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
+	if (op->dummy.ncycles > CQSPI_DUMMY_CLKS_MAX)
 		return -EOPNOTSUPP;
 
-	if (dummy_clk)
-		reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
+	if (op->dummy.ncycles)
+		reg |= (op->dummy.ncycles & CQSPI_REG_RD_INSTR_DUMMY_MASK)
 		       << CQSPI_REG_RD_INSTR_DUMMY_LSB;
 
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
@@ -1528,7 +1509,7 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	 */
 	all_true = op->cmd.dtr &&
 		   (!op->addr.nbytes || op->addr.dtr) &&
-		   (!op->dummy.nbytes || op->dummy.dtr) &&
+		   (!op->dummy.ncycles || op->dummy.dtr) &&
 		   (!op->data.nbytes || op->data.dtr);
 
 	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
@@ -1739,12 +1720,14 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
+	.dummy_cycles = true,
 };
 
 static const struct spi_controller_mem_caps cqspi_am654_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
 	.no_cs_assertion = true,
+	.dummy_cycles = true,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)

-- 
2.56.0

