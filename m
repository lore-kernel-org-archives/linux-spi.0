Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87040DB4F;
	Mon,  3 Aug 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768361; cv=none; b=d7W3Av0WuRR+86mMLKhZslVSMQ8YauJNTvBR3ODaS2WUJVMVJhkIMO05ssPV5guiawXhtfK8/WdhXQW4FVHXDTkblwogvUrK6FbXdevC8rphK/u6abqEfzm1C4QDW17gHaitK/eXWrnPEdFnePGyZlFK3x1xN10Xhs13prWVfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768361; c=relaxed/simple;
	bh=WFIEy6suPs1OdQ+ryAPSruzzL4O/23jj52//B3K2UJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTvwFy03y5mGPnBRxZj/dp1oaL2aZSZqMNAyoQoumExvTFlIhqbVADaaExC3DO/Z6ZxhHBA+eQBAZw3q8T90hEpwGVwjSJ/Km449BAE8U5GR8Ftp8nkh8LjLpqHXyc+QedtUbgAAyTsXVSSUUNw7kwCF6vd8rIEg/IdU/s8ydZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flOQioMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flOQioMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DF01F000E9;
	Mon,  3 Aug 2026 14:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768360;
	bh=W/NXd+U/0G3pDXNPmzPOS5y2jm28gjnRLqb4Yq2jPwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=flOQioMJGeuKecaFMlgpIPxbIRWs2QugbDyNU78eE69PH2dfVrM+NT6V8PillfQ0K
	 QIIzNYN5UreR68iwjXXDG4oX8IfwkfBrhxmHSF/cVle0hOEDgmCn3CJXMQFPPkFwi1
	 IbHzuo7/HSIrd5gMTiQIYO2IJ+oJkJK70eIfHZXdMmn31R9f2L6QAfQII176+2MJOx
	 IH9FegxyUStvvou0WG5aTGpoa81gEDgljw5o0CDRtYEvDc2vD1HbyrvLqXOvuxwPRy
	 Ek+3t5FsKckBwezIQ+0kSVAy1Swh6SWtl7JPj7WvJ93rI39Ghc3AI3JBaTo9is/ML0
	 01Q9E95/B7OWg==
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
Subject: [PATCH 30/39] spi: slave-mt27xx: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:54 +0800
Message-ID: <20260803142003.12857-31-jszhang@kernel.org>
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
 drivers/spi/spi-slave-mt27xx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index e60ab4c18bed..256b510fa676 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -471,7 +471,6 @@ static void mtk_spi_slave_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mtk_spi_slave_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
@@ -508,9 +507,7 @@ static int mtk_spi_slave_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int mtk_spi_slave_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
@@ -535,18 +532,17 @@ static int mtk_spi_slave_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops mtk_spi_slave_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_spi_slave_suspend, mtk_spi_slave_resume)
-	SET_RUNTIME_PM_OPS(mtk_spi_slave_runtime_suspend,
-			   mtk_spi_slave_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mtk_spi_slave_suspend, mtk_spi_slave_resume)
+	RUNTIME_PM_OPS(mtk_spi_slave_runtime_suspend,
+		       mtk_spi_slave_runtime_resume, NULL)
 };
 
 static struct platform_driver mtk_spi_slave_driver = {
 	.driver = {
 		.name = "mtk-spi-slave",
-		.pm	= &mtk_spi_slave_pm,
+		.pm	= pm_ptr(&mtk_spi_slave_pm),
 		.of_match_table = mtk_spi_slave_of_match,
 	},
 	.probe = mtk_spi_slave_probe,
-- 
2.53.0

