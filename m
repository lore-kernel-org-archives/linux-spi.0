Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BB41D227;
	Mon,  3 Aug 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768277; cv=none; b=bJzhadPLTkFoYIynpnHGrXB665oXFkprAVmJm2JakhOKphXeSStOy+5Zm9C4iQNtYtOJtnNzbhU6X5kXx1/Jp4Tm8k7LF4e6lCGo6yINV8iCbkscpjhe59ouRJDDF+4WQDwLFTpNPw3zgzr5EOmlpNtjgliuB3OC4t4WysmW2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768277; c=relaxed/simple;
	bh=QAH8O2n0XZVtqOMENH1xpHdVuTvSWcyBNs1sKcOfQTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h66wzbEEzKbJi4o5lx8VZe+dItTOn7iFi4d2JW0m7DWed+8sB6IIwuge7+8v+Czf7vTk/Bst+5WHygILLr043E90sXBoNe+6oULEMBJrZZu9v0Tc9GbUMsfbDKyeiLeSl+2GWjOyvDVXX6OV7e/lNlQXHu2aFc+heBG0MNrTvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W320FhgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W320FhgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3F71F00A3A;
	Mon,  3 Aug 2026 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768276;
	bh=CjaGFOxr4nU+4hu6sOP96XKGU6m8y4A1jNpucRrIXvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W320FhgIR3sDSIMSzQ3s9AsS5ld544sgO/L7h/zDkkknjjHreEIS8ILx9il4qjnpt
	 kohdQxBo+hh/717VKan7AATNkuuWWyqpCspgG8N6qhQykYWOmeYXg5Uki21SpoH/cC
	 2bxamaaaUR9hznOsPbD877Oidydz3yxJfs4ePS4wZzr64aP4GYItQz6h7Z2+PtPGMu
	 fLLSwd5tFOwdsi10UykS5uvFNhaxNs8D7sFwbD88u8a/t59LG2QzArMAD953w/dtks
	 q2mZVACHLMjrnT9vYFyYyKiw8mwPdKTArkXnZbDhJ3Oe8fHy/SJsAwE40NdxESbUXX
	 qmwsBGLjaC0Tw==
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
Subject: [PATCH 23/39] spi: orion: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:47 +0800
Message-ID: <20260803142003.12857-24-jszhang@kernel.org>
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
 drivers/spi/spi-orion.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 265708a94984..a33b5840b95f 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -100,10 +100,8 @@ struct orion_spi {
 	struct orion_child_options	child[ORION_NUM_CHIPSELECTS];
 };
 
-#ifdef CONFIG_PM
 static int orion_spi_runtime_suspend(struct device *dev);
 static int orion_spi_runtime_resume(struct device *dev);
-#endif
 
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
 {
@@ -814,7 +812,6 @@ static void orion_spi_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
 
-#ifdef CONFIG_PM
 static int orion_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -834,18 +831,17 @@ static int orion_spi_runtime_resume(struct device *dev)
 		clk_prepare_enable(spi->axi_clk);
 	return clk_prepare_enable(spi->clk);
 }
-#endif
 
 static const struct dev_pm_ops orion_spi_pm_ops = {
-	SET_RUNTIME_PM_OPS(orion_spi_runtime_suspend,
-			   orion_spi_runtime_resume,
-			   NULL)
+	RUNTIME_PM_OPS(orion_spi_runtime_suspend,
+		       orion_spi_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
-		.pm	= &orion_spi_pm_ops,
+		.pm	= pm_ptr(&orion_spi_pm_ops),
 		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
 	.probe		= orion_spi_probe,
-- 
2.53.0

