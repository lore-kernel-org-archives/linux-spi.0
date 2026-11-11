Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393358;
	b=begZ1kmjb2JZvUc2aUUVe089K59lIrIh0kdjXtHhs5p74NJLQ+UbEeYlcoMIN319DW4I
	 vytFuzzzRk4TspYPtdfytrr1E3juEzoKTE0Au4OFP2ShkqmPncSxP/fNkSF7KKUOrZ2ah
	 1MxyYDfhvLiFBlkSHXelS53E+nqeisZl+9B17QeXGG323UHIkv0RHaRZY0AFcm44mInX7
	 buwfEeORKumRlVUj7kHmyfSNl5g9mj1qUYmBhm/W8Mgzpw8PpRotCg8E0PX9HPgF9n+YB
	 6vtdjwuBi6huzFXLXgQrD+LcWJM16CmC/npXNNtodp8okmoztlUH2hzOaNEj7ayqMFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393358;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=nCz3fa6A/r5LzQW3N9lQP785s7HtokjmZ13zhjbd3T0=;
	b=1xel9M1e4Dp5X1k0ZuNtIB5mExgkKeCG/x2ZRoWfz10DrNjNR3n5XXgGwr5FJzNSOMMJ
	 ouIhQOz3ta2evr/8Pm63EKvx15cri1NhnsgXt0Oq/L9/uPnCLNHHMIzGjC1F31YBgzfHB
	 N5p3pSRN1ZOGpu648C2hiz7Vvw7I3aP7k7hznkfG3Z0/0F7r1a04r+8IMjGABlFbHxGED
	 mP9G5F8kF8rE+emFeyGRkgeg12sejwEJhGJd4c3CZ3FoqoZETVGSEksd8hqHWe2JswhWI
	 SqqVykOu5yIZChTeJvexAww0nWzRwUfkfCvukt+qlvs/v+dGlzC2xQB9gg3SDexzMFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="2GwT/lwy";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8949606A330;
	Wed, 11 Nov 2026 10:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8949606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2GwT/lwy
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 328FD1A15DA;
	Wed, 11 Nov 2026 10:35:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 092D06017E;
	Wed, 11 Nov 2026 10:35:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 345AA11BC163F;
	Wed, 11 Nov 2026 11:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794393355; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=nCz3fa6A/r5LzQW3N9lQP785s7HtokjmZ13zhjbd3T0=;
	b=2GwT/lwyUTGTC9BhU2Exs5SZO6b1p5651GCfJ9hOXr1BN2uHWRNoexssa/B5rq2Ure4HvR
	a/SnfKr7tFqCGpRf7eO9Ja28r1nzYS7Z/F6NmfbQYfTbq02yyANTxVnyirpyxXj9wtOZxv
	edhE3AhvrCjYApTtOVIUtG+v7WEDRdDsKtT3b/lxuznUO6uzVMZrLvIbgHWuBXaKHUH7Uf
	4hQXYp5W1gXsJ44qsleO3jTQtxPlUcTdEjwPP8fZTg1cAz6FaZUEZitPbTP+NpEHEaipdr
	zljrPvh+RV2uAN3cxO7e4o5oRchtH/rlyAxWs7rTMY0Ax5TUvNZkrQWXpuLulg==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v2 1/6] spi: cadence-xspi: Properly handle errors in .transfer_one_message
Date: Wed, 11 Nov 2026 11:35:36 +0100
Message-ID: <20261111103541.100848-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111103541.100848-1-paul.cercueil@bootlin.com>
References: <20261111103541.100848-1-paul.cercueil@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

The cdns_xspi_transfer_one_message_b0() function was not setting
m->status on error, causing it to be stuck at -EINPROGRESS, confusing
the SPI core.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: New patch
---
 drivers/spi/spi-cadence-xspi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3687853e4ce4..a584a3c395d0 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1112,6 +1112,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
+	int ret = -EIO;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
@@ -1152,7 +1153,7 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 							  false, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 			} else {
 				cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
@@ -1161,11 +1162,11 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 				cdns_xspi->sdma_xfer_len = current_transfer_len - 1;
 				if (!cdns_xspi_is_sdma_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 				if (cdns_xspi->sdma_handler(cdns_xspi))
-					return -EIO;
+					goto out;
 				if (!cdns_xspi_is_stig_ready(cdns_xspi, true))
-					return -EIO;
+					goto out;
 
 				if (rxd)
 					cdns_xspi->in_buffer += current_transfer_len;
@@ -1202,10 +1203,15 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 		cdns_xspi->xfer_in_progress = false;
 	}
 
-	m->status = 0;
+	ret = 0;
+
+out:
+	if (m->status == -EINPROGRESS)
+		m->status = ret;
+
 	spi_finalize_current_message(controller);
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
2.47.3

