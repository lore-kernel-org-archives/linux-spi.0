Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1102418A2D;
	Mon,  3 Aug 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768266; cv=none; b=chJimTUqlnrcDZ4PS4VVSbo6VpGElzAJNd9w92FNOEOoMqLOekJ2LF0nEz/OV53p48rvkUjNCuYs1QguJO+gYTy+zBILwrNkpCUZ6eWwGJr8sXmlW+kwGQ/C0ndTBcDWdGD9LxRjFjfTpghnN9SyILVfHwIKgN96UI7Oz5r4HxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768266; c=relaxed/simple;
	bh=OZMf4gTIrZ/pVY27YsjH+kf+35klhlZ0okl4yrZutk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfire+EvWACYJ9P+2edxHJVoYHLb9k7jbjK5XkFgZB9bFH5V7bqtcjPpImHkLhBjupk9sA//bfvMfZ+I4aPmztkHZH4gmbNY2eLRcnFcsv05CuDo/n2mahKLUzUCVA/LoCmicGonUb/VFu6YpOw9BrppH7rOEVO/x9nfhRzpdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok4kDBXP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok4kDBXP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591581F000E9;
	Mon,  3 Aug 2026 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768264;
	bh=4BXG8pZY3UvhCBljpc68bnMGflRKin05J/fYHypUzMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ok4kDBXPSJgspsKclwuqrWvx1gikabqhUoBWl1UTXy4VvijFBTYHJ8Besb/e1EjGu
	 3oWTEE3S/wuNNjQcZpMEAN/2aqgZR9CsCyiatv8/J+9uLpJnfLSolhiBWh2W9g0QXv
	 CBk+HiMdtY4wYrVzLuOH04wHdm4vXOQXAuwxZIl95GCPxvmbGHI6o9rEDDGGzdw7PP
	 bUOddhnTLrdflFUmwpH0upbXWRwp/rY+7QZv3b7f/7a09GJNO8nJ/SvTnYcelEQEUt
	 TOtpmZ67F8Uezvo4nvkMDf7Txn7ssqS5l7jqIAB7g6DGCGqF7h04LjE8k80taspWlE
	 +NemcXfMoYH7Q==
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
Subject: [PATCH 22/39] spi: omap2-mcspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:46 +0800
Message-ID: <20260803142003.12857-23-jszhang@kernel.org>
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
CONFIG_PM_SLEEP are disabled, without having to use __maybe_unused.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 9cc078acc13c..a3355147f5de 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1620,7 +1620,7 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:omap2_mcspi");
 
-static int __maybe_unused omap2_mcspi_suspend(struct device *dev)
+static int omap2_mcspi_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct omap2_mcspi *mcspi = spi_controller_get_devdata(ctlr);
@@ -1639,7 +1639,7 @@ static int __maybe_unused omap2_mcspi_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused omap2_mcspi_resume(struct device *dev)
+static int omap2_mcspi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct omap2_mcspi *mcspi = spi_controller_get_devdata(ctlr);
@@ -1654,8 +1654,7 @@ static int __maybe_unused omap2_mcspi_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops omap2_mcspi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(omap2_mcspi_suspend,
-				omap2_mcspi_resume)
+	SYSTEM_SLEEP_PM_OPS(omap2_mcspi_suspend, omap2_mcspi_resume)
 	.runtime_suspend	= omap_mcspi_runtime_suspend,
 	.runtime_resume		= omap_mcspi_runtime_resume,
 };
@@ -1663,7 +1662,7 @@ static const struct dev_pm_ops omap2_mcspi_pm_ops = {
 static struct platform_driver omap2_mcspi_driver = {
 	.driver = {
 		.name =		"omap2_mcspi",
-		.pm =		&omap2_mcspi_pm_ops,
+		.pm =		pm_ptr(&omap2_mcspi_pm_ops),
 		.of_match_table = omap_mcspi_of_match,
 	},
 	.probe =	omap2_mcspi_probe,
-- 
2.53.0

