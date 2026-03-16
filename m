Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD3355F48
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 08:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650398; cv=none; b=EX9l37BIJn1sPwipUPSwvXROxAcSoX5JsjQJlYuHvKuSnR1baNV1HjekeqgPDxYzYifyuVUGY/V7W4xFrQkIgW8VrE87exquJWhcV6ZZusk5czMlWfy55r9+0VGJHpk5tyvivNcEAw6igbyRS2rsjAq/1SLsIqwGLQcWMsuw3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650398; c=relaxed/simple;
	bh=xfuZBuTtOxab+LBEJpXSlzw9L/LLXDkIoyaxaIUuh+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2M8M1Xu4GQsxVzUJ2Za8qAht1IDB2GSJj0KrWWmHphC+gawI5UBL1PypJ44uLgtzY1bLrDJD6fEvrv1lfOwE0ANCnZMMOYHISpx8eCHeDghAeBygsKfUFDaRNPIESPGWZx6T+GXTYdKH3xtXH1k0yaeKXHDI0nQRYTMVHKZbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UG-0005Rz-6q; Mon, 16 Mar 2026 09:39:44 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w23UF-000XVK-30;
	Mon, 16 Mar 2026 09:39:43 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 931E65049C2;
	Mon, 16 Mar 2026 08:39:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 16 Mar 2026 09:39:06 +0100
Subject: [PATCH spi-next 05/11] spi: spi-fsl-lpspi:
 fsl_lpspi_setup_transfer(): remove useless spi_transfer NULL pointer check
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-spi-fsl-lpspi-cleanups-v1-5-1b695607702d@pengutronix.de>
References: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
In-Reply-To: <20260316-spi-fsl-lpspi-cleanups-v1-0-1b695607702d@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=xfuZBuTtOxab+LBEJpXSlzw9L/LLXDkIoyaxaIUuh+E=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcfvCgVvS2qe+FMmft38e2Usa33FNy580+w8K7niaz7
 sV4nxf83VHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ8GUwMjzI7jROXv3Ku/Gb
 T+a+YnMZu5jObYYvOGwXbFdTqP6VsovhD/fk1V/mzdzAncD893DJ8UJRDhXei5oHJ0mLCLe8v58
 7jw8A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

fsl_lpspi_setup_transfer() is either called via:

| fsl_lpspi_prepare_message()
| -> fsl_lpspi_setup_transfer()

or

| -> spi_transfer_one_message()
| -> controller->transfer_one == fsl_lpspi_transfer_one()
| -> fsl_lpspi_setup_transfer()

The first call path already has a spi_transfer NULL pointer check, the
second one explicitly iterates over all spi_transfer of the spi_message.

Simplify the code by removing the useless NULL pointer check.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 139d6573a013..1da2084f582d 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -476,9 +476,6 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(spi->controller);
 
-	if (t == NULL)
-		return -EINVAL;
-
 	fsl_lpspi->config.mode = spi->mode;
 	fsl_lpspi->config.bpw = t->bits_per_word;
 	fsl_lpspi->config.speed_hz = t->speed_hz;

-- 
2.51.0

