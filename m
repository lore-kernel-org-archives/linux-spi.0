Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BCF40F75D;
	Mon,  3 Aug 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768071; cv=none; b=c2faOakhpNTpB+NrL1XlpWYWmQqCy68HhQKmaGxeB4ZLRM1WZyRmXbDbVaeXLohBAPFm68xZiukcux3JNnjGn2T0RG6yRmirHit7L7t9nvhgGvZ8uRtrxZAOZHKFbfrD1TPpoH+43de4EotyGsSSzf4DyfQZrmyapj1GytvCRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768071; c=relaxed/simple;
	bh=8XMGcf4hqA37XtV1JFhfvIHAKpWdPrJl0mhUxOEJTgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIJvQkgIeU0tbrg3jfwtfNxZ8UREZXMCe8HxzbxOs+G3bIUbkV66mgAUwD+Mjv5VW6O8G03ZgxoqBagychm4DC5qC5PH/OIi41ldM1YaSpCI00i1DvZd5qVKy+S6IFuzY1VmE7bcrWqbGYqjz2YK8lDue+AD2CIT1YRx5pKL1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeljzgWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeljzgWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F15E1F00A3A;
	Mon,  3 Aug 2026 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768070;
	bh=oIrju3YJXP0D6mBAvc98/Vs2ufAIvXkeUIskpU98D7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VeljzgWeF9lfqns1Cu7UtJkRkwXLD1EGFMt6lP31jhUrOkrCcedmVkouA+akmotpV
	 qMmQ60EqBvEmJ1dTRCV5Nc5CM+2llVFiDEPzekqfd4AWE2rIbjQJOjTZ4F0X4UEFJr
	 sDQbPLdB2QV1vwBYTM+wkiEs13COu3H3A7BxB6CGDG0kg2G+modaIj5AJWhrA7tI/I
	 0Vh81ZXkbfXPQQmsp9A5hRdU2KQDthn8BUqgpW1y4i/kDyYt9wF4kdo+2op7yGDTNj
	 b116t4qlEKEAJkEq+nbna3Y/nfeBhnYUKMgg70OBFFhOZjnl0wFVDPp7ra6V2V1in5
	 Cxvbc3HeP6CSQ==
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
Subject: [PATCH 06/39] spi: bcm63xx-hsspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:30 +0800
Message-ID: <20260803142003.12857-7-jszhang@kernel.org>
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
 drivers/spi/spi-bcm63xx-hsspi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 58012e1b5ae7..ca6cf7c19835 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -884,7 +884,6 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bcm63xx_hsspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -919,10 +918,9 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(bcm63xx_hsspi_pm_ops, bcm63xx_hsspi_suspend,
-			 bcm63xx_hsspi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(bcm63xx_hsspi_pm_ops, bcm63xx_hsspi_suspend,
+				bcm63xx_hsspi_resume);
 
 static const struct of_device_id bcm63xx_hsspi_of_match[] = {
 	{ .compatible = "brcm,bcm6328-hsspi", },
@@ -934,7 +932,7 @@ MODULE_DEVICE_TABLE(of, bcm63xx_hsspi_of_match);
 static struct platform_driver bcm63xx_hsspi_driver = {
 	.driver = {
 		.name	= "bcm63xx-hsspi",
-		.pm	= &bcm63xx_hsspi_pm_ops,
+		.pm	= pm_sleep_ptr(&bcm63xx_hsspi_pm_ops),
 		.of_match_table = bcm63xx_hsspi_of_match,
 	},
 	.probe		= bcm63xx_hsspi_probe,
-- 
2.53.0

