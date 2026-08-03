Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3033B966;
	Mon,  3 Aug 2026 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768225; cv=none; b=nFEHNOQRmUdnyBuy64FeghpGYK6FsuCjPfeM61c2SSJswBdb3XOo6vww8uSq6yxrG2vQtfCIYGflyf/Q6WhBVuIPNT3fOgWX2Vf8frPXKL+UxNGv5WJnRnGLs/Gf2hkgqA/JYKpJ7GeQ2GK4jpqieFaSNrqjdx8inZONpNltGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768225; c=relaxed/simple;
	bh=eEw8Qk2hOhPUcBITw/f2Wb4FvaPaelHXMrBfA+OllwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkP6R5dYLC88QbRmnk9t1Lz9ZUcoKxMAvQQy8fnS89WQhXL0lWc4GnnteHLfD88B06FihsoAVpCTj21XulYbguzOt+T2FHzRUwoQiE5tCcNZesKvCiY2JqBr1qTFRjMPea2LK+ctIa0SMzSymcMp2kiLKflSF0yUYW+/mlGdaK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA9a0iDQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA9a0iDQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7381F00A3D;
	Mon,  3 Aug 2026 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768223;
	bh=Aq5eKq2jQllo0UFgmqt8MgpdseF2d22YCYfpSye94Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MA9a0iDQTpjsMzVcuXmY7ReHpQMBNOgCbYtLmvRch+jN2aRExK8yKwHhx4J09UmF8
	 lfBwmvY3/zRg9y5Y3O6NiLnvTUkD4FB8hA7NKlqQqN0vuq3L14ykeLyuW2axpeeQLK
	 9T0U25UL4pRak4mSI1Rh4ej111CHTcQC/cRdk648UUcwkWlV8KP/1ZSMtu5304+tlF
	 cI154XM0qwPXkFa5tub+H9lcppaNWrQrrqT9ffP1zRuP89Lq1GmvJk+fdUXLHxyykl
	 p6qSGA18xKWAOYae9WySvYE8Pdu5epIYHPxpTHLf45HeFsQYRFJdgdAGxI6BUJkFGc
	 wta0SSjtlNQrw==
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
Subject: [PATCH 19/39] spi: mt65xx: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:43 +0800
Message-ID: <20260803142003.12857-20-jszhang@kernel.org>
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
 drivers/spi/spi-mt65xx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 96f8555be983..b845a599f7c6 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1367,7 +1367,6 @@ static void mtk_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mtk_spi_suspend(struct device *dev)
 {
 	int ret;
@@ -1419,9 +1418,7 @@ static int mtk_spi_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int mtk_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -1473,18 +1470,16 @@ static int mtk_spi_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops mtk_spi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_spi_suspend, mtk_spi_resume)
-	SET_RUNTIME_PM_OPS(mtk_spi_runtime_suspend,
-			   mtk_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mtk_spi_suspend, mtk_spi_resume)
+	RUNTIME_PM_OPS(mtk_spi_runtime_suspend, mtk_spi_runtime_resume, NULL)
 };
 
 static struct platform_driver mtk_spi_driver = {
 	.driver = {
 		.name = "mtk-spi",
-		.pm	= &mtk_spi_pm,
+		.pm	= pm_ptr(&mtk_spi_pm),
 		.of_match_table = mtk_spi_of_match,
 	},
 	.probe = mtk_spi_probe,
-- 
2.53.0

