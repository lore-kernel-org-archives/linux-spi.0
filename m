Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309D303C9C;
	Mon,  3 Aug 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768458; cv=none; b=UX83g+cAAGprboDozR+NZZwouZcQLgvpS6549/PdPQfDbv4acJDgB8o0VKQJFN/a+XByEmGTsrXKPLnqpUX72zqOPGZ1k8IxBHHIYQaQKsgqXc+/9cNqpF6OWSyMCAFogWOFCyNDKVAnEjbG3k2xGRHK1Z3+wGzYXhQuj2baOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768458; c=relaxed/simple;
	bh=m8v3OFLIti6H8Cp6MomDvkipHJpgMuOdRXDtyCF4IZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUmQxOR+Y590VqSdSONa7s6tfY/t1FuiLsTpvLOcVpXZBHZ2xLHMCsFdEYhDDMIOQojfnyUG/TJ6Lf7aHDur5USlPxoM2EAra9nDkxszIacYST8P/h4Di7bQR51K3d+dBPg1/dZIAJSkcx+ycHVGrFPjH5j7sMD4ex1wCL2+Fis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxO4qi9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxO4qi9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4312B1F000E9;
	Mon,  3 Aug 2026 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768457;
	bh=QJStuAggcKF1nXu7NXEt8uGHvIkJp1MSnsjyNzc0HrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxO4qi9SIsYk+tYSasKFQn0rlVuTurEOxyGXkn6cfsVxn+KT8vd94SQ0BP9tr9wmv
	 3hgCFr4RTcwQBGIApXoqL7SdHp2gvkmeT4JQVB2eO6RpyW5fcPPQFpmkVWbxbCc0SU
	 twLZh6/OQG1KxvUq430hVGyXmQcmt0WCOYrREyoVCeh+12lKV2YrsLqvcntsFCA8tz
	 8TfDJupMMggl8T2iJhFb6ChzcfetEaRNtdohQOzs+uJcbsB1/4wq8EGIwh9xcvVs/k
	 613JSx57TxEC9nsTJkElHM5kKtuCj5r8ea3TP5D6zrzQg2urfXKtLde8E74eSsmQYm
	 n9WwloeMoXSRA==
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
Subject: [PATCH 38/39] spi: topcliff-pch: use modern PM macros
Date: Mon,  3 Aug 2026 22:20:02 +0800
Message-ID: <20260803142003.12857-39-jszhang@kernel.org>
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

At the same time, for pch_spi_pd_driver, we also switch to modern
driver.pm for pm ops.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 47 +++++++++++++++-------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index c5409ca7faef..98723042c16f 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1438,19 +1438,17 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 
 	spi_controller_put(data->host);
 }
-#ifdef CONFIG_PM
-static int pch_spi_pd_suspend(struct platform_device *pd_dev,
-			      pm_message_t state)
+
+static int pch_spi_pd_suspend(struct device *dev)
 {
 	u8 count;
-	struct pch_spi_board_data *board_dat = dev_get_platdata(&pd_dev->dev);
-	struct pch_spi_data *data = platform_get_drvdata(pd_dev);
+	struct pch_spi_board_data *board_dat = dev_get_platdata(dev);
+	struct pch_spi_data *data = dev_get_drvdata(dev);
 
-	dev_dbg(&pd_dev->dev, "%s ENTRY\n", __func__);
+	dev_dbg(dev, "%s ENTRY\n", __func__);
 
 	if (!board_dat) {
-		dev_err(&pd_dev->dev,
-			"%s pci_get_drvdata returned NULL\n", __func__);
+		dev_err(dev, "%s pci_get_drvdata returned NULL\n", __func__);
 		return -EFAULT;
 	}
 
@@ -1471,22 +1469,20 @@ static int pch_spi_pd_suspend(struct platform_device *pd_dev,
 		free_irq(board_dat->pdev->irq, data);
 
 		data->irq_reg_sts = false;
-		dev_dbg(&pd_dev->dev,
-			"%s free_irq invoked successfully.\n", __func__);
+		dev_dbg(dev, "%s free_irq invoked successfully.\n", __func__);
 	}
 
 	return 0;
 }
 
-static int pch_spi_pd_resume(struct platform_device *pd_dev)
+static int pch_spi_pd_resume(struct device *dev)
 {
-	struct pch_spi_board_data *board_dat = dev_get_platdata(&pd_dev->dev);
-	struct pch_spi_data *data = platform_get_drvdata(pd_dev);
+	struct pch_spi_board_data *board_dat = dev_get_platdata(dev);
+	struct pch_spi_data *data = dev_get_drvdata(dev);
 	int retval;
 
 	if (!board_dat) {
-		dev_err(&pd_dev->dev,
-			"%s pci_get_drvdata returned NULL\n", __func__);
+		dev_err(dev, "%s pci_get_drvdata returned NULL\n", __func__);
 		return -EFAULT;
 	}
 
@@ -1495,8 +1491,7 @@ static int pch_spi_pd_resume(struct platform_device *pd_dev)
 		retval = request_irq(board_dat->pdev->irq, pch_spi_handler,
 				     IRQF_SHARED, KBUILD_MODNAME, data);
 		if (retval < 0) {
-			dev_err(&pd_dev->dev,
-				"%s request_irq failed\n", __func__);
+			dev_err(dev, "%s request_irq failed\n", __func__);
 			return retval;
 		}
 
@@ -1507,19 +1502,17 @@ static int pch_spi_pd_resume(struct platform_device *pd_dev)
 	}
 	return 0;
 }
-#else
-#define pch_spi_pd_suspend NULL
-#define pch_spi_pd_resume NULL
-#endif
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pch_spi_pd_pm_ops,
+				pch_spi_pd_suspend, pch_spi_pd_resume);
 
 static struct platform_driver pch_spi_pd_driver = {
 	.driver = {
 		.name = "pch-spi",
+		.pm = pm_sleep_ptr(&pch_spi_pd_pm_ops),
 	},
 	.probe = pch_spi_pd_probe,
 	.remove = pch_spi_pd_remove,
-	.suspend = pch_spi_pd_suspend,
-	.resume = pch_spi_pd_resume
 };
 
 static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -1618,7 +1611,7 @@ static void pch_spi_remove(struct pci_dev *pdev)
 	kfree(pd_dev_save);
 }
 
-static int __maybe_unused pch_spi_suspend(struct device *dev)
+static int pch_spi_suspend(struct device *dev)
 {
 	struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
 
@@ -1629,7 +1622,7 @@ static int __maybe_unused pch_spi_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused pch_spi_resume(struct device *dev)
+static int pch_spi_resume(struct device *dev)
 {
 	struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
 
@@ -1641,14 +1634,14 @@ static int __maybe_unused pch_spi_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(pch_spi_pm_ops, pch_spi_suspend, pch_spi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(pch_spi_pm_ops, pch_spi_suspend, pch_spi_resume);
 
 static struct pci_driver pch_spi_pcidev_driver = {
 	.name = "pch_spi",
 	.id_table = pch_spi_pcidev_id,
 	.probe = pch_spi_probe,
 	.remove = pch_spi_remove,
-	.driver.pm = &pch_spi_pm_ops,
+	.driver.pm = pm_sleep_ptr(&pch_spi_pm_ops),
 };
 
 static int __init pch_spi_init(void)
-- 
2.53.0

