Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143640DB46;
	Mon,  3 Aug 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768299; cv=none; b=X+KiR85f2ZF4FBpDuotL8iDe9rrG84r1GwGNbN9OT6fp6PAMgznH5cLYtj7aWFaICEzpXSzn6mnBg4/hX9wLO+F9vrFNu5+lOmTaaN9VOKNPMeGUwlbzhldxBwhlpLgf62nJc1jigW4p1Wdd2SuZuiK5ygGho/3v1AZlIyHr+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768299; c=relaxed/simple;
	bh=UNSKTuRmiOEsmMGigBwqUvq7f/+uzz/d1bv+ZEdBJwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euVC0MeuCqqp7EWJ0BkLse9vcf8e2xBYQeoJB3+sNz0n5HdCbJzNPl+sXbaZhCBTzLBxoMPuGBy9S0mPjPnLOSnpC5bxD1W7XuLD+kzaCVr4JotTiTC0+cLT6OI3ea6H//VEXL9dOExz5xTLZS3vqhOz1hfWl0pJjFTPNo/uQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FguBdYtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FguBdYtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684681F00A3D;
	Mon,  3 Aug 2026 14:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768298;
	bh=y/BAOdQjaKVdNWLZgzpeRkbbNiAISlSOmcwNyY7cYho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FguBdYtOD6gwBRDMujVlcTSZ5O9D/32GspkJQGQ055Rf1bsbGUz2sCoR1SK5eoMW+
	 DCzIR0XzZ/CFytAoW03p0ENuLukt65WyhVgMboFIFOYuuCeuC1RFRZaCGKx2OMzYJY
	 tyAzCeH60hLrQRYiP2ayClaGADwStSFS5/juGZWVLOcVydM2kFVQdzqdTHwfUQ5SwB
	 B0D6f6PU0EQWN+WfDRUCC4yr9yLmD33Gfn0Hg0lj2w6E8PkZJ4uxRR97xfdkCGeiKZ
	 Y+PNQ/KWC8YnAdtqwK2F2FupCmOTgm/WipOSD6ppexHGFGELSjwmsKUDUuF7g5q9rD
	 e0uRdFJ8rwL+A==
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
Subject: [PATCH 25/39] spi: spi-qcom-qspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:49 +0800
Message-ID: <20260803142003.12857-26-jszhang@kernel.org>
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
 drivers/spi/spi-qcom-qspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index caf55a6f70b3..0ac06a1ab868 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -828,7 +828,7 @@ static void qcom_qspi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
+static int qcom_qspi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
@@ -872,7 +872,7 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
+static int qcom_qspi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
@@ -916,7 +916,7 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused qcom_qspi_suspend(struct device *dev)
+static int qcom_qspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
@@ -932,7 +932,7 @@ static int __maybe_unused qcom_qspi_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused qcom_qspi_resume(struct device *dev)
+static int qcom_qspi_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	int ret;
@@ -949,9 +949,9 @@ static int __maybe_unused qcom_qspi_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops qcom_qspi_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(qcom_qspi_runtime_suspend,
-			   qcom_qspi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(qcom_qspi_suspend, qcom_qspi_resume)
+	RUNTIME_PM_OPS(qcom_qspi_runtime_suspend,
+		       qcom_qspi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(qcom_qspi_suspend, qcom_qspi_resume)
 };
 
 static const struct of_device_id qcom_qspi_dt_match[] = {
@@ -963,7 +963,7 @@ MODULE_DEVICE_TABLE(of, qcom_qspi_dt_match);
 static struct platform_driver qcom_qspi_driver = {
 	.driver = {
 		.name		= "qcom_qspi",
-		.pm		= &qcom_qspi_dev_pm_ops,
+		.pm		= pm_ptr(&qcom_qspi_dev_pm_ops),
 		.of_match_table = qcom_qspi_dt_match,
 	},
 	.probe = qcom_qspi_probe,
-- 
2.53.0

