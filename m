Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928454137B5;
	Mon,  3 Aug 2026 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768323; cv=none; b=IVIcxVl6zW9AkBKUsQGlKU1nbM9+lRETcCptG5RCbSYs5yxg0NmfKrWx4Gk/gDTbFF7fNN0Mb6+5SN4j+vhC4I2NthdoWjGfaYkuuBopJlsaeJUNsp18mF/vu8mAMfOU0IuNnDbjlJYKL53M96OCPxNoTyATwdyaT0bfLcj552o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768323; c=relaxed/simple;
	bh=slhoggWz7pPyKpRVUPl9vdCdwgaHZrzrbhKPzBX0JC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDxj+wHgY5Keuqo3ty/VkylsycOLLfanfNPqAppn9k2COxlsNpzLyxPgOZ+cxnZ0gU4bes9lmxRsClvim/9jN+BgxVXmLAusbavpDcFrLBEk7h4lbZosr1cnc1czWXRAN98StoOMmE52upyCkz++07syDBOtnaO4E5iDwTMBmDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsSS3w5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsSS3w5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AB61F00A3A;
	Mon,  3 Aug 2026 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768322;
	bh=47vBJGCs0olAvDipuGWQVcPv02dyV3Whb//pV4b0Fqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsSS3w5w5a4BoSq36WGN63111iNPtpaXdr2ZEwSspSSUPEo4IxPVVfhGWdup0Qb/9
	 gYTaY/GnVz+BT7ACvEVZpGWHvXczFzAy/Aay1RAu/z/7ksyniIv+sMC/W1cPb6uFV2
	 b4pEFIqkNOm7GheHPvbRDB27tWSKVn9PLBdFs+NAAtU/xMEcCJ7fHeK7JmmG13U/uQ
	 cYiOzFofIL5UcVG1uuVdpj2+kqS2PXJxNNj1zLpjwVw/FjlGO5y39JZhTMhMlsBsMG
	 6L9elxFWbD7CqVb0TpzP55BORlh7j/5Ng5IOZJaDh22cLtVpeuRmJhvrg8fErm1Te4
	 +Gj720Dv1vkRA==
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
Subject: [PATCH 27/39] spi: rockchip-sfc: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:51 +0800
Message-ID: <20260803142003.12857-28-jszhang@kernel.org>
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
 drivers/spi/spi-rockchip-sfc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 174995042f53..662a994da60b 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -751,7 +751,6 @@ static void rockchip_sfc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sfc->hclk);
 }
 
-#ifdef CONFIG_PM
 static int rockchip_sfc_runtime_suspend(struct device *dev)
 {
 	struct rockchip_sfc *sfc = dev_get_drvdata(dev);
@@ -777,9 +776,7 @@ static int rockchip_sfc_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM_SLEEP
 static int rockchip_sfc_suspend(struct device *dev)
 {
 	pinctrl_pm_select_sleep_state(dev);
@@ -810,12 +807,11 @@ static int rockchip_sfc_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops rockchip_sfc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rockchip_sfc_runtime_suspend,
-			   rockchip_sfc_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(rockchip_sfc_suspend, rockchip_sfc_resume)
+	RUNTIME_PM_OPS(rockchip_sfc_runtime_suspend,
+		       rockchip_sfc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(rockchip_sfc_suspend, rockchip_sfc_resume)
 };
 
 static const struct of_device_id rockchip_sfc_dt_ids[] = {
@@ -828,7 +824,7 @@ static struct platform_driver rockchip_sfc_driver = {
 	.driver = {
 		.name	= "rockchip-sfc",
 		.of_match_table = rockchip_sfc_dt_ids,
-		.pm = &rockchip_sfc_pm_ops,
+		.pm = pm_ptr(&rockchip_sfc_pm_ops),
 	},
 	.probe	= rockchip_sfc_probe,
 	.remove = rockchip_sfc_remove,
-- 
2.53.0

