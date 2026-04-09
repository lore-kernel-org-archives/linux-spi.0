Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40BA3BADBC;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=Ei2fZSqi8LkKxWR6ZmOeEMmLLv9Vj2B7q/fTk40wvmNIYW61nlJl+m+As5GSpBA08OJgIIWvoOo5VdsQuG35xdQJcvsbWVfLWF1GRCRKTnkECdUoDw7Qq9B38zFGLWP0JSTsTKy0z05ekQM8CXPczo+vZYA00OSla8HXmLgR96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=gmUCnOtpHlH2RP6FEbCaeVZvSC4xlg/P2/ypqyFLFxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a74pnPAyWLJsI3k3BfTu/4RmN03ExRO5GMYZV1TbzouN+iEFsLKg0Zz7miuny5xKYQ0LIsphFw+xh1xooXok21CU3q69/roXqDGhKqIFYw7HOjidxYyEr+RpOerHEsDvFnxPhEzWdliKjHp0Fu8UTI2QlABTlRzLwUGOw8++kes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVaeA2XB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVaeA2XB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F976C4AF0C;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=gmUCnOtpHlH2RP6FEbCaeVZvSC4xlg/P2/ypqyFLFxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVaeA2XBcXjz0GW/shNX+DY+fqDqD+5+byyoVWjHhkIqIX4YfdXhhZijVnsHEpyQs
	 raOko6H9cvlB9hICc7lDM88w4zKw+1pHaIBrJXPAjWWjd+W/p4b3xOym4voyVwpQWY
	 HWfwUdFmuZA6GvdNW8rkUxBKuc1bAtLbtTUHXjoC0XWFBnAHQqL2Jc7Dte8mA6zzOb
	 Fe1VnL6ZqpMOC9YudjmjTu/+yNWKfdbl2O0VZP5bpqtr3arwBbgacQ50zdUsX+uZpl
	 u2g2Nr8RkES3f1Anrdlb2uGHlfpVniUMmyGN4HkZ7onWciLVIJyHmVHvb+VXs3KoQi
	 mrnUzdE/BBaKQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d7B-0RGc;
	Thu, 09 Apr 2026 14:05:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 16/20] spi: lantiq-ssc: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:15 +0200
Message-ID: <20260409120419.388546-17-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before releasing underlying
resources like clocks during driver unbind.

Fixes: 17f84b793c01 ("spi: lantiq-ssc: add support for Lantiq SSC SPI controller")
Cc: stable@vger.kernel.org	# 4.11
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-lantiq-ssc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index f83cb63c9d0c..75b9af8cb5db 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -994,7 +994,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		"Lantiq SSC SPI controller (Rev %i, TXFS %u, RXFS %u, DMA %u)\n",
 		revision, spi->tx_fifo_size, spi->rx_fifo_size, supports_dma);
 
-	err = devm_spi_register_controller(dev, host);
+	err = spi_register_controller(host);
 	if (err) {
 		dev_err(dev, "failed to register spi host\n");
 		goto err_wq_destroy;
@@ -1016,6 +1016,10 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 {
 	struct lantiq_ssc_spi *spi = platform_get_drvdata(pdev);
 
+	spi_controller_get(spi->host);
+
+	spi_unregister_controller(spi->host);
+
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_IRNEN);
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_CLC);
 	rx_fifo_flush(spi);
@@ -1024,6 +1028,8 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 
 	destroy_workqueue(spi->wq);
 	clk_put(spi->fpi_clk);
+
+	spi_controller_put(spi->host);
 }
 
 static struct platform_driver lantiq_ssc_driver = {
-- 
2.52.0

