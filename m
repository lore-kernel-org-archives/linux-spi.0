Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5A0411F84;
	Mon,  3 Aug 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768096; cv=none; b=u8StgB3oewSWtcd8WGireHvK/xPeHrnnN5084Zw5T9JZkqbKDt14ESu5UuQ3qrUBOom40nIhf90Qx/DBxv+Bq2yqa5oxVTCbDUVA7UJh5RYXp8MXt+jAZQp6mB1ahr3oNfypMMDi75N6j4PblT1ERtfEECj2BBM/LRQaJ6DP040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768096; c=relaxed/simple;
	bh=0asNrLcvhZ2XBzhqXhAK7XMkZnVd3O4Yq9Ox+DK4dJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6d/w3YfZ5AcvmdmbUNW7OvaYs9WK19LB6lCkE7At7wksXhiZ/BK1DQQFuAusC8yV4IesKMvzWg/4QiHfcfDJWxzxV3hgDHTgE/cTuyCZ50ELi+0Dk/upuZon7iIRVQ4sJWzHXaLL9JJyYz5HEu0hNhzZEIGDZ3BkIFKu4s8ic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxGP9gUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxGP9gUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F225C1F00A3A;
	Mon,  3 Aug 2026 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768095;
	bh=MAIwjk+5CNQswN5q5GYfXKSlxvy7dSo8503a5y5nOgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LxGP9gUCUKBBON8LKPIYo/vxWduOwjs+b5rA+/uNqUB6Wq0dcPLjCHQ5QeSMfl4hr
	 68ukS9W90IlOepPoZhm5XZNnALM+NRAW6kSSEQlG0am5i664MhLPIjN6G8+08SmZ3t
	 jsr26bCANf2oyIdJJZ3FoRK9m/4l9wjIb0xl6vRhJ9FDLeUlGrU484NxxGMKzJZAUn
	 1pOW8gZXs8naD9B+kYcYglB1WjA/lwqD6UJBuYj8OH38fCD42oEy+84eSj7UzCdgFo
	 xI9aGFIiLl71fCDVxIQJq5IUUZLeNQ0LIY+1qyMkwOg7JBn++8SCVJvdswx5GTpLK5
	 S+TyYHyP0yJlA==
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
Subject: [PATCH 08/39] spi: cadence: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:32 +0800
Message-ID: <20260803142003.12857-9-jszhang@kernel.org>
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
 drivers/spi/spi-cadence.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 9b4e5b7013ae..a5e1e5a46bb4 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -801,7 +801,7 @@ static void cdns_spi_remove(struct platform_device *pdev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused cdns_spi_suspend(struct device *dev)
+static int cdns_spi_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
@@ -816,7 +816,7 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused cdns_spi_resume(struct device *dev)
+static int cdns_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
@@ -833,7 +833,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused cdns_spi_runtime_resume(struct device *dev)
+static int cdns_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
@@ -862,7 +862,7 @@ static int __maybe_unused cdns_spi_runtime_resume(struct device *dev)
  *
  * Return:	Always 0
  */
-static int __maybe_unused cdns_spi_runtime_suspend(struct device *dev)
+static int cdns_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
@@ -874,9 +874,8 @@ static int __maybe_unused cdns_spi_runtime_suspend(struct device *dev)
 }
 
 static const struct dev_pm_ops cdns_spi_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(cdns_spi_runtime_suspend,
-			   cdns_spi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(cdns_spi_suspend, cdns_spi_resume)
+	RUNTIME_PM_OPS(cdns_spi_runtime_suspend, cdns_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cdns_spi_suspend, cdns_spi_resume)
 };
 
 static const struct of_device_id cdns_spi_of_match[] = {
@@ -894,7 +893,7 @@ static struct platform_driver cdns_spi_driver = {
 	.driver = {
 		.name = CDNS_SPI_NAME,
 		.of_match_table = cdns_spi_of_match,
-		.pm = &cdns_spi_dev_pm_ops,
+		.pm = pm_ptr(&cdns_spi_dev_pm_ops),
 	},
 };
 
-- 
2.53.0

