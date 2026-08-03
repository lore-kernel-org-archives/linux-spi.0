Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C5140DB4F;
	Mon,  3 Aug 2026 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768349; cv=none; b=ip4LpqUKp6y2mGOxp8yGXyfdMaccaGTsS+BeDar+W6M9OkjTwTWmOju9vQYIrrl/7SbLM/mq+eJYzb1xpSNYF2wogaSNAhDN+y9LknoebE3oSNmfQoMwx8iT70H+bRWQu5oVvWhjQjhHzj4uo19WBIc4pooKAhAjpE55i62GCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768349; c=relaxed/simple;
	bh=Wgq2k+xnDokBIprime2OdaG6qnvbXx7pqeczUYGbaJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgtX89XMrmUauoQWWLCUYztIHrpLrhW+tmlHbZ3N6iIzr+YCTdT5z9CCwhdt8P5l1RfGDWtymNbHXwfgBZS7WiiUPLYUst4bpPjyNCw2oAQhXPPvDX032R7nu8NZnA+kX/fBuBOFFBUkdroxRzBNyjRie4S34r7cVXZ/GMbFR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cysBrl1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cysBrl1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3521F00A3D;
	Mon,  3 Aug 2026 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768347;
	bh=Lc2pQMao89s0oVQzCTrkPCY3b0sT34bFVhO0CBFvD+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cysBrl1cvUsDKmbTB3tO4bwPCRtlArlZ+DvH2LIKKuzfMhtmhe0ricSh2xyCeIv7m
	 xPzBBzNDUB9rXfD7vxEIaozlMRibwWp2nYzUTgOABEG6IJp9CHlvyBP+1CtC9ezxCx
	 psGPt5eUPdqWwGU155Yi/ZPawDuEBCY+A77kz4+Str6pHTPy3KBrTQ0FsGo4c2Eu2v
	 Gn1K/Jli1vvUbmj0xgUNuHT4uT5odohNRhMWPN7r9qYaHLa7P18SoLLj4AKCLm18iA
	 evpsZhpHQDD1o37xn8clMs15GZSGizg/vr2wklwECTKidhPlu3YSCtTg9ZQ1ibXfYA
	 6ULk8f96sBXig==
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
Subject: [PATCH 29/39] spi: s3c64xx: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:53 +0800
Message-ID: <20260803142003.12857-30-jszhang@kernel.org>
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
 drivers/spi/spi-s3c64xx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 28c56b06fa99..8d4120cf9df1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1408,7 +1408,6 @@ static void s3c64xx_spi_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int s3c64xx_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -1444,9 +1443,7 @@ static int s3c64xx_spi_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int s3c64xx_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -1494,12 +1491,11 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops s3c64xx_spi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(s3c64xx_spi_suspend, s3c64xx_spi_resume)
-	SET_RUNTIME_PM_OPS(s3c64xx_spi_runtime_suspend,
-			   s3c64xx_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(s3c64xx_spi_suspend, s3c64xx_spi_resume)
+	RUNTIME_PM_OPS(s3c64xx_spi_runtime_suspend,
+		       s3c64xx_spi_runtime_resume, NULL)
 };
 
 static const struct s3c64xx_spi_port_config s3c6410_spi_port_config = {
@@ -1655,7 +1651,7 @@ MODULE_DEVICE_TABLE(of, s3c64xx_spi_dt_match);
 static struct platform_driver s3c64xx_spi_driver = {
 	.driver = {
 		.name	= "s3c64xx-spi",
-		.pm = &s3c64xx_spi_pm,
+		.pm = pm_ptr(&s3c64xx_spi_pm),
 		.of_match_table = of_match_ptr(s3c64xx_spi_dt_match),
 	},
 	.probe = s3c64xx_spi_probe,
-- 
2.53.0

