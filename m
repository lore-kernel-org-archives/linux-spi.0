Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959454;
	b=rQ7He9gAkL7f7h2C8e2W57mIEXMzrxmDNIjCdCAdVxBJvQi6Ku+TxZ9mK4pjJG7xu1+v
	 Vo63TrIVSc4I70LfN2U5zHRsvrLmAzFPWbv4+MNKYVd8KE2JUE4RFolk09QufSLmxbggq
	 LEThwNjYFOFOixr88FTwZ8ZRQZc/4ahayc25gxCrNIDYMp5jHZu1lhvzDrNO9yrODfYnU
	 C6EKg/SfPPbn9kQzOHNNDIrvR5VdScqgPMvZoqXgx+9c3NB207b7es5GxHJKtHGkg3WHL
	 pYW7sXRim7sjJZI3MKVB1WnpbpF3TO9t7bllVAam6gEnS/CNQYMv/o7q62egLx2ogQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=khN6VDPnjL2LqUdtA4sH+OiPa/4+wQB3zpuMWXL1Td4=;
	b=w/VDaVNCqFT/I5zvt7NUb3WwVmg7tP2bMNRxyqKl4Wuv0gNO2g70ZmePBEQyciLP8CzP
	 SaI1jJPzQYtIDSCpDogMokVyanUViBdbK13EpS0KaH8CkxOmxUZba/QZp0sKu8CAPhK3L
	 FPB7SOaXJjceJAyA39h00Ieyxf+Gf4h2rnWCuirBkduvYPk4ELKfeEamcPOgI4m74b6yv
	 0//85aquJ0h5mWWG4QHu4rFkaKKNnJ/hXEDozdLa4fnE36kWsoUTELkvRKabK93hIgk73
	 7G4MZthdVUMcmfFGnQS6oJklmpQxi+bTwk+cRznzl6kJqOo4+VJpuTW5J9gVI8zY7pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=BZQ+rYVE;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98D606A31C
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 23:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D98D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=BZQ+rYVE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=khN6VDPnjL2LqUdtA4sH+OiPa/4+wQB3zpuMWXL1Td4=; b=BZQ+rYVE1E2AuhqxEk4m8XoOB8
	owdC7L8wRELvw5zwtR/NhsSBpcdW+bq1OG43l/7WuUG2Z6COoy8lYfwQeWvPOmPssf4p6fzdH4+bp
	3cOO8ggcbu7+7PWDkOeQL14Xy5MN5HnsuRQ44TwVJSynryst5Miziidgbr75rnfgJJSqUlGDIZMza
	b4yT9WKQiwkm44jbnb0y9LI9SOFuHHuddldd12fD9P44tdArGuziF1zxM2OKlKTvafHIIqdx1b8dn
	ATZ9Fnmgl7GJ13hF9UkEq81TKzSvp9mjkePrf6I40MZr9WRWj9S65X1s1MktpEPO82JqVBQBJ1tGC
	D0ObPtAw==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 6/7] spi: rockchip: Move to pm_runtime_resume_and_get
Date: Wed, 18 Nov 2026 00:50:20 +0100
Message-ID: <20261117235021.2013719-7-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117235021.2013719-1-heiko@sntech.de>
References: <20261117235021.2013719-1-heiko@sntech.de>
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Currently pm_runtime_get_sync() is used, which increments the usage
count even if the resume was not successful.

Move to the more modern pm_runtime_resume_and_get() which handles the
usage counter better.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 8bb55d52d346..ce1629e5a513 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -255,7 +255,7 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 
 	if (cs_asserted) {
 		/* Keep things powered as long as CS is asserted */
-		pm_runtime_get_sync(rs->dev);
+		pm_runtime_resume_and_get(rs->dev);
 
 		if (spi_get_csgpiod(spi, 0))
 			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
@@ -734,7 +734,7 @@ static int rockchip_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(rs->dev);
+	pm_runtime_resume_and_get(rs->dev);
 
 	cr0 = readl_relaxed(rs->regs + ROCKCHIP_SPI_CTRLR0);
 
@@ -924,7 +924,7 @@ static void rockchip_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_resume_and_get(&pdev->dev);
 
 	spi_unregister_controller(ctlr);
 
-- 
2.53.0

