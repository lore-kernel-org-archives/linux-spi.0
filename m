Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5B44683E
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519874; cv=none; b=bYPaOqM8QC9nELZ2VA4JjPQST8f+cVDEzb2WWVrwpx3QBQ1eX1C9Q++mrrBR90ahEfvIx7OL0INOVVdWizY4W0yxy4/NgiH18cxTCFpNpsDnuJ0r4WLFWrtCED3oWLC3sUwiRLbZIxtPqttXL65h6y+7GoeGkcxpgUFtjF0OU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519874; c=relaxed/simple;
	bh=dJkuxRnLtXHX0hYD2tPNeJpdMPMlGF6LLVMZdpV+Dlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoWk9ECSu/YY3b6dj2UNzjDDe7cNHwIsskjn6WxJpwJtKnLr1sYrZmZkD3omOapifmFRa0q4WajP4qvBHnn7Pe/OhR6IxAZ1LnPz4Ipz7ZJZu4yuiAFM4I+/EV55Hfn1UhbivUU6GFA1+WxfCGqIit6oOmT+MCSdHs4nm4zMOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5dH8GAy; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5dH8GAy"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b12d146e6fso404429eaf.0
        for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519872; x=1789124672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14NhbWVwArhRPWoqbEkyydWg2Xn0PWXC+Lz7VEuzIKQ=;
        b=E5dH8GAyieB9JYR2B6NOH8bhotlnt2xbF+AY+6p4D6u6d5otH6bNjRtm+Y6rmlqis0
         EzabQBPaG6RhqVV0aXcqePvoH3aeAHhX9ABfFV2RKqQ/DtiUwFqPHiHFOE0IA/0zE/ni
         VuYdcwcSticEc6xB/zaE0XwYFWfKlzoWcB4DgeKgRcFZI3fTvLR1Ffh6NZWMmPZsWA+O
         CKPxBfHy/mCy4Iz2dEBVqZ/ylGurpSrTU8MUPSqeZdlAPFqW8J8Ikxchgza/8zh53Kvy
         p+VVJRz0ZODOrx5NF5XLRQS3EvQZMUKvYeE1W/pnDNMbfR1PO4XtOImB2/C1hpBFTNbI
         Anaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519872; x=1789124672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14NhbWVwArhRPWoqbEkyydWg2Xn0PWXC+Lz7VEuzIKQ=;
        b=tSIfNNW7m+58cNgU2VvEC+XHNIjzS1dhKS8Sf07B9uEsvtNVd9IKFf8/0iq1zugIBh
         30rCjpGiFIr1oQYURckiuJRIwzN8mfFVawclrMwA+lL6+tUWaBK9mEzLx+ZxHDn3Z5W4
         XU2rPNPPNJP2bTrU3YArsflqkO6Cg1jnxF0qCRexgxTwmVIzBawqCtxtAnIhXYvoN96c
         9+HrqhyCt6+Tiq7ZjkKM7QKdc9NgtYnuSC1jWbzGdp75ti1x6FfZECI9eIQNt5KJY1sD
         gZG3PlewOq9o5ZpE71ICaAaoLW7SoXu78//4TTFOfrifrvH1RpUvm0XEKHDgsYtp/x0V
         FzHw==
X-Forwarded-Encrypted: i=1; AKwUvBzjxnhL2QPe1Nbhiib4OKXr/XqYpgibUkwb7zjku8bgcFhWqIDaBJdFQFEAveyZNg47c38MWYBFvaY=@vger.kernel.org
X-Gm-Message-State: AFuF++n+ggW2T6mel7XBzkI03XSHJSq7P2ZsVdtThHFbeZbBRzWaBZIq
	exJYoGbbLMEF+8CEjpaO6QBSroEMUG/zmnNdiKmzCGyzU2m9Ez0rsvEP
X-Gm-Gg: AYBFou29eun92n1s7mwWuhDgnAAt+qmpnkgYge9/Ln5+8iybfLOok1hn0xHH6vnXr60
	kCjOW9ezqP38C6oD4DypCbywNp9lajo2ANuSONH2dFIcxsATC30bHQ9kqUzubnlyZN8RZx+3VjY
	9TdvhCbRx0kSNpbVwgoo7Es2sEVn+ZhY4sMVMrEz/XSn5s5N80VqtEp5iwagx4jkkZM2oZiun5S
	bq9OiF/Qsc4zn46gooMn27Gk37OShaAxbVKgINms4txzX+eM/KjLvXy2dO27EP+v+nt9dZONlnI
	NKieDttYlcKrbECa6kUQuIEqeuuVGdZfCHm5xlyKKqZoVL/diLblxfivyQoRO+n3EFN1BSNN0Vt
	jAPPpyPk1dhCV45W7OVAiqy0C6I5bQRxnQoAUtrW/8cm60PsvdSwyZ8RRGNOUMR7/6qRtnfMY75
	1WIkgCp3v9/AfNTXZm1bFzmJzqvBx5DsYw+OWIHAeaJwZHYVD5pGIpDzYnTh58Z7HRLkHjUMauR
	VZzv91KtmGgp6I=
