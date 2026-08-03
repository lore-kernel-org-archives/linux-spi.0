Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036C3043DB;
	Mon,  3 Aug 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768312; cv=none; b=oeLkMHy223HSrjIYwfia0OkWYBPPAwKn98wFDBxM7Q4ZNoy6bEl8fifHr9m076oahWq1DgOCXIwrnpNFUegn9+vqYcu6OcQhnegI9CHsyLQL+lBOBhuAPs/NzqUKNJ9Uvb+Yl7cNSk+ZnNO3PvW9FHnl6L7lKDVM7MN6LbiPLZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768312; c=relaxed/simple;
	bh=oIRs66QZvJQSNZyNkENWFPxE2U5vULn8lIiwe2SBGHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxuvvUv9gHd+KkrZOAC2dXRUrhiz2KgUDXv9Fs3J/88YrL3qWvewrmUlXv1y4F+oZS11dh8rlE57jxoeDnBUf/XJ2R99CVBhsOxRR8nIhh78IxvR8ZCG9BW/AfHNWjBVoVSssC5z3TGWRf0hsmAbaHmRgPk/Hj7igd1P5YTgFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkKP2Qvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkKP2Qvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48821F000E9;
	Mon,  3 Aug 2026 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768310;
	bh=ZmQyfTV1Mv5u+ObaXKEqD3LBqLLXg6aYEChvXy0LKRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FkKP2QvyHa4+J9NQd83z3CnHfXJMse0Q0oCp+aYWOx1bADRSbYV6C3K5r98STcpof
	 YlaTVCb51YXIHaBiyNtl0TO31NGT2pmFunUoJq4F/BY9TXcGG6n9H/aD76tKeYgFIm
	 SjWFvqRYSPpl3I8iSI6DHsz8D31Qvj2JsKWcgqvCNtAoqXR/OYRQXV6eDKu2mlXrO1
	 0emmOeahSx3QeueLuMHeSMJGdQpnyS1heuK+aegtT/gmDdU3r/vm4/5M5QSQ8AmDYv
	 qx4ixFhejPUcX/nrjCUxD7svJKU16y+ubml22orYFfrYcxhir2FGYFnX+0EauEB0cn
	 9a6nRkMB64dqA==
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
Subject: [PATCH 26/39] spi: qup: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:50 +0800
Message-ID: <20260803142003.12857-27-jszhang@kernel.org>
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
 drivers/spi/spi-qup.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 034546b3f058..e8b076b1622d 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1211,7 +1211,6 @@ static int spi_qup_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM
 static int spi_qup_pm_suspend_runtime(struct device *device)
 {
 	struct spi_controller *host = dev_get_drvdata(device);
@@ -1253,9 +1252,7 @@ static int spi_qup_pm_resume_runtime(struct device *device)
 	writel_relaxed(config, controller->base + QUP_CONFIG);
 	return 0;
 }
-#endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM_SLEEP
 static int spi_qup_suspend(struct device *device)
 {
 	struct spi_controller *host = dev_get_drvdata(device);
@@ -1312,7 +1309,6 @@ static int spi_qup_resume(struct device *device)
 	clk_disable_unprepare(controller->iclk);
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static void spi_qup_remove(struct platform_device *pdev)
 {
@@ -1352,16 +1348,16 @@ static const struct of_device_id spi_qup_dt_match[] = {
 MODULE_DEVICE_TABLE(of, spi_qup_dt_match);
 
 static const struct dev_pm_ops spi_qup_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(spi_qup_suspend, spi_qup_resume)
-	SET_RUNTIME_PM_OPS(spi_qup_pm_suspend_runtime,
-			   spi_qup_pm_resume_runtime,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(spi_qup_suspend, spi_qup_resume)
+	RUNTIME_PM_OPS(spi_qup_pm_suspend_runtime,
+		       spi_qup_pm_resume_runtime,
+		       NULL)
 };
 
 static struct platform_driver spi_qup_driver = {
 	.driver = {
 		.name		= "spi_qup",
-		.pm		= &spi_qup_dev_pm_ops,
+		.pm		= pm_ptr(&spi_qup_dev_pm_ops),
 		.of_match_table = spi_qup_dt_match,
 	},
 	.probe = spi_qup_probe,
-- 
2.53.0

