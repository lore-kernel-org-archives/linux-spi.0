Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B340E8E7;
	Mon,  3 Aug 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768082; cv=none; b=RqfgLrfv74YKClzFbuVvtCJ5b4yPZSV5uz9ZqkSUKUrDjbcxFF7QjG/VxPvtcuVwC1enUGQuYt1Cmjc3xMh6W0Mabj1BX+q9lCZbEyCfB4nkY9/gzhS5+Gw8RQu6CcYdYQOSPkFsAm0xjK9nSWb4Ks1T8eeMY4DfQEJ3e9Dy2ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768082; c=relaxed/simple;
	bh=1rRNGmFC+phyVnpsF/RZ2gxLxly4iuZul4MaBmj+rJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4xJYq3xfyK6TUSuQGUqjSScdme2qZwnruuZBEXbf7qhKvscw1DwK9H9R4Jpmk36OnTSq0lFhnJVF3uztPu8izyZkYSa21OTwYHGeA21MzfMX7DglqMoi4Lq9/+ZC8kl53s+iuxW1Z4oq/VlaZnvPek0UaHwhoRHwBDAk95kUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5MXt0h0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5MXt0h0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FF81F000E9;
	Mon,  3 Aug 2026 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768081;
	bh=4kKTt8aTkXsYE6TUcGdMGQEvWc7I+G4sEwM6xHPmeM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O5MXt0h0aTm9O9hWUSNVLaXpD2kB/Xwnc0z7aJfFqku+7qFIqOY0NgqAANgOvHcYy
	 37V8mZaazE1Vmoi6RJJMSprbeo1hBYT/b7SibDTH6HYCc4dLUzAjZsfPw4zH3lcEYO
	 JPtTAJu0CZxeA/bv/dJgMIkB5OJwrSJjEzzMi5KxxDiSB7kRbkvWHpsAHYlIItBob8
	 Q8BJz1I2cRScr58CE+fdIHZ8EgXc/Ta2YT3gQiHsHZ+JJR6f5PGDsmbxs9bOu5Mk53
	 dk8+RBp6k83uiiHOjrUgZbHnvEH9oywZu0BKBr5JikfJgTb4PSxcDw8NfoL42ZpdZM
	 ioqI8V5M+Vi3g==
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
Subject: [PATCH 07/39] spi: bcmbca-hsspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:31 +0800
Message-ID: <20260803142003.12857-8-jszhang@kernel.org>
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
 drivers/spi/spi-bcmbca-hsspi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index 09c1472ae4fa..570ea635ab0c 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -563,7 +563,6 @@ static void bcmbca_hsspi_remove(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bcmbca_hsspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -598,10 +597,9 @@ static int bcmbca_hsspi_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(bcmbca_hsspi_pm_ops, bcmbca_hsspi_suspend,
-			 bcmbca_hsspi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(bcmbca_hsspi_pm_ops, bcmbca_hsspi_suspend,
+				bcmbca_hsspi_resume);
 
 static const struct of_device_id bcmbca_hsspi_of_match[] = {
 	{ .compatible = "brcm,bcmbca-hsspi-v1.1", },
@@ -613,7 +611,7 @@ MODULE_DEVICE_TABLE(of, bcmbca_hsspi_of_match);
 static struct platform_driver bcmbca_hsspi_driver = {
 	.driver = {
 		   .name = "bcmbca-hsspi",
-		   .pm = &bcmbca_hsspi_pm_ops,
+		   .pm = pm_sleep_ptr(&bcmbca_hsspi_pm_ops),
 		   .of_match_table = bcmbca_hsspi_of_match,
 		   },
 	.probe = bcmbca_hsspi_probe,
-- 
2.53.0

