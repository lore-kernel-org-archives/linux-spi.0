Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789471;
	b=GuIcscxWOK8IVbGOnkUNaHDd1SZhf+CUlga9T2VzEnBFRkdPyGx13z70SUEgYYhhdkAs
	 apwZY1d9tGAQJlm5jhQ6Ba+kPUSQZ7GRn24X38HmWR1EvITuQ81QsoJGNKHnaPNvz4b96
	 md9/dbfKSK/CN94HMmuzkxBqeKWTKzAA3BcYMcdxYuCQfdn9trRRo8WqMpuktwxWVIlcp
	 wKNawCDv+7GaPmUpIBfO8bc98FFrfTnRpiyhesEAfFlr0bfFcwwomEWXdJPjo7GvGGzFh
	 LDNJi81EA40wMdnJbYJryFVXYhurRcT5cHf49SlJRRi8f1B6QizDoXANQJMKT+HbdcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789471;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=y57dJmsapUsf0K8zIJYUWSjG4lZHxo72aG5YqrWTl8Q=;
	b=3HGy+LLoTnTOM+JpSszuw7ME734yLOlMSEkD1T9ZZKJNktsZQGI6kho1j+MDSw5w3EbS
	 Vpa1sEGiNJlkZftYyFe8XY31Fs9FkY8bmM+vcM+W1CEt0m2vz40I7D4dehuQikI5WDm35
	 an/6NezFkDI10vzYY55AZ2GE8Y8GWuKD8G1UuKLf/7XQo0zeGirqJWFi7tNBPdI3V138U
	 rP52dHTOCastf0NY+ejfKCE/cUnoVDAO5Wmf3yVgKRv33/XhqKxBdpraP4nDD2diy4FMu
	 5gSAaYRSLo2WpeK4zlRVO1nkJmcoSQEzM8TecgYZJmg2yHNAEWP6qY4F/bliVtJmDlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JfwfhOwW;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A956071E77;
	Fri, 27 Nov 2026 14:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A956071E77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JfwfhOwW
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BE82EC2AC4F;
	Fri, 27 Nov 2026 14:24:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F38AB6049C;
	Fri, 27 Nov 2026 14:24:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D86911E68FF9;
	Fri, 27 Nov 2026 15:24:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795789467; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y57dJmsapUsf0K8zIJYUWSjG4lZHxo72aG5YqrWTl8Q=;
	b=JfwfhOwWdfse5PNcdH/We4rNKJosXgz5tUZtt/kIO5++eOp2GdasD+vaEYBsDHI+O6NHcU
	LbPlWvLnHag9BymLka7+ZOy27yswPFsmLqAms9mOw/Gs6ReC5vEd6icRtVdE/3ZZJ+FSGv
	iQvCy/4VcmtJUI42j7H+J7F1PxAcsbLut/gYalCTEX7gooxZrtvLPKFWa1+LjjFXNkiG8u
	sbOaf6qOaM2sQ89KdbvxqXAPswiEss1+nlSvrPsh+cyckKJwdigRHjNrM78qPjcyBIee5E
	r4qhoGU7+McO8Lbb9rzOSFa+laqInnQ6/iu2uVq0v8PCTd9OXH0XhcAlL5jEww==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 27 Nov 2026 15:22:30 +0100
Subject: [PATCH RFC v2 08/35] spi: amlogic-spifc-a1: Reject excessive dummy
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
Message-Id: <20261127-macronix-upstreaming-spi-mem-cycles-v2-8-5c93f5e5d630@bootlin.com>
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

The controller stores the number of dummy cycles in a 6-bit field.
Prevent field corruption by adding a proper ->supports_op() callback.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-amlogic-spifc-a1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index d99c72c7a965..bbe1b6b52b85 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -314,7 +314,17 @@ static void amlogic_spifc_a1_hw_init(struct amlogic_spifc_a1 *spifc)
 	writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
 }
 
+static bool amlogic_spifc_a1_supports_op(struct spi_mem *mem,
+					 const struct spi_mem_op *op)
+{
+	if (op->dummy.ncycles > FIELD_MAX(SPIFC_A1_USER_DUMMY_CLK_CYCLES))
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
 static const struct spi_controller_mem_ops amlogic_spifc_a1_mem_ops = {
+	.supports_op = amlogic_spifc_a1_supports_op,
 	.exec_op = amlogic_spifc_a1_exec_op,
 	.adjust_op_size = amlogic_spifc_a1_adjust_op_size,
 };

-- 
2.56.0

