Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78C3502A5;
	Mon, 16 Mar 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646568; cv=none; b=tDdoXFT6SG0lcsVXRorTyCdKvyoQAN5HTJT7QU5LysvowsfS+EJaMZFi5MA5zC2MEV8qVWYrBG1br0GIFXrSZ+wQthi4DxcHKTBay4mj8KEsPtMD2Ov6E5yOMg8L2BjYAj5dg7Oay82HKp2hy+IdjipzpAY7qdJ28f8mZZykNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646568; c=relaxed/simple;
	bh=2ubS2qnPkPudQEnTuJ3t2t63NV81Kdy+xZzs1jM9VaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev74A6svLIq/bykpKw3ra9i+pQyZFFbVEsIlLmNzXGAr5lpaEqcOX+6SMiMbWp4YHstdLDJmCrSvRL4uoMjVJ5382jk1+l4BTfIlQsqISntvTpGOEzPdIr6gkA5KfE38p/xNSGM9PDyvbJn1LBTn4NOtI9FqSvkBBUyfqr3Dbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=LkozeCjE; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="LkozeCjE"
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id C86B520735;
	Mon, 16 Mar 2026 08:35:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1773646557;
	bh=jWspq/mVUrwz2X5u/LQpuWjjmowam1smt13kBCpMazw=; h=From:To:Subject;
	b=LkozeCjEFYbV0XUbpaFaXgbpgzU7jwK/53gftC5UPAUKgwUurlD8HwQSyElgRiGGj
	 LNb/7crzcX9uBxSBJ0ASwVFV9qRm7tczsMk4l2aMQ9boKuDX/C7W9GzB0SsOh6pJnB
	 SOQMtVN7ArjqrKbTE7PAS7EvupRCSpJrq8UO8B9dNdgChxycrIw1X/MBgFXr8v4h72
	 26RUSIUewozGcC5l3dInPnKctafSSV5ctOd4Q09bE67yZqAyw9UIuxd2V1r53vEZSl
	 0xZQJeW4COnqD6AGITDZ4gYWv1PFS8VSGhQTXfjXk8xW602CMnRQw5OGtcenkDh2W5
	 zlAcbdjZNcAiA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 2/2] spi: spidev: Add data loopback OF compatible
Date: Mon, 16 Mar 2026 08:35:44 +0100
Message-ID: <20260316073547.11437-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316073547.11437-1-francesco@dolcini.it>
References: <20260316073547.11437-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add "spi-miso-mosi-loopback" OF compatible, that describes a
single wire loopback between the two data signals, MISO and MOSI.

This kind of setup can be used for testing the SPI functionality.

Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 638221178384..3874fd449580 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -701,6 +701,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* semtech */ "sx1301" },
 	{ .name = /* silabs */ "em3581" },
 	{ .name = /* silabs */ "si3210" },
+	{ .name = "spi-miso-mosi-loopback" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -735,6 +736,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
 	{ .compatible = "silabs,si3210", .data = &spidev_of_check },
+	{ .compatible = "spi-miso-mosi-loopback", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.47.3

