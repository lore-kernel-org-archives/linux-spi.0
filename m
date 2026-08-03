Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797283932F9;
	Mon,  3 Aug 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768409; cv=none; b=WF3aAy3fTqejwiAag+euaSrx+PEoEqKVb2DI7RpbsA4FM7AheOr/k4sCQGzE5bw0kvbSCldsB6gCxkO2UG2plVa0eHX2MfMlB6m6EUuFvrXg9xpk5mCBNPiNGN4xD68b9W2/6JbP0paZt44QS68uj7KnckAw5Jqn5HsjN2xGqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768409; c=relaxed/simple;
	bh=qGulrWSdVKRo+oGA8tzD/K6Jrdx7b00h11uK3yAic60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYdNa9airxugWTRPj8P6vHjDzTOsf7gFeMa7xoHx9DRBWKiRw/jCkUTkgmiY2viKbYi8r+nuqLM8YfM1KHH/gndpVX3/a8N8jbjLvToxWKucfskbGZlGG24uY6qlHttuJY+5iHunLh0n8jYZbD3x2uALD6KvAS37ncLv4MReqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laqBd3N5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laqBd3N5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458711F000E9;
	Mon,  3 Aug 2026 14:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768407;
	bh=n6B911MUpU04sAyipsQMTPqrOspQmhlLZqXEs7dHirA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=laqBd3N5vPetI7kroNFcmZRkGkyjUH01GQfE37Im3g8KMDPVkaci1lbpTw05KwFFb
	 IJBoqxW0I7dsmR9Dp+Z+2C8X2/R08zCMRLoGgatpxJWRRUce735BzGvPQt2DEYCwaA
	 0UrfZYGldzZrjeNRxlrgyXmtz2n9/3jbbyMLY8K0e2SLjPnMhqa3E8BVAjsptEFJIF
	 G8gBqLzaNGQ+yzlspE+mYoQbB9KwxGkr17A9lZJ39xT7/vkHdTnH9CCMr2LGvPOoEz
	 noZanYgGGJlaYvSuLR3wFOH54odVjiDpmwy/PK1S2N1wqzCBFzFkkiwe4AMzhCYJl5
	 i4q3+IF0KjhtQ==
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
Subject: [PATCH 34/39] spi: tegra114: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:58 +0800
Message-ID: <20260803142003.12857-35-jszhang@kernel.org>
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
 drivers/spi/spi-tegra114.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aa44ffd09e61..333fb549214e 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1450,7 +1450,6 @@ static void tegra_spi_remove(struct platform_device *pdev)
 		tegra_spi_runtime_suspend(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tegra_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -1476,7 +1475,6 @@ static int tegra_spi_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif
 
 static int tegra_spi_runtime_suspend(struct device *dev)
 {
@@ -1505,14 +1503,14 @@ static int tegra_spi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops tegra_spi_pm_ops = {
-	SET_RUNTIME_PM_OPS(tegra_spi_runtime_suspend,
-		tegra_spi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_spi_suspend, tegra_spi_resume)
+	RUNTIME_PM_OPS(tegra_spi_runtime_suspend,
+		       tegra_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(tegra_spi_suspend, tegra_spi_resume)
 };
 static struct platform_driver tegra_spi_driver = {
 	.driver = {
 		.name		= "spi-tegra114",
-		.pm		= &tegra_spi_pm_ops,
+		.pm		= pm_ptr(&tegra_spi_pm_ops),
 		.of_match_table	= tegra_spi_of_match,
 	},
 	.probe =	tegra_spi_probe,
-- 
2.53.0

