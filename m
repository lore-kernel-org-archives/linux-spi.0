Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C51314A8E;
	Mon,  3 Aug 2026 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768237; cv=none; b=dym1pzQx3tHUyriTye70RgsjokZwVR3vhJyea/ZGVdvyOrxDOprkdcjPaSar8dZ4+67J9G1RlngPeBOS6frksnMSM4YJlSaUijW/ktPwSfK9P+ZCGm8MV/c0/FdcVbvg8Gi27rnqu2mqZbA552fjDUwerb9Ltdf7HuWLBDe5a7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768237; c=relaxed/simple;
	bh=6x1chWzRmz3GtKAZMXqA3VpMzOHiVAzj3Ew/WfpXWMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Es1n+mHVXFKM5y0xkgmB/CONsSVQadueystK1JSdswEVd6prty/QrjhWAxIY2ZpJt2ziA0UoSOk3ks5ak3jqu8AW2ZLZmANqDA0bX1GUeA1O2E9RvANlRLxcKhN2DAXbrR0w69IM6NwgM2aLJaNx53AbP/1Xg4mBfMUFhV8NGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6/Hu9Se; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6/Hu9Se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C0B1F000E9;
	Mon,  3 Aug 2026 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768236;
	bh=hZrAkotQa6HumBZo0ApaJSkT743EScJ3Bb7qgki/piI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6/Hu9SewVq06BlnIrTLSNmsjzLZk6VF7rXadROXYNpr89qk5YBPDf0S/a9L3xnUJ
	 awTLWdx+cE+TRMObOg/4kf+zLC2RaT4J+eb7eFNbctR1MwX8/o+5Y2rmurmZT7F1CZ
	 7N6bF/vZ4AMu/unLS/LFLVJINW4AefPRjnrxF4FAYrF/Mnq4jhqdLrqXB6dJjw6SJJ
	 yN0xINHYUghpn21gz4QmvDCnNS5UJxMRF0AyahuOGVx9iUvSj9QfrMX/dWkTMScDvu
	 5s8dH2cfNq3ch8kcIn/r6wXiImO4V4ZDuJlQE1ZwxGQrmiEvFHGM/m9xDpqW1YKKd4
	 WFXozR35JcGFA==
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
Subject: [PATCH 20/39] spi: mtk-nor: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:44 +0800
Message-ID: <20260803142003.12857-21-jszhang@kernel.org>
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
 drivers/spi/spi-mtk-nor.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 74f34537b02c..5e1fdbb40ffb 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -947,7 +947,7 @@ static void mtk_nor_remove(struct platform_device *pdev)
 	mtk_nor_disable_clk(sp);
 }
 
-static int __maybe_unused mtk_nor_runtime_suspend(struct device *dev)
+static int mtk_nor_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
@@ -957,7 +957,7 @@ static int __maybe_unused mtk_nor_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mtk_nor_runtime_resume(struct device *dev)
+static int mtk_nor_runtime_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
@@ -965,12 +965,12 @@ static int __maybe_unused mtk_nor_runtime_resume(struct device *dev)
 	return mtk_nor_enable_clk(sp);
 }
 
-static int __maybe_unused mtk_nor_suspend(struct device *dev)
+static int mtk_nor_suspend(struct device *dev)
 {
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused mtk_nor_resume(struct device *dev)
+static int mtk_nor_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
@@ -986,16 +986,15 @@ static int __maybe_unused mtk_nor_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mtk_nor_pm_ops = {
-	SET_RUNTIME_PM_OPS(mtk_nor_runtime_suspend,
-			   mtk_nor_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_nor_suspend, mtk_nor_resume)
+	RUNTIME_PM_OPS(mtk_nor_runtime_suspend, mtk_nor_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mtk_nor_suspend, mtk_nor_resume)
 };
 
 static struct platform_driver mtk_nor_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = mtk_nor_match,
-		.pm = &mtk_nor_pm_ops,
+		.pm = pm_ptr(&mtk_nor_pm_ops),
 	},
 	.probe = mtk_nor_probe,
 	.remove = mtk_nor_remove,
-- 
2.53.0

