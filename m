Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0B385539
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650402; cv=none; b=T0j73Z3zdSB6urCiig0nFegBLrBxBmPMrOd4a9KbD6/kviV0sqGQwoEwtA04dgpTJqXkvCwqViJbRnl2CVln7nuLXk5XAUwtDpXimsQuKyk+MIsZcm1mHKeHSRC3eXkbCD6bOPlIctsd1HlUsWqs8wiIg1xg03grjcnOWk1jCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650402; c=relaxed/simple;
	bh=f5Y57eG8kfv3R/Wi+aK20e7GnvgUFwL/0cDZNaR2b3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XQ/18K3gH5tb4FvyiIOsyb7QLQgmeTJz69ezhiQTfFKqvzxtLAzC3varGAF5rUWDRxqfGIYTMHGq9eNcWGPG3qYf4CE8v80z8Cj1i8sXHsx2Hd0I3GGf77uLcUcP1y+71YHK7CGdtEfcFL7Zn5fG3PpdQPaxPmBcVjwGamtbH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005Ru-25; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVD-28;
	Mon, 16 Mar 2026 09:39:43 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5EFB45049BD;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH spi-next 00/11] spi: spi-fsl-lpspi: various cleanup and
 enhancement patches
Date: Mon, 16 Mar 2026 09:39:01 +0100
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXBt2kC/yWMwQqDMBBEf0X23IUkBqH+SulB46bdEmLIqgjiv
 5vU2zxm5h0glJkE+uaATBsLz7GAfjTgvkP8EPJUGIwynWq1RUmMXgKGVJMLNMQ1CVqlrVfUjeY
 5QTmnTJ73v/gFdRlpX+B9N7KOP3JL9cJ5Xk6AID+EAAAA
X-Change-ID: 20260314-spi-fsl-lpspi-cleanups-4014f0e6b29d
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Marek Vasut <marex@nabladev.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1459; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=f5Y57eG8kfv3R/Wi+aK20e7GnvgUFwL/0cDZNaR2b3Q=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfnBPg/On9XdK/zddDBDV0Zpse7KSSW9P0s/nRrNcz
 r6eU3ldv6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATcRdhZFjT0DHnzIbJV6Mb
 UySmXXgq+0VxdcDDsw8P+dmpv3G+unUSwy/mBPUHM/x2W8ex/NK6ybGH/1uV8v+QfV6KfjbLBe9
 GyjABAA==
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
Marc Kleine-Budde (11):
      spi: spi-fsl-lpspi: adapt to kernel coding style
      spi: spi-fsl-lpspi: fsl_lpspi_probe(): use FIELD_GET to decode Parameter register
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use FIELD_PREP to encode Transmit Command register
      spi: spi-fsl-lpspi: fsl_lpspi_set_watermark(): use FIELD_PREP() to encode FIFO Status register
      spi: spi-fsl-lpspi: fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
      spi: spi-fsl-lpspi: fsl_lpspi_can_dma(): directly assign return value to fsl_lpspi->usedma
      spi: spi-fsl-lpspi: fsl_lpspi_reset(): convert to void
      spi: spi-fsl-lpspi: fsl_lpspi_write_tx_fifo(): simplify while() loop check
      spi: spi-fsl-lpspi: make struct lpspi_config::mode u32
      spi: spi-fsl-lpspi: fsl_lpspi_set_cmd(): use mode from (struct fsl_lpspi_data::config::mode
      spi: spi-fsl-lpspi: fsl_lpspi_set_bitrate(): don't treat devtype_data->prescale_max == 0 as a special case

 drivers/spi/spi-fsl-lpspi.c | 91 ++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 46 deletions(-)
---
base-commit: 09be2729dfe984c305b402c13292dc097882295a
change-id: 20260314-spi-fsl-lpspi-cleanups-4014f0e6b29d

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