X-Received: by 2002:a05:6820:81e:b0:6b1:afca:5c78 with SMTP id 006d021491bc7-6b6fddba8bbmr3334490eaf.32.1788519871772;
        Fri, 04 Sep 2026 04:04:31 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm6640159eec.2.2026.09.04.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:04:30 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] spi: fix typos in comments
Date: Fri,  4 Sep 2026 16:34:16 +0530
Message-ID: <20260904110420.13707-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/spi/spi-bcm63xx.c     | 2 +-
 drivers/spi/spi-imx.c         | 2 +-
 drivers/spi/spi-omap2-mcspi.c | 2 +-
 drivers/spi/spi-pic32.c       | 2 +-
 drivers/spi/spi-s3c64xx.c     | 2 +-
 drivers/spi/spi-stm32.c       | 2 +-
 drivers/spi/spi-sun6i.c       | 2 +-
 drivers/spi/spi-xilinx.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 1d8e257bad30..3f349c1db581 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -413,7 +413,7 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 	u8 intr;
 
-	/* Read interupts and clear them immediately */
+	/* Read interrupts and clear them immediately */
 	intr = bcm_spi_readb(bs, SPI_INT_STATUS);
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 79a6c1a60b0a..6f9686df0486 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -673,7 +673,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * propagate into the hardware. It takes exactly one tick of the
 	 * SCLK clock, but we will wait two SCLK clock just to be sure. The
 	 * effect of the delay it takes for the hardware to apply changes
-	 * is noticable if the SCLK clock run very slow. In such a case, if
+	 * is noticeable if the SCLK clock run very slow. In such a case, if
 	 * the polarity of SCLK should be inverted, the GPIO ChipSelect might
 	 * be asserted before the SCLK polarity changes, which would disrupt
 	 * the SPI communication as the device on the other end would consider
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a3355147f5de..90f3990e0060 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1244,7 +1244,7 @@ static int omap2_mcspi_transfer_one(struct spi_controller *ctlr,
 		omap2_mcspi_set_fifo(spi, t, 0);
 
 out:
-	/* Restore defaults if they were overriden */
+	/* Restore defaults if they were overridden */
 	if (par_override) {
 		par_override = 0;
 		status = omap2_mcspi_setup_transfer(spi, NULL);
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 972128271e4b..8363bc873b03 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -53,7 +53,7 @@ struct pic32_spi_regs {
 #define  TX_FIFO_ALL_EMPTY	0 /* completely empty */
 #define  TX_FIFO_EMPTY		1 /* empty */
 #define  TX_FIFO_HALF_EMPTY	2 /* empty by half or more */
-#define  TX_FIFO_NOT_FULL	3 /* atleast one empty */
+#define  TX_FIFO_NOT_FULL	3 /* at least one empty */
 
 #define CTRL_MSTEN	BIT(5) /* enable master mode */
 #define CTRL_CKP	BIT(6) /* active low */
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8d4120cf9df1..3546414dfc70 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -661,7 +661,7 @@ static int s3c64xx_wait_for_pio(struct s3c64xx_spi_driver_data *sdd,
 	 * loops = length / max fifo size (calculated by using the
 	 * fifo mask).
 	 * For any size less than the fifo size the below code is
-	 * executed atleast once.
+	 * executed at least once.
 	 */
 	loops = xfer->len / sdd->fifo_depth;
 	buf = xfer->rx_buf;
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index be88e62075af..5f5c43ae5096 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -515,7 +515,7 @@ static int stm32h7_spi_get_bpw_mask(struct stm32_spi *spi)
 
 	/*
 	 * The most significant bit at DSIZE bit field is reserved when the
-	 * maximum data size of periperal instances is limited to 16-bit
+	 * maximum data size of peripheral instances is limited to 16-bit
 	 */
 	stm32_spi_set_bits(spi, STM32H7_SPI_CFG1, STM32H7_SPI_CFG1_DSIZE);
 
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 4631e9c7ca1d..6b7a05dd0de8 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -386,7 +386,7 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 		 * SPI_CLK = MOD_CLK / (2 ^ cdr)
 		 * Or we can use CDR2, which is calculated with the formula:
 		 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
-		 * Wether we use the former or the latter is set through the
+		 * Whether we use the former or the latter is set through the
 		 * DRS bit.
 		 *
 		 * First try CDR2, and if we can't reach the expected
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index dc1e968659e1..df4ea99a5427 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -460,7 +460,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 	host->num_chipselect = num_cs;
 
 	/*
-	 * Detect endianess on the IP via loop bit in CR. Detection
+	 * Detect endianness on the IP via loop bit in CR. Detection
 	 * must be done before reset is sent because incorrect reset
 	 * value generates error interrupt.
 	 * Setup little endian helper functions first and try to use them
-- 
2.48.1

