Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393364;
	b=xhFQTSYNE24iKfTLDz5xso8YB7x01VIz0fndKRg5evccolaJyeNbZ76Rz1YlqMo1xc5M
	 bJBbI7Vc0NNajeasVW3IdjHrN0Z9TS5TqIXD8/7u2PZtrvdZ4jYdE/wXEJmS3vK6c1M6h
	 Z+xqeczOkScfT0QKnMXnj/Ghng3X46zuWkwV1Ti17F+9PKpKzKd6kGrSBQ5JEr7NZJ5bt
	 o7tWYpl/hqK2VHK5xpU/Lj+w9YdJq5xz6jf121ljFRKRrTVe4RDUJUsz63XKg92xVszbg
	 VWg8WMxsfLOKM2AuLGnaUxn05vcsCXzMMe45BDtCtzei2G0hBAhQ3TfBNZjHWtYGH/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393364;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=p5JSa0bx8XJ/WrOKH8JXKlh5zXhjuHQcMoZ3qXzM6TE=;
	b=naqeEmfo/ghbJqBN4WzNAM/phr1HeJhkalHA1audeJMuXrEAC8IMlqH81ZfHMRBJw6IN
	 t72liY23i20oXr1qdmBhYHRdo5nsdgl8Z9hfIfZskBR4eO4Vw78eqzbqRWe4Rzg0ksoRn
	 Fzvibfa4eEeaDuvZWAtHIwQxwFe7op6hBeJlhDcmrsprnAPKeBClfvUxW+zBa+UVetBsi
	 JyJdkWv7IO6WqyW+W+0NQJpxVMq2SoP5GVjxD3tWtJYUMbNvcLqRhS/GIF6/uB/5XqciU
	 D5EEiyFFm4124ZV2bUzw7iWpd1inQy1Ibz19Tzk09/lY3/ylqEV+hTv5yqyWe4dqZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=j+edLPGw;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB8606A895
	for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 10:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13EB8606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=j+edLPGw
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 60BDDC79A8F;
	Wed, 11 Nov 2026 10:35:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A75806017E;
	Wed, 11 Nov 2026 10:35:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CDA7311BC17BE;
	Wed, 11 Nov 2026 11:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794393357; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=p5JSa0bx8XJ/WrOKH8JXKlh5zXhjuHQcMoZ3qXzM6TE=;
	b=j+edLPGwasyV6HAyS4hFg5KhjSuMdMX54j0lF7sN8ytL8eR7blL7yTu3lrhT5A5oV8z9wQ
	sppHD6XAKiDUUPwYqasoKEIeMe47igi15FOQEebNUD0jVx58UjtS+Tj1f2HdBwJXZNwfdY
	53q+tgT5uWkpqmrtjeNz/JyM+5iQi2MalSOQVjA4giRa7K0x52/7Qt/vsIjHS96ijdz5qy
	RQZ1phjYl+ctrnJsevFvN5/zxCxutyaqydp0aSOh4v4QBz438S2qbzki11Um9ZuKiLvYd2
	SCfca9ogjBE6KZz9aVZt4/afbTPFWiQlVJNTW3lajUXKdtNDtbdmcI0/6yh6OA==
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
Subject: [PATCH v2 2/6] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
Date: Wed, 11 Nov 2026 11:35:37 +0100
Message-ID: <20261111103541.100848-3-paul.cercueil@bootlin.com>
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

The .transfer_one_message() function uses the STIG mode, therefore the
xSPI needs to be configured to STIG mode before starting any transfer.

Without this, .transfer_one_message() simply won't work, at least on the
CN10K SoC.

Fixes: 931e389ded0f ("spi: cadence: Add Marvell xfer operation support")
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: Adapt the code slightly to work on top of [1/6]
---
 drivers/spi/spi-cadence-xspi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index a584a3c395d0..87b986a318f3 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -367,6 +367,20 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 					  100, 1000);
 }
 
+static int cdns_xspi_set_stig_mode(struct cdns_xspi_dev *cdns_xspi)
+{
+	int ret;
+
+	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
+	if (ret < 0)
+		return -EIO;
+
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
+	return 0;
+}
+
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
@@ -536,12 +550,9 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	int ret;
 	int dummybytes = op->dummy.nbytes;
 
-	ret = cdns_xspi_wait_for_controller_idle(cdns_xspi);
-	if (ret < 0)
-		return -EIO;
-
-	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
-	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+	ret = cdns_xspi_set_stig_mode(cdns_xspi);
+	if (ret)
+		return ret;
 
 	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
 	cdns_xspi->sdma_error = false;
@@ -1112,7 +1123,13 @@ static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
 	int current_transfer_len;
 	int cs = spi_get_chipselect(spi, 0);
 	int cs_change = 0;
-	int ret = -EIO;
+	int ret;
+
+	ret = cdns_xspi_set_stig_mode(cdns_xspi);
+	if (ret)
+		goto out;
+
+	ret = -EIO;
 
 	/* Enable xfer state machine */
 	if (!cdns_xspi->xfer_in_progress) {
-- 
2.47.3

