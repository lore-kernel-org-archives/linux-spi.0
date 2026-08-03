Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422040DB47;
	Mon,  3 Aug 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768133; cv=none; b=S063ieMOCjkuMe0iIPH1DIl04LidIrFnOZiiCnQMS2wcZuoYShPms1JBzbnsN16oz8ZNS+wzcTcmm7R7t3P+s26+Omi8OCiuplaVyj8xb98/fIdaG5Un1hNgvsIsjh03icl1rRQ/IAm6jsTLjYvBLp9LBGtMAjxqz7C0RNcbkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768133; c=relaxed/simple;
	bh=zENYT5DzrS8BJScxKJ1eXzPGAS9tDYUtGL7IBMZyKm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDcu9sN2B/S5tLWzKBqLZAk2bV4M6+HDt805McEcUzJWhrViMIYsFdG282DQQRa9wYfg0vp9c+i8RKsYKfa/dhzrq3DpBpqQC6E7c3AD2Gaim2+F4oQBaL80inKnR9nnn0KWKla7DmU59GlC98LDtba2I1cY/s66wMD62jAopc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6GckL2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6GckL2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8551F000E9;
	Mon,  3 Aug 2026 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768132;
	bh=7RCVfL8Urn36uGNhjYgoVgTOFCNUrI39Z/L69BlIOVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F6GckL2+gQYCe0GKb7Ch2/FYD4wS9CU3Do7nHwqd3tmmwiWemXCzBqisEZxZrHjdZ
	 r97U0OpcklaJLYnOTrsdub+Upgi+GHz09naK0ynF5LZo31jGQHgrPFQ70rKoKFJkgW
	 EaAUh3bOFDkMEadvMAPXo85zR7n7UFXLfPDOwRtLxJ5BBF/LmJhON9OZxE19FuyaKf
	 ZPaa9im75e0OipwvgxPLNQkrZBnPQUM+q0Sq/Y5J5OlR5EnbEZtkMmVyD9rAoDBstf
	 tNgb0hQTdfQyf6SLoCV2icyONX6cu43wGDSvLr4gzZ+uhI5/K+eRDq0DZuqyYaDqlt
	 KY2pCsM1m0gUA==
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
Subject: [PATCH 11/39] spi: dw-pci: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:35 +0800
Message-ID: <20260803142003.12857-12-jszhang@kernel.org>
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
 drivers/spi/spi-dw-pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index bfb874f96a26..2f3bea51f1e6 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -154,7 +154,6 @@ static void dw_spi_pci_remove(struct pci_dev *pdev)
 	dw_spi_remove_controller(dws);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dw_spi_pci_suspend(struct device *dev)
 {
 	struct dw_spi *dws = dev_get_drvdata(dev);
@@ -168,9 +167,8 @@ static int dw_spi_pci_resume(struct device *dev)
 
 	return dw_spi_resume_controller(dws);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(dw_spi_pci_pm_ops, dw_spi_pci_suspend, dw_spi_pci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(dw_spi_pci_pm_ops, dw_spi_pci_suspend, dw_spi_pci_resume);
 
 static const struct pci_device_id dw_spi_pci_ids[] = {
 	/* Intel MID platform SPI controller 0 */
@@ -197,7 +195,7 @@ static struct pci_driver dw_spi_pci_driver = {
 	.probe =	dw_spi_pci_probe,
 	.remove =	dw_spi_pci_remove,
 	.driver         = {
-		.pm     = &dw_spi_pci_pm_ops,
+		.pm     = pm_sleep_ptr(&dw_spi_pci_pm_ops),
 	},
 };
 module_pci_driver(dw_spi_pci_driver);
-- 
2.53.0

