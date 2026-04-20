Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21336B04E;
	Mon, 20 Apr 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703906; cv=none; b=cMmijPR6nxqDH3J18QpbX80kq2b5GH4WZpWft0QwrkYBB6BRNe+y/EmEai9DRBp2bZZ3NFTQyZnv2t/UPshAhqC/LVdHJ0wnyNfAag9r1iSs91vI0XPgxsk6Z+RjkqYkjkZf0SVDhn/bziDpA8sad9/v0s3+gqzMNiYGpIl3mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703906; c=relaxed/simple;
	bh=xR/xNVu6WnevvH0ijYlYbA20C966C9CC9JfxsjBNhds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jct7wlus7JYe3lrSP4hf11nsnDvqLGBPFrxP1CDZrWTeIsyJCdfJlkdOZMhdzyhtpYiWy5uf45dOP+n+hvHHpdNP3gq0wuCOqYWJBsVVOFUGMAOahCwbBVASk2TxPLV1oyzsoRHFXdEgMf3cylfli/0RPTglnigM9t0UXjxb6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net; spf=pass smtp.mailfrom=kevinmehall.net; dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b=mGAtAmeM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y2zoIAwE; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b="mGAtAmeM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y2zoIAwE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD9A27A00EA;
	Mon, 20 Apr 2026 12:51:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Apr 2026 12:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kevinmehall.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1776703901; x=1776790301; bh=rk8+b4BzpG
	G17aZUXwC55XJJ2stY5Os27PbdRKnAVVY=; b=mGAtAmeMhPPXaPFIChbVJ5HE2h
	OXkSNjodJ27/GsUqIHLFw20MBMg6W2n2FfLC49c/FuglLRrctGDB+Nbet9NTNOx7
	sN7TWlBGEACgKSiAn1nFUfhDuI66wbQLTytF8sEM3+UZuK1+ysPnYHM/4AE6TQca
	GdyTmbs7Zwg9monlQfxmX5h3kkxEIEcfX0r7hvhenzQQ/5IF8cBJ6yXzDokUowvg
	F+nMCO3qALFq50WCWvMEDddWekGTAJGH+fFq8Wq2LQZ+JP/P06QTTUtyoY5+i+L/
	Fvdpy8AK+WB/G/j5MMeTQFTgAJAhywEiSY7IPRkMBgPy9UBeMkgFrZPVY8NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776703901; x=1776790301; bh=rk8+b4BzpGG17aZUXwC55XJJ2stY5Os27Pb
	dRKnAVVY=; b=Y2zoIAwEQ/QSoxlM/5qBhJhmG5pmDEdPjnZTbjDE94kiiEI4J47
	zRA0fqIlYPsu/S25MM5LVcQOs1Zfg6FiT/raB2m3r8HYEszbw2R52Bhfaf9HqbNd
	ab4N6akRZb7W/R9HhyUBxixnv2LJcfhxtUwxs69jrkDye+dF24D6FAi7SP5BSOMl
	6OKtTYWPsv/Gwmt4dkFB1whRayRXbCV4K15HxlBLZSrM0LUmfpaxsqKByoiyJhiR
	nsK8CfpczG8X3zSvTjcRaJ77WME8/lyOOGkHg2TxRtK3CxszOUZjgWRhSUptDQUw
	GhP21QPlBN1dUYIUasWmCXIupuNit/cSPXA==
X-ME-Sender: <xms:nFnmad39cXrzBXmA1DsEsbtATpJkczoDCPO5eYP8MlgjwGZzTksvuQ>
    <xme:nFnmaf4Pi_e_2ZpZodZWF3A77h-fAgax0KpL56u_pxWhgGjjL8L2ElbfWN6pnndtp
    mnEPDUHbiGDcO_d8nRO5TE99ziV2goH5e2tRN-N-m9U_WDHLfwrwpc>
X-ME-Received: <xmr:nFnmaZQ8DSFZVCTEJS64U8nJBf9Mr1OJL4UWhNeklG1fSSAORYnLPUovTFZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehledthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmvghvihhnucfovghh
    rghllhcuoehkmheskhgvvhhinhhmvghhrghllhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epueehfeffgfevlefftdffudehgeejleekieeileekgfeufeekfedvgfegffettdeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhmsehkvg
    hvihhnmhgvhhgrlhhlrdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepfigvnhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghrnhgvjhdrshhk
    rhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmuhgvlhesshhhohhllh
    grnhgurdhorhhgpdhrtghpthhtohepmhhirhhkohdquggvvhiklhhinhhugiesnhgrnhhl
    rdguvgdprhgtphhtthhopehrshgtsehruhhnthhugidrtghomhdprhgtphhtthhopehlih
    hnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqshhunhigiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:nFnmaUUALlqwR3feaEMRtcm9Rtwf9KH3TUPjLDsia2ZBQ7UTicjfzg>
    <xmx:nFnmaeGx-hXfh9PVJuFV_SgKkJnXCAM8UfkDo41s8VBWQsdPzJTwOw>
    <xmx:nFnmaXe0-Ns1-IrTv-IZAmyU4ZcLQ30vv-8GZfhUO8JUAQ5qjcC4UA>
    <xmx:nFnmaXrOVHTWb8kBJqj1isw1bIy_bHWaCg4J20VTAZfmkygL98fomQ>
    <xmx:nVnmaWs3rw9EMLs6_8HdU9cajXvqsY_DqDgaJ7Hh9x1QMIi6UhdJxmZW>
