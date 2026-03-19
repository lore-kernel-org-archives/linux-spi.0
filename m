Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FE3F0765
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939377; cv=none; b=nviD0ECI418R+d2NHfzgUIhq/2R2Ok2YqS/ZaNdByamdHFk9rWSZ5KYr8CHMfh2jgV2y79rdfg1FUhToyDs7cbwG2qbZWk3upoIBflUBWtqPkIPpAxunMo91PxMMXqwjUfYXq8fcRfk5RP/tfp7jKPZp6xiMhUM/jK2Nio+p5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939377; c=relaxed/simple;
	bh=KxiwZ0iwLDKyLQQM0h9K6zpDDhS6fHBzGkiS6fXqY3w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EhpI82w+ytpCXnUexLNau5KK9FsPIJFU++mfTjIQ26sSw+YtpboDNHhCc7afrxVyWo9sitp5u9iO20I9RKKnnWK8V1SgsMCptn0+bcBC4ANrTilGg6QO+C43VEA5wUcDX+ac45J50xugQPrkIYhZkoqh9K/T575Ka4n0ALLET4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf1-000546-Ac; Thu, 19 Mar 2026 17:55:51 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3Gf0-0016i8-2f;
	Thu, 19 Mar 2026 17:55:50 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7FBB750877C;
	Thu, 19 Mar 2026 16:55:50 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH spi-next v2 00/11] spi: spi-fsl-lpspi: various cleanup and
 enhancement patches
Date: Thu, 19 Mar 2026 17:55:34 +0100
Message-Id: <20260319-spi-fsl-lpspi-cleanups-v2-0-02b56c5d44a8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYqvGkC/3VOSw6CMBC9ipm1NW3FElx5D8MC6ABjSGk6hWAId
 5eiW3fv5X1XYAyEDPfTCgFnYhrdTvT5BE1fuQ4F2Z2DltrIq8oEexItD2LwCTUDVm7yLDKpsla
 iqXVhYQ/7gC0tR/ETktPhEqH8KjzVL2xi6k3enjiO4X18mNWR+M2Zf3OzElKo2hQ3I/Ncavvw6
 LophtHRcrEI5bZtH24F2GDdAAAA
X-Change-ID: 20260314-spi-fsl-lpspi-cleanups-4014f0e6b29d
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=KxiwZ0iwLDKyLQQM0h9K6zpDDhS6fHBzGkiS6fXqY3w=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjco9XR1nj41up7rL2Mf16dkyltSqtz5LngzXxwevL6/
 lX/ZJwMOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRs4sYfjHbB+oq3P/qanAk
 u95tv8784o0TYu5/SmmSS7+YV53MPo+RYXe04oY7M2e4xU1v+HuV/d8eRwvjEHtD0Rl8sqKMYud
 ZeAE=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

While optimizing the spi-fsl-lpspi driver, I created some cleanup and
enhacement patches.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes in v2:
- reorder patches
- patch#3: add sanity check of FIFO size against watermark width
- patch#5: new, remove obsolete assignment of TCR_CPOL and SPI_CPHA
- patch#11: dropped
- Link to v1: https://patch.msgid.link/20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de

---
Marc Kleine-Budde (11):
      spi: spi-fsl-lpspi: adapt to kernel coding style
      spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Control register
      spi: spi-fsl-lpspi: fsl_lpspi_probe(): use FIELD_GET to decode Parameter register and add size check
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use mode from struct fsl_lpspi_data::config::mode
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): remove obfuscated and obsolete assignment of TCR_CPOL and SPI_CPHA
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use FIELD_PREP to encode Transmit Command register
      spi: spi-fsl-lpspi: fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
      spi: spi-fsl-lpspi: fsl_lpspi_can_dma(): directly assign return value to fsl_lpspi->usedma
      spi: spi-fsl-lpspi: fsl_lpspi_reset(): convert to void function
      spi: spi-fsl-lpspi: fsl_lpspi_write_tx_fifo(): simplify while() loop check
      spi: spi-fsl-lpspi: make struct lpspi_config::mode u32

 drivers/spi/spi-fsl-lpspi.c | 90 ++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 41 deletions(-)
---
base-commit: b876ebf2c06042f78b2c9c47c53ffe54c7e480a2
change-id: 20260314-spi-fsl-lpspi-cleanups-4014f0e6b29d

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

