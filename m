Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A04137BA;
	Mon,  3 Aug 2026 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768388; cv=none; b=sSnwYxtIwxRzo2ngHFZ9cOOnS6GLsZCh7V9GYILtlibh4pIczuM1zpVHMLu/syoXuLF16ZTgUYP+iBXCSg4QKuGK4QnpQgGt14aGQ8QA5Dvqqrssg0SY5Qh5GaJpbkZotTEHsOJDc+AaOWIMtPzKFA+htXUg05Z/mNXTGEDTcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768388; c=relaxed/simple;
	bh=Rg9R4XtLvFWg8NFF4P8t+FRCJByUC/qZSIO2kKSaT64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLxbsMmGXQatcM6tsX2w3+efuWQ9u+Fvue6EQYDpiwOkXZFUhoZhxXMHfhgonkz9FnW5TeSbeEANjelFy8kettsgxRUrWQQGOl4PrOS2T+b0K2jBn7DThuGpQnnhKKPqUA+sY9Wfjn7ZCNmqPkHnE/1JdJlEBcguviO5vmY+oQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biiNQJ3t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biiNQJ3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB611F00A3D;
	Mon,  3 Aug 2026 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768386;
	bh=Bcbtf6ZHAJGJTJISXdZ1qfeCTDXIgQZLsOdyVwXUbJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=biiNQJ3tBbti1oLeRgBek5MLDQXcbX07IeQZAcdpqbAavhl7nXyzWtOFDVct7w6dN
	 qz2pa9H8yrF9E5bU5tBOYVIu8uWagrRSMWpyMfS1nitE7jVdfsjvepvClvPNrfqHtV
	 RjdRSv/y4exPiC9u/26DvIS6duADsVSUNBWQIWoAysa/n2OnhCdl4HehS9NkwW2hbq
	 EBnS2XmQt4AYgO1SYiY/Ow/xdMImpGshKyPAIKOyQJ467zYbLjViFwhPpykA9KCdPP
	 fFMFu4b5Pr5UJJj9ow/5RxKnml2nib6clRVPgyKv0t+Yl7IQkE5aWjD2XfQVxLgH3w
	 K8bRTTWCXiZsQ==
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
Subject: [PATCH 32/39] spi: sunplus-sp7021: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:56 +0800
Message-ID: <20260803142003.12857-33-jszhang@kernel.org>
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
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards or
__maybe_unused.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-sunplus-sp7021.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index c1870322d976..f16fcda187dd 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -498,7 +498,7 @@ static void sp7021_spi_controller_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 }
 
-static int __maybe_unused sp7021_spi_controller_suspend(struct device *dev)
+static int sp7021_spi_controller_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
@@ -506,7 +506,7 @@ static int __maybe_unused sp7021_spi_controller_suspend(struct device *dev)
 	return reset_control_assert(pspim->rstc);
 }
 
-static int __maybe_unused sp7021_spi_controller_resume(struct device *dev)
+static int sp7021_spi_controller_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 	struct sp7021_spi_ctlr *pspim = spi_controller_get_devdata(ctlr);
@@ -515,7 +515,6 @@ static int __maybe_unused sp7021_spi_controller_resume(struct device *dev)
 	return clk_prepare_enable(pspim->spi_clk);
 }
 
-#ifdef CONFIG_PM
 static int sp7021_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
@@ -531,13 +530,12 @@ static int sp7021_spi_runtime_resume(struct device *dev)
 
 	return reset_control_deassert(pspim->rstc);
 }
-#endif
 
 static const struct dev_pm_ops sp7021_spi_pm_ops = {
-	SET_RUNTIME_PM_OPS(sp7021_spi_runtime_suspend,
-			   sp7021_spi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(sp7021_spi_controller_suspend,
-				sp7021_spi_controller_resume)
+	RUNTIME_PM_OPS(sp7021_spi_runtime_suspend,
+		       sp7021_spi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(sp7021_spi_controller_suspend,
+			    sp7021_spi_controller_resume)
 };
 
 static const struct of_device_id sp7021_spi_controller_ids[] = {
@@ -552,7 +550,7 @@ static struct platform_driver sp7021_spi_controller_driver = {
 	.driver = {
 		.name = "sunplus,sp7021-spi-controller",
 		.of_match_table = sp7021_spi_controller_ids,
-		.pm     = &sp7021_spi_pm_ops,
+		.pm     = pm_ptr(&sp7021_spi_pm_ops),
 	},
 };
 module_platform_driver(sp7021_spi_controller_driver);
-- 
2.53.0

