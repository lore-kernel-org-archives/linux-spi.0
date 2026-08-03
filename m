Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B7400DFF;
	Mon,  3 Aug 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768044; cv=none; b=PKc/3oVzM3r/nmusm3d9EEuKQCMdqxS1Q+Y044Pp0M8MirwFNmjAJNDCGIfgv1kzU93JRrGTRhFgyYq4cCOg8BASytF0g1SYhoYwSVqiufOVC+AT8kzyUt1v2b0A2gFSlIuut14dgG8edb+m4UkcuyWVNuotNcWT9NCRdO7B+ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768044; c=relaxed/simple;
	bh=8zI5Hz2QVh5YdJw9ebJiuqgTOOtUw6epfK6KtmVJ7CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuNAPuVZ5Eloc+dWzg7k6so//yBCd8Bf0VEsivICvqkNwhtLI2FLmNyemUENHDTjmBjQ1QBsrjKny1raYfiFkfD3B/E6dmrwS/Q66YckYqmXY5ka+jP8gtWq2zeupHQsqcV1dP7VtPC7HyhNz6t03sVSxuzjMT3zyhmiscMlQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt9F+Y9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt9F+Y9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E408D1F00A3A;
	Mon,  3 Aug 2026 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768042;
	bh=TSi20WCkH5JDBxJK1bjShT5TFErSjKY4MvQZmEwMtjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yt9F+Y9j9QSvoF+22q6z7h/6RyseB4zldF+TpwkoJpPHtcuwhPSkXbjgswk83llti
	 lQb2+aqRd6C6knyyMOZW0woAgi9gaAIe/91X7GD0pIiFQ5yuaMjwLmTbt6M/urTHAg
	 HM7m1LfbSeUY//dTvEGNijlyMLIlCj2FHs5WN9UrmecBkdUkxD8vTCrmDLN+F9D2lH
	 X3V/sWXeGHi2F/dX7UwcELvC6oGtecQfApXwTYjtOZkaOK/wRkxXpJ+xQpfpDSAvzN
	 D+PojuRVdSl4EuNcy/PHOB14hHCrFbvC9AI1/oXqkECtMvP8Mpq/KWk0D4AeAPLa2q
	 RBrtzLAt96A3g==
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
Subject: [PATCH 04/39] spi: axiado: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:28 +0800
Message-ID: <20260803142003.12857-5-jszhang@kernel.org>
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
 drivers/spi/spi-axiado.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 649f149617ce..c8e389e3e97e 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -902,7 +902,7 @@ static void ax_spi_remove(struct platform_device *pdev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused ax_spi_suspend(struct device *dev)
+static int ax_spi_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
@@ -917,7 +917,7 @@ static int __maybe_unused ax_spi_suspend(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused ax_spi_resume(struct device *dev)
+static int ax_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
@@ -934,7 +934,7 @@ static int __maybe_unused ax_spi_resume(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused ax_spi_runtime_resume(struct device *dev)
+static int ax_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
@@ -963,7 +963,7 @@ static int __maybe_unused ax_spi_runtime_resume(struct device *dev)
  *
  * Return:	Always 0
  */
-static int __maybe_unused ax_spi_runtime_suspend(struct device *dev)
+static int ax_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct ax_spi *xspi = spi_controller_get_devdata(ctlr);
@@ -975,9 +975,8 @@ static int __maybe_unused ax_spi_runtime_suspend(struct device *dev)
 }
 
 static const struct dev_pm_ops ax_spi_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(ax_spi_runtime_suspend,
-			   ax_spi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(ax_spi_suspend, ax_spi_resume)
+	RUNTIME_PM_OPS(ax_spi_runtime_suspend, ax_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(ax_spi_suspend, ax_spi_resume)
 };
 
 static const struct of_device_id ax_spi_of_match[] = {
@@ -993,7 +992,7 @@ static struct platform_driver ax_spi_driver = {
 	.driver = {
 		.name = AX_SPI_NAME,
 		.of_match_table = ax_spi_of_match,
-		.pm = &ax_spi_dev_pm_ops,
+		.pm = pm_ptr(&ax_spi_dev_pm_ops),
 	},
 };
 
-- 
2.53.0

