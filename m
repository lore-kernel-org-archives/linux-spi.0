Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61A37187C;
	Mon,  3 Aug 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768335; cv=none; b=A/mqLsnv4mvtsgNLW/7ZCn5fyYm+iuhK8ZSGbJ9BHleww+eqHrNk5tFbCvVE4+7iqJAV+OPpPU9c/q7YB1Gv2VfFmJzw4WpTB826297Xn3I5R0CwyRKVVJkskDyxJZlozRhSsXy0yZRpYx+//w1clSmZDHRjZbEvgfly9mYTMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768335; c=relaxed/simple;
	bh=J9A0Un2PWtIhfI338cDbcnzA6xh883TV7fFuwTjAEDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgcBurED82RUusvLRSawS+GxN7uKxGrxRRDV+kTKKVfsSgIYF2TbBos7+e15b8WHUWoMUnrrPjxT5aj+ug8NgqwG6HTWCjCBwT6XbyyRkmzUcuHa4EiE2f0XrsmALEfGU0XbADNh5M+dbeDvbR/iYcB6Dd7HnoA4BUaqkHJ2oek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM/WTBAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM/WTBAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7D51F000E9;
	Mon,  3 Aug 2026 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768334;
	bh=D/0nUPO3LXoRbsEgRI74rqRRQDZqRdYuJsmYZrG/oqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eM/WTBARuf4/9PK1noMQWUHTY9L3DQlycPf6W8PFpzN2TEm+z3RznQrJ2Urv+Y94S
	 aTl0EGQxAo07mQCKOG8zHivnOu+Gbfj3rOVchMfF2FTiA2LT9AfAJXRZqHkWbsddN/
	 Dhv9vNXSz1Kv5mylxJel96PdsXyYGwRogUmZkKi9BlYSlxnPai1my6voGhxj/xdjYd
	 AM7zlwSsbzVBPUc6ycTPjwPC1veD77dlY/mAP3+Q8pHvSgDBydAdLf/LYw1/quypN6
	 tX/2ppP3tshoVV8ADXL0wMdIHCt2Fht2NRs46UNSV3XsJ+VBQv5GEIQsNCchZaegyl
	 nXHQB/xLQeoxA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Li-hao Kuo <lhjeff911@gmail.com>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Michal Simek <michal.simek@amd.com>
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 28/39] spi: rockchip: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:52 +0800
Message-ID: <20260803142003.12857-29-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803142003.12857-1-jszhang@kernel.org>
References: <20260803142003.12857-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-rockchip.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 231fbcf0e7aa..1a81fd94b439 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -938,7 +938,6 @@ static void rockchip_spi_remove(struct platform_device *pdev)
 		dma_release_channel(ctlr->dma_rx);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
@@ -972,9 +971,7 @@ static int rockchip_spi_resume(struct device *dev)
 
 	return spi_controller_resume(ctlr);
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int rockchip_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
@@ -1002,12 +999,11 @@ static int rockchip_spi_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops rockchip_spi_pm = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
-	SET_RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
-			   rockchip_spi_runtime_resume, NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
+	RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
+		       rockchip_spi_runtime_resume, NULL)
 };
 
 static const struct of_device_id rockchip_spi_dt_match[] = {
@@ -1030,7 +1026,7 @@ MODULE_DEVICE_TABLE(of, rockchip_spi_dt_match);
 static struct platform_driver rockchip_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-		.pm = &rockchip_spi_pm,
+		.pm = pm_ptr(&rockchip_spi_pm),
 		.of_match_table = of_match_ptr(rockchip_spi_dt_match),
 	},
 	.probe = rockchip_spi_probe,
-- 
2.53.0

