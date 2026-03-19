Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831B32C94B
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945546; cv=none; b=V8GoTT/QBzRGayjAVo/f8WgHEOwYm12IVeIx2j2knvnSwrmGT0tg9gGpEFYKtKEiq64pyt/1MwPv+YDoNmNzRQFRhovZtWymKYaBMS3AqmBj2DGF7lX3exbKrFW1f+uW8QdXzAbQAGbCHj6RUqbhs7TIB1gkl9z6ePD7OBm0XmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945546; c=relaxed/simple;
	bh=vhQEfDoEfpNzFcXCQIuYkH3ah3+3jrEC9vhNPcP95bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jEOBKtaO0J2ctl386oe/LYpRb/pqt5aNK9aQjXkpTrLSAZyJk/7qcjB+rrmRwZ8ily3kj+L0VljWmDGNUMkifRvHgbqhLfpjX2+nLxT9aZAC1ZQo8n7Jqj+hF0O1XcGes5TZZwK6ukyKKiDp4SpQNh2XwV7vOlyPIG1EDueXLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3IGg-0005IY-KH; Thu, 19 Mar 2026 19:38:50 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3IGg-0017V2-0o;
	Thu, 19 Mar 2026 19:38:50 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F3A8450891B;
	Thu, 19 Mar 2026 18:38:49 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 19:38:12 +0100
Subject: [PATCH spi] spi: spi-fsl-lpspi: fix teardown order issue (UAF)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-spi-fsl-lpspi-fixes-v1-1-b433e435b2d8@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJNCvGkC/yWMTQ6CMBCFr0Le2kmg2BK9inEhZZQhBJsOGhLC3
 R1h9773t0I5CyuuxYrMX1F5TwbVqUDsH9OLSTpjuNKFsq4upEnoqSONaVeysFLjfAzB17E5e9g
 yZd4DG95gNdwPUz/twHH+/2Hbfiy03Dt8AAAA
X-Change-ID: 20260319-spi-fsl-lpspi-fixes-725c6653c745
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <B38611@freescale.com>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=vhQEfDoEfpNzFcXCQIuYkH3ah3+3jrEC9vhNPcP95bk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjc4zTtbOmZdIbjx4T3+mY0rYrL7CvpqMmtvSlf7Gr0z
 FPl3pTYjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEykMYnhr4TMrsj7/wWPT9Jb
 n+bV+zjuaJt2d2S7YM4G7f8L3jKc0mVkmLqwYE9PZojnYqO8ORLpR3ZMcF/ZKZVynil1LreolYE
 DDwA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

There is a teardown order issue in the driver. The SPI controller is
registered using devm_spi_register_controller(), which delays
unregistration of the SPI controller until after the fsl_lpspi_remove()
function returns.

As the fsl_lpspi_remove() function synchronously tears down the DMA
channels, a running SPI transfer triggers the following NULL pointer
dereference due to use after free:

| fsl_lpspi 42550000.spi: I/O Error in DMA RX
| Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[...]
| Call trace:
|  fsl_lpspi_dma_transfer+0x260/0x340 [spi_fsl_lpspi]
|  fsl_lpspi_transfer_one+0x198/0x448 [spi_fsl_lpspi]
|  spi_transfer_one_message+0x49c/0x7c8
|  __spi_pump_transfer_message+0x120/0x420
|  __spi_sync+0x2c4/0x520
|  spi_sync+0x34/0x60
|  spidev_message+0x20c/0x378 [spidev]
|  spidev_ioctl+0x398/0x750 [spidev]
[...]

Switch from devm_spi_register_controller() to spi_register_controller() in
fsl_lpspi_probe() and add the corresponding spi_unregister_controller() in
fsl_lpspi_remove().

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-fsl-lpspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index b361c1bb3e43..45390e9b8cae 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -1009,7 +1009,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		enable_irq(irq);
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, controller);
+	ret = spi_register_controller(controller);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "spi_register_controller error\n");
 		goto free_dma;
@@ -1035,6 +1035,7 @@ static void fsl_lpspi_remove(struct platform_device *pdev)
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(controller);
 
+	spi_unregister_controller(controller);
 	fsl_lpspi_dma_exit(controller);
 
 	pm_runtime_dont_use_autosuspend(fsl_lpspi->dev);

---
base-commit: 8c89a077ca796a2fe248c584e9d7e66cff0388c8
change-id: 20260319-spi-fsl-lpspi-fixes-725c6653c745

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

