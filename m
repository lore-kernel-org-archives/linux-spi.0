Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C03A9DB2;
	Thu, 23 Apr 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966044; cv=none; b=RC7ox72QnmnYmd++DJ/6X1B+TmUxFy8/kWQC4Y/7pqO0fnUzfcb3Ty8Zt1vbw1sLfEsh+wyZefvDvqca+/ya16LU47EulvEVuqQHYeuvAKz/7z9RqS3fRscr/bdZ0WoE/Y8CjUdOADI/389XOgHkiT+NVGTyL1EAKgZiJl35CjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966044; c=relaxed/simple;
	bh=AVlgud0DfG/DvkOrRMBV349x4XRm8AFK7JWFHTSPPoo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUZWIsAzU/aM6hOmqYSUSK1Vl4+QcjE9CcHXDinrbd+orxoSUuDmiTYEkKz8DVmMVll9dQ66aEFydCuHzY2VlLWMfjjCmoSMAYaUw/RslCLgLct2VQUwP+EewV4Arwa3rqbVgd+UlRc9N54YAd042VRqj734jq34d9Bj2g/RzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net; spf=pass smtp.mailfrom=kevinmehall.net; dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b=C8o916Sj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rXQ4sGqt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinmehall.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kevinmehall.net header.i=@kevinmehall.net header.b="C8o916Sj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rXQ4sGqt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4762C1400050;
	Thu, 23 Apr 2026 13:40:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Apr 2026 13:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kevinmehall.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1776966042; x=
	1777052442; bh=eWtbr5dqWZd3m3MctHshuBfTOIExMLaOJtKGOKoZ2hk=; b=C
	8o916SjzcFtReqmIs0JsHbuG2F8fuvpMUe39aAdWDgV1Grx/HUiZmoQe6Sn55ko2
	Cvx4vO/jsRdcYsjdgBLUce3Bp/3qS0RW83FjgvYdJhcGYueZ3i4tIBkLB8uyMsYu
	Bj/CabzxSio9LwVVYnhDx2x7a66zC4br7xdu24qtR5UXgV1fAZI6bXf7yFMwDEkm
	oIiQVGYcXiWVdQL1wq/ZJqvuWhfX8OjtDUKv4ABo23ByatTuEPY3eH5uEInD8IpH
	t/o+PtgCs764EbOMqIrxPZ0BADXBq1NEJrX2BREz2uj4axYJLmApOcTja2yX0bRX
	Vpdh8yg3XS/Df1xfEwTjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776966042; x=1777052442; bh=eWtbr5dqWZd3m3MctHshuBfTOIEx
	MLaOJtKGOKoZ2hk=; b=rXQ4sGqtKVq11G3IbWkYip96992ZT3SccFbUIG9anLU5
	lmDgCZp1UKVeWik5SbMCROY750HZKh0heXJsDhKq9fwDFjZJHQ32VlYiHohvY6QW
	rSV4kEi37g+n23zQBXrGx1C/bJ76EXW24XkZ+h+0nGzwfwgWbBjkXpR1PYtLrHTD
	zmskTHgFpfyM1YmnhJGI14fBFnqQZTa9dFbiH/GKlXKVRG/B9Kfd2YJ/iblWhqNZ
	6HkBS9cQEJbVCwqRh5CTIzn+TMHgka4SMMKO2Q158SjJZvkIKMQl48JLprxPQFnA
	cpZGdxGFYiCtWphd4IJnH/hEHoPCjqqfvKyIdcCO+g==
X-ME-Sender: <xms:mlnqaTJRxDOja3sAq3jWjkjk4l0Lntrm1dekaT3zNQMBAztECpgw9Q>
    <xme:mlnqafWOE2QSNX97uhz-ZEwBQVmsEoRDNbeJabrhPCUTL1coEmfXygytj0U63Pm7I
    y6ZLcjZX99NnD1oXYQaGA-uKccUe5G02fuNCnH0vkRHrmjVq13q>
X-ME-Received: <xmr:mlnqaXS-Gvj7DU2qU16CxwXEwabNIG6norZRCchsR-ZNysikHL8LUQH5SwZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfgvvhhinhcuofgv
    hhgrlhhluceokhhmsehkvghvihhnmhgvhhgrlhhlrdhnvghtqeenucggtffrrghtthgvrh
    hnpedttdefjeevjedvteekuedthefgueejuedujeehkeduudduieffteekjeektdegheen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkmheskh
    gvvhhinhhmvghhrghllhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopeifvghnsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvrhhnvghjrdhs
    khhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhhuvghlsehshhholh
    hlrghnugdrohhrghdprhgtphhtthhopehmihhrkhhoqdguvghvkihlihhnuhigsehnrghn
    lhdruggvpdhrtghpthhtoheprhhstgesrhhunhhtuhigrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhsuhhngihisehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:mlnqaXDV5zf-Y9irZJnQD8yJNwiSccJvsaKeNJehbA9Abr8RcNWjIw>
    <xmx:mlnqaWLEBvJbFwURlDKj9gbYNK3R0trPT90hn-dE6pCq6nzv_wPYyQ>
    <xmx:mlnqaaB8jh7R0aZCpKK8_SxfefZVkbpsWafoftgvfhe_cL98SsxidQ>
    <xmx:mlnqaTvr7XlLp0N66CfIe2ZbgXKKw9SaZBoGwO2EePm-hTWHrBxCmA>
    <xmx:mlnqaWdtXr6oGAapU5t3diqAHemfVmC1mKlfIGLANHwehQyoRwinVXnD>
Feedback-ID: i421842c8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 13:40:41 -0400 (EDT)
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
Subject: [PATCH v2 2/2] spi: sun6i: Set SPI mode in prepare_message
Date: Thu, 23 Apr 2026 11:40:01 -0600
Message-ID: <20260423174001.2797797-3-km@kevinmehall.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423174001.2797797-1-km@kevinmehall.net>
References: <20260423174001.2797797-1-km@kevinmehall.net>
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

A previous fix for a related issue (0d7993b234c9f) was incomplete in
that it only delayed enabling the SCK output drive to prevent it from
being driven at the wrong level when resuming from autosuspend, but
didn't help if switching CPOL modes between chip selects while active,
or if SCK floats to the opposite level when suspended.

Fixes: 0d7993b234c9 ("spi: spi-sun6i: Fix chipselect/clock bug")
Signed-off-by: Kevin Mehall <km@kevinmehall.net>
---
 drivers/spi/spi-sun6i.c | 67 +++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fc228574ed38..983e791e3396 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -205,6 +205,44 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
+static int sun6i_spi_prepare_message(struct spi_controller *ctlr,
+				     struct spi_message *msg)
+{
+	struct sun6i_spi *sspi = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = msg->spi;
+	u32 reg;
+
+	/* Set the mode bits in the transfer control register */
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
@@ -336,31 +374,12 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 
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
@@ -429,11 +448,6 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
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
@@ -668,6 +682,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	host->max_speed_hz = 100 * 1000 * 1000;
 	host->min_speed_hz = 3 * 1000;
 	host->use_gpio_descriptors = true;
+	host->prepare_message = sun6i_spi_prepare_message;
 	host->set_cs = sun6i_spi_set_cs;
 	host->transfer_one = sun6i_spi_transfer_one;
 	host->num_chipselect = 4;
-- 
2.53.0

