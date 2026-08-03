Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6163438A2;
	Mon,  3 Aug 2026 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768107; cv=none; b=a7oNpRkM/v/kp5yqnG68keV5lM7LdAkbWkVMLukVbLjHqljWquvyLqTPejghKM4COBH7l0kG8s5Sdbwka/yZ6UAOE4qsZJrIYCMMWjUHEZsLDnzcd3M4umdo9Insi1z1+zZF0pAzSDAdYHDKUPan8t74FEGX1pjXa7ZqIbUZJbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768107; c=relaxed/simple;
	bh=gz3szEOCrC9R8SjBVtMeP8ZWLxODaFtFa8nAVXagjkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfBrfPgDIJv0NZBdFCliQwhljSrg/DCaxXIM7lolWtvyG+a/D+R7IrYeNfoZAlor7OsU9ToUB9ypZPKt1en2I64bujX1kTjCAsS2V2FYMYMSah4eUbaEbA34YkFF48A3Bw382xSYkEJ6djl3+bXtYFTOzMqhtpnX8XBCCgp0iJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=likeEqfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="likeEqfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436FA1F00A3E;
	Mon,  3 Aug 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768105;
	bh=ky+A7/Ksh+2lxFezuifq/rx0NQiQ9BbBRodbWBfFtU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=likeEqfAZs3IraEH3/HWcIP6S2RCdbSJVDku0V5SrfxRGNeKXB3eD8XmagMR2MmM5
	 JTY35EDCby1ZnwxxwFG4UHNH/LAJa9P8ldTvgBuSJfvV98Qj+XKqjmg25E3QfgdbqQ
	 eSXbuJsBSQanQve0jsz2eVkMu7PcLdy6qe/xomb9LkFj05YR9oJrDhkBV9Fx4/WVd6
	 WI62WAZYL0h2gAG11XtLizthA0YOZ+a6WzvNUQhTn+VM+4WBV7pnZ/xRXaHmdQQZeY
	 DhYCv1bHPJmVLcvh4H+6cobBOcPSJa9aY22ybzYvABN5JsHShyjzV0Po/8PQazKinb
	 2+8eBr3Y0d0hQ==
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
Subject: [PATCH 09/39] spi: coldfire-qspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:33 +0800
Message-ID: <20260803142003.12857-10-jszhang@kernel.org>
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
 drivers/spi/spi-coldfire-qspi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 3b175c1da36b..3c8290e08b6d 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -437,7 +437,6 @@ static void mcfqspi_remove(struct platform_device *pdev)
 	mcfqspi_cs_teardown(mcfqspi);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mcfqspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -462,9 +461,7 @@ static int mcfqspi_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif
 
-#ifdef CONFIG_PM
 static int mcfqspi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -484,17 +481,16 @@ static int mcfqspi_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops mcfqspi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(mcfqspi_suspend, mcfqspi_resume)
-	SET_RUNTIME_PM_OPS(mcfqspi_runtime_suspend, mcfqspi_runtime_resume,
-			NULL)
+	SYSTEM_SLEEP_PM_OPS(mcfqspi_suspend, mcfqspi_resume)
+	RUNTIME_PM_OPS(mcfqspi_runtime_suspend, mcfqspi_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver mcfqspi_driver = {
 	.driver.name	= DRIVER_NAME,
-	.driver.pm	= &mcfqspi_pm,
+	.driver.pm	= pm_ptr(&mcfqspi_pm),
 	.probe		= mcfqspi_probe,
 	.remove		= mcfqspi_remove,
 };
-- 
2.53.0

