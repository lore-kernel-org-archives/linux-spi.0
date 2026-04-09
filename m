Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80913C2765;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736327; cv=none; b=mhfTNfArzgrzQIQs/iuKFJX1YedTYJFX6sj+tLzBgwrMSEJ5451VDgfY2sfrwiE9WznYW31hIv0lyEMenZy3s/2Vjf9UWmy3N8VlVC5jpUPMh8x+49dYUbtB3i7vG0GD65ThxdtzwfHikaR8j/Nbe6L/yZM0qm9NOkysF8muSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736327; c=relaxed/simple;
	bh=2KNfJnA46W3qlgDrPGdTrCw4e1Cl0KMREmMjES5TO4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvvQ7ue9LIjfEYqROw/yArkGcYVsAlH1NWuS6ngRo0gJMwXOWVInNclk0vf7LDSccZb9NElJwEdbkASonMnsBH/62vuITzm7O5eEDjoFJgKSf+ENpyX4LwDlbkX4mEDVt9Qwr5ru6g6CexdcxJgw4RMnZlpC7avYl385c9MejBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4IvigfN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4IvigfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74129C2BCF5;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=2KNfJnA46W3qlgDrPGdTrCw4e1Cl0KMREmMjES5TO4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4IvigfNOt3Srbkzd2lP5K8sLhNBkpeW+Jtch1NtBW4kmw6bU1Lyrsji5xg+maVfB
	 PhAgA3mbLr62V97E3Yi1E5SdWc0RKztwZhIWenppAp9qbHtSNco7hPXNOnE9g8Aqef
	 mV1iDPBhvpy5eDUgPWZtZ/EeYdL+I/p5YFUXisautGihB122D1WRwbOCczWuMY50Wa
	 Vl0VZfgknOJexQEyFu5EbSJI4efH0mYWZhQzJCzIEyEEH4keKL1SydLYyNxkN90Zxb
	 yHvnVKhRA0PdBUMNhZ9vhUYN7DcnuIdnhtRxCQeDtaT8RKNmu+apHvgIsPjGBUHIrH
	 eJOY7Tew5m5DQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d7F-0W6T;
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
	Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH 18/20] spi: microchip-core-qspi: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:17 +0200
Message-ID: <20260409120419.388546-19-johan@kernel.org>
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

Make sure to deregister the controller before disabling underlying
resources like interrupts during driver unbind.

Fixes: 8596124c4c1b ("spi: microchip-core-qspi: Add support for microchip fpga qspi controllers")
Cc: stable@vger.kernel.org	# 6.1
Cc: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-microchip-core-qspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index aafe6cbf2aea..eab059fb0bc2 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -692,7 +692,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	qspi = spi_controller_get_devdata(ctlr);
-	platform_set_drvdata(pdev, qspi);
+	platform_set_drvdata(pdev, ctlr);
 
 	qspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qspi->regs))
@@ -732,7 +732,7 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 	ctlr->num_chipselect = 2;
 	ctlr->use_gpio_descriptors = true;
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "spi_register_controller failed\n");
@@ -742,9 +742,13 @@ static int mchp_coreqspi_probe(struct platform_device *pdev)
 
 static void mchp_coreqspi_remove(struct platform_device *pdev)
 {
-	struct mchp_coreqspi *qspi = platform_get_drvdata(pdev);
-	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct mchp_coreqspi *qspi = spi_controller_get_devdata(ctlr);
+	u32 control;
 
+	spi_unregister_controller(ctlr);
+
+	control = readl_relaxed(qspi->regs + REG_CONTROL);
 	mchp_coreqspi_disable_ints(qspi);
 	control &= ~CONTROL_ENABLE;
 	writel_relaxed(control, qspi->regs + REG_CONTROL);
-- 
2.52.0

