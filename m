Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577831;
	b=ooZ1yC5funlzQwAEOSe7I6TNCsBBzxp9B7faECujdBHxGfvDQPmz93cyACAiuXJPhSFx
	 qePvKFp4vR6RY7vyCJWDysSnpWwO6Q41hClwDgCogLaSbGixnvcUHbhlL2HHC7PSX/nQA
	 T8vuKhcDJ5FM9pf9T4DCsE9pIKTbmm+to/uMqxJbr8jWE+BorZCsuG3yVZtZVhQmBKSC4
	 Ul7s7pmZTFvylxU75QT8QYCR+b3noMk6ExkrJ0vHV/qEFKpy0tROkNvcTbpRjij4ISVJf
	 XnNHFsbqVaP1V0TZ5jGEoMUhuhL+Fc/f8Bhr1QUGdMznXAeuX+dKuyddwvTedy7mA4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577831;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=khN6VDPnjL2LqUdtA4sH+OiPa/4+wQB3zpuMWXL1Td4=;
	b=boyxcGejJHxWzsOdB/DlMDt5AcyzfMyCWOaUMv0hWFFA7fPoqkexpoBIGw8/EHY+7Xaq
	 /YCjO6XgTb/Q2MkT4aJecvsUEHIEScx9snL2DwIwQsrrP5wPJkSFQ6dxTqfH9JDKANtJ6
	 4rgLvtza/Echs5JKHHgFxN5ojb2hCG4cwyCSRQGIkfJsHfoh88L6lAdyRso6gW1Kqjwfn
	 FodWnWrtA5fFg9Hqe6jN+yR7aK3Cgm/V6UNriOx56AV3tRIYh44vzr2V7tD28Agi9wlQi
	 K6O8rXNN561HFY6bgyajwEFwadoCKqLacf2CvELuj7QZp+DkqMiL0OdqO+Woyd2MiNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=mhdiNYbh;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23CC606A893
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 13:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E23CC606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=mhdiNYbh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=khN6VDPnjL2LqUdtA4sH+OiPa/4+wQB3zpuMWXL1Td4=; b=mhdiNYbhNfy//abGacUQnpqiZX
	2CDg297VC+uJbfwGwG5bMY3G+EuHb4u3KQgbHImRd4TW80PhvYIC2EDa7JEnopvoiSzqxrSbQoaWn
	A8FA7ZOKzkWyDjXzrN1ay9GRbVul4R/FbegW/jYHopGkff1EdH3RD/1Z8Eekd1uOFjNvRStzQM7to
	3aJcN7Y9/g6NdFcfIZKy+ijWKAsRV5Fbvlk6Q/e32JQajpR9VeAH/v79qpey/mvvMoIX/9beAyP2p
	HKvaeYLmIcL6Avr36mOEL3e5pRwLfyDJO7JTSrQf0Xwu6y6x0/suVRDqwVcB4wOYx1cLrux91hvHK
	pFq1wCSg==;
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
Subject: [PATCH v2 5/6] spi: rockchip: Move to pm_runtime_resume_and_get
Date: Fri, 13 Nov 2026 14:50:16 +0100
Message-ID: <20261113135017.1047959-6-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113135017.1047959-1-heiko@sntech.de>
References: <20261113135017.1047959-1-heiko@sntech.de>
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

