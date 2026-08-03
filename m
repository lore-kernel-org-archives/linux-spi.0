Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAE34F497;
	Mon,  3 Aug 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768156; cv=none; b=FZ/LovpCKk8thPYEA7oQsnBiGY7cf77XMAHacuf9DaLK9g7ogsguoDzX8UdwWxH/AvYNF9CMdagxOJQg8/Qb0EZQy4nT6LazDStu8gmZRV+e8bDKZV1l1pXeo3aJq/PF7Ky8jGd7+19q55HZJ016ORpnk2iI4I4kS0atvf6o7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768156; c=relaxed/simple;
	bh=wi4rSLjF8igkEk5Hb4y1uIgJc2aGWF9+Vfs+f881cKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/fk1KlHGrrenbICZNfDhADZ0seSTNzMXWsENwqS6EeUT6ZPMl36xiATx0KQfhDNSurVYejSI9R+V6VVJwlgmuKddtpowwmP923UPWtGkwytAQsW6nAnoLp1GTWswn0JHCoWRu/ncHx5DvdVswIpAmFAy0ySQkTf1+IvEfhDA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Z23oOB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Z23oOB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405881F000E9;
	Mon,  3 Aug 2026 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768155;
	bh=vMpPIe2+3JKmGQVDSBH5+n4a6i7E8FOu08o9TWP+o54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2Z23oOBdOFyR2gO3/YnPcslmtdAI05sg4yCtD4fHqI1rtigB793GgBQI6bWSdjlL
	 RHRYsz6Zyje283JV3wn+4ZW0bHprbFh9RX8+qCD2DAij77FiuL6dGVPTabSaPqBZfv
	 gsWiXj2cwKL7BXwyJWDsQ9CJf3e7Ok8Fzpa7bbXYsDrga4iG0HjR/cW5+weX4LUlLa
	 0vfArkZmv/crDwI2wgyaAon6P9MQJkmi9CzuksvT2UkbKS8AXoFhHkc/G4A1q6R4vq
	 ZF+ezXXqPcCoUKjz6idfBCFMVgLrpoI7xHUeTMol4gjHFGiD7paQTTwkx6gVSdvB3/
	 RU9mXrCuDsnaA==
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
Subject: [PATCH 13/39] spi: fsl-espi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:37 +0800
Message-ID: <20260803142003.12857-14-jszhang@kernel.org>
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
 drivers/spi/spi-fsl-espi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1341bdd7db75..4ac8f9b06783 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -580,7 +580,6 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_PM
 static int fsl_espi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -606,7 +605,6 @@ static int fsl_espi_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static size_t fsl_espi_max_message_size(struct spi_device *spi)
 {
@@ -785,7 +783,6 @@ static void of_fsl_espi_remove(struct platform_device *dev)
 	pm_runtime_disable(&dev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int of_fsl_espi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -811,12 +808,10 @@ static int of_fsl_espi_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops espi_pm = {
-	SET_RUNTIME_PM_OPS(fsl_espi_runtime_suspend,
-			   fsl_espi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(of_fsl_espi_suspend, of_fsl_espi_resume)
+	RUNTIME_PM_OPS(fsl_espi_runtime_suspend, fsl_espi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(of_fsl_espi_suspend, of_fsl_espi_resume)
 };
 
 static const struct of_device_id of_fsl_espi_match[] = {
@@ -829,7 +824,7 @@ static struct platform_driver fsl_espi_driver = {
 	.driver = {
 		.name = "fsl_espi",
 		.of_match_table = of_fsl_espi_match,
-		.pm = &espi_pm,
+		.pm = pm_ptr(&espi_pm),
 	},
 	.probe		= of_fsl_espi_probe,
 	.remove		= of_fsl_espi_remove,
-- 
2.53.0