Feedback-ID: i421842c8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 12:51:39 -0400 (EDT)
From: Kevin Mehall <km@kevinmehall.net>
To: Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Mirko Vogt <mirko-dev|linux@nanl.de>,
	Ralf Schlatterbeck <rsc@runtux.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Kevin Mehall <km@kevinmehall.net>
Subject: [PATCH] spi: sun6i: Set SPI mode in prepare_message
Date: Mon, 20 Apr 2026 10:46:04 -0600
Message-ID: <20260420164755.1131645-1-km@kevinmehall.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a GPIO chip select, CS is asserted before entering transfer_one.
The spi-sun6i driver previously configured the SPI mode (including clock
polarity) and enabled the bus in transfer_one, which can cause an
extraneous SCK transition with CS asserted, corrupting the transferred
data.

This patch moves the SPI mode configuration and bus enable to the
spi_prepare_message callback, ensuring that SCK is driven to the correct
level prior to asserting CS.

A previous fix for a related issue (0d7993b234c9f) was incomplete in that
it only avoided driving SCK at the wrong level when resuming from
autosuspend, but didn't help if switching CPOL modes between chip selects
while active, or if SCK floats to the opposite level when suspended.

Fixes: 0d7993b234c9 ("spi: spi-sun6i: Fix chipselect/clock bug")
Signed-off-by: Kevin Mehall <km@kevinmehall.net>
---
 drivers/spi/spi-sun6i.c | 76 +++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 240e46f84f7b..85395f1385bc 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -201,6 +201,50 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
+static int sun6i_spi_prepare_message(struct spi_controller *ctlr,
+				     struct spi_message *msg)
+{
+	struct sun6i_spi *sspi = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = msg->spi;
+	u32 reg;
+
+	/*
+	 * Set up the transfer control register: Chip Select,
+	 * polarities, etc.
+	 */
+	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
+
+	if (spi->mode & SPI_CPOL)
+		reg |= SUN6I_TFR_CTL_CPOL;
+	else
+		reg &= ~SUN6I_TFR_CTL_CPOL;
+
+	if (spi->mode & SPI_CPHA)
+		reg |= SUN6I_TFR_CTL_CPHA;
+	else
+		reg &= ~SUN6I_TFR_CTL_CPHA;
+
+	if (spi->mode & SPI_LSB_FIRST)
+		reg |= SUN6I_TFR_CTL_FBS;
+	else
+		reg &= ~SUN6I_TFR_CTL_FBS;
+
+	/* We want to control the chip select manually */
+	reg |= SUN6I_TFR_CTL_CS_MANUAL;
+
+	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
+
+	/*
+	 * Now that the clock polarity is configured, enable the bus if the
+	 * controller was previously suspended.
+	 */
+	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
+	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
+	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG, reg);
+
+	return 0;
+}
+
 static void sun6i_spi_dma_rx_cb(void *param)
 {
 	struct sun6i_spi *sspi = param;
@@ -332,31 +376,12 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 
 	sun6i_spi_write(sspi, SUN6I_FIFO_CTL_REG, reg);
 
-	/*
-	 * Setup the transfer control register: Chip Select,
-	 * polarities, etc.
-	 */
-	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-
-	if (spi->mode & SPI_CPOL)
-		reg |= SUN6I_TFR_CTL_CPOL;
-	else
-		reg &= ~SUN6I_TFR_CTL_CPOL;
-
-	if (spi->mode & SPI_CPHA)
-		reg |= SUN6I_TFR_CTL_CPHA;
-	else
-		reg &= ~SUN6I_TFR_CTL_CPHA;
-
-	if (spi->mode & SPI_LSB_FIRST)
-		reg |= SUN6I_TFR_CTL_FBS;
-	else
-		reg &= ~SUN6I_TFR_CTL_FBS;
-
 	/*
 	 * If it's a TX only transfer, we don't want to fill the RX
 	 * FIFO with bogus data
 	 */
+	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
+
 	if (sspi->rx_buf) {
 		reg &= ~SUN6I_TFR_CTL_DHB;
 		rx_len = tfr->len;
@@ -364,9 +389,6 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 		reg |= SUN6I_TFR_CTL_DHB;
 	}
 
-	/* We want to control the chip select manually */
-	reg |= SUN6I_TFR_CTL_CS_MANUAL;
-
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 
 	if (sspi->cfg->has_clk_ctl) {
@@ -428,11 +450,6 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 		sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
 	}
 
-	/* Finally enable the bus - doing so before might raise SCK to HIGH */
-	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
-	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
-	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG, reg);
-
 	/* Setup the transfer now... */
 	if (sspi->tx_buf) {
 		tx_len = tfr->len;
@@ -667,6 +684,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	host->max_speed_hz = 100 * 1000 * 1000;
 	host->min_speed_hz = 3 * 1000;
 	host->use_gpio_descriptors = true;
+	host->prepare_message = sun6i_spi_prepare_message;
 	host->set_cs = sun6i_spi_set_cs;
 	host->transfer_one = sun6i_spi_transfer_one;
 	host->num_chipselect = 4;
-- 
2.53.0

