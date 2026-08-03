Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7238837D;
	Mon,  3 Aug 2026 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768189; cv=none; b=VhRITwlvebrdOMil1CGx6gaOu9dmHxm3RIFEu8VJKDY5CPINlSYPbB2LWPbbc7iSQLuXmIFy8j5BcNNoYzKfS/5APTSd02XyGVgetBQv9LrV/Qp8C3liPxCWlzanZIYOwOiEfLSRBUr28xSUoDZ4KetkSF7DyZ7ENOoz4KWhI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768189; c=relaxed/simple;
	bh=OdCi3x60R6oZKpMlzyxLYNTTaKUiDXUPphpFYWqThWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/EY7m3nrS9pDnNnmPL8lDMhWZlcGgBotIulKG/6StNzfDPLY1Q0lkznI2vCZQSwOchdfnwQ/MLhClw+Htx9kmIWAjlcaHCaUGpmbbNmdyVI5tzFuVyP+ILerO9nUeHOx9s3T0LpobfykZAUfmc5g+Eoq57G41KYwZ3tqVvVIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUAkb6ts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUAkb6ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965C21F00A3A;
	Mon,  3 Aug 2026 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768188;
	bh=daGpi8WW17Z4aS26DoYco+2G9yFG/WRrelS5U9+0Kfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hUAkb6ts/hWwVE48dyESArnWGp5vpZQVxEQm6uGv32P9H3PorTaqd+GXSDJKXBoob
	 dHraq16tB3if1Lmc16qL1Uo/oZ/cWQOxbDMGY7j5/bUVSbox6eEB+nkwuBHtleYtYV
	 qAdA7OVX0h1pGYNJInajj6nqXKsGMA39XqN+EbG/IxVF8QI2atbT85WVuYqfDiNevO
	 yJkUcNO5ZBPCPZAKsXs2RxcAONlfzBuOCnAhHJY73ELsqpC/AGwmo3tTz+El4yanG9
	 hXe07rBs4ko2D6W7/Sd5aEeDpGYLxTWeqkSfAodKRMwy4HV3lUyJn5ZMA7P8CsfnQX
	 cGwiW+/RRNgmg==
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
Subject: [PATCH 16/39] spi: img-spfi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:40 +0800
Message-ID: <20260803142003.12857-17-jszhang@kernel.org>
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
 drivers/spi/spi-img-spfi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index aec724e3f824..19c8250ddb64 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -677,7 +677,6 @@ static void img_spfi_remove(struct platform_device *pdev)
 	}
 }
 
-#ifdef CONFIG_PM
 static int img_spfi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -706,9 +705,7 @@ static int img_spfi_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM_SLEEP
 static int img_spfi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -730,12 +727,10 @@ static int img_spfi_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops img_spfi_pm_ops = {
-	SET_RUNTIME_PM_OPS(img_spfi_runtime_suspend, img_spfi_runtime_resume,
-			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(img_spfi_suspend, img_spfi_resume)
+	RUNTIME_PM_OPS(img_spfi_runtime_suspend, img_spfi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(img_spfi_suspend, img_spfi_resume)
 };
 
 static const struct of_device_id img_spfi_of_match[] = {
@@ -747,7 +742,7 @@ MODULE_DEVICE_TABLE(of, img_spfi_of_match);
 static struct platform_driver img_spfi_driver = {
 	.driver = {
 		.name = "img-spfi",
-		.pm = &img_spfi_pm_ops,
+		.pm = pm_ptr(&img_spfi_pm_ops),
 		.of_match_table = of_match_ptr(img_spfi_of_match),
 	},
 	.probe = img_spfi_probe,
-- 
2.53.0

