Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E533B966;
	Mon,  3 Aug 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768121; cv=none; b=l1vq+6zcbXz0cevJNc3agqv7bApV+/Xu6x1hoeqYpWrydCfERIl7cyNpZb91sSOXJqsravo+wYdyj9k5/ZWj3rcGDqG/zcA9cvNsxqBzs7asfH6VQKwalm4UgKfu+9Blwp7HF9dY9zuyeAMQkzetAwgCQn+DAGY03Gmx4l0eRvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768121; c=relaxed/simple;
	bh=1wd+C6cKWSo6dzRaHPjd4tZ420rBctZI2BavERGy3oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYNFXooHc8YebLVBut6S9XqkZsJnzl/UGnP3S49sCbaZoyS23Dv8f9+oxBUlnWzAx7uVpKqXJuD+sSmBG2ZrXdbGfgc3tHkHvPtKFq9HiiWjYubdr2PAUpy2VuO5GDaoCGAmlnpDMEnMhK5aUuSiBfo6mT4bc79Cl8DK4CJ82+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXPZVPib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXPZVPib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1921F00A3D;
	Mon,  3 Aug 2026 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768119;
	bh=nwXyZFKSpehk0+5nBqQkijz+4Lthn5Q3qCLKD5iQ6D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXPZVPiba0MM0l+dBNlq6FZzsCYfKNT/Xf/ohaVI2I0fqk+H28B+AvHOt2yKSigpx
	 mn2RiOVVH4Y0II8nZguX3XlEjX/dsXOxXEmcLadpbKX43OLIgpC3qhWC9buOAG9mfD
	 /I/m99+rbMmF8U/cBcap/CMtowrrLVesBtmI2zzyDHvlyeiQm1ZJrp93yHBmXs/con
	 yKrZnvyT2NucCV8EhBu9iIPVl/CMhxdc7RoBVI3QT9XO9ndFEo6OX/DWgi6TtILUaX
	 B/lETaA6Zy+nW7eAf64B7Q9/sksQy1bkYT+kaFMB0F1WUQqJDytKigIRq7RJnOSnlK
	 q951pAGsyuhaA==
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
Subject: [PATCH 10/39] spi: dln2: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:34 +0800
Message-ID: <20260803142003.12857-11-jszhang@kernel.org>
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
 drivers/spi/spi-dln2.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index 8333dda7d1e8..60085ed04a06 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -787,7 +787,6 @@ static void dln2_spi_remove(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dln2_spi_suspend(struct device *dev)
 {
 	int ret;
@@ -834,9 +833,7 @@ static int dln2_spi_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int dln2_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -852,18 +849,16 @@ static int dln2_spi_runtime_resume(struct device *dev)
 
 	return  dln2_spi_enable(dln2, true);
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops dln2_spi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(dln2_spi_suspend, dln2_spi_resume)
-	SET_RUNTIME_PM_OPS(dln2_spi_runtime_suspend,
-			   dln2_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(dln2_spi_suspend, dln2_spi_resume)
+	RUNTIME_PM_OPS(dln2_spi_runtime_suspend, dln2_spi_runtime_resume, NULL)
 };
 
 static struct platform_driver spi_dln2_driver = {
 	.driver = {
 		.name	= "dln2-spi",
-		.pm	= &dln2_spi_pm,
+		.pm	= pm_ptr(&dln2_spi_pm),
 	},
 	.probe		= dln2_spi_probe,
 	.remove		= dln2_spi_remove,
-- 
2.53.0

