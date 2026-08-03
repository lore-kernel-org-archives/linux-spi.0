Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F840E8E7;
	Mon,  3 Aug 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768060; cv=none; b=ewTl1UQJfuYlO3+wdwyqmNJN19MX+CmORNmcazJVs73qg8GIeYERr6L8C1vl1yzT+DK/pE4CJbeGgYamXAOq23z7Cn8QZiq6xQ5m6QVkS4dlxPzfMLolIRrVTdEPLstGCHFwxhw460sczNopQ3zimzMxXRz7kaSChZnWWNMinKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768060; c=relaxed/simple;
	bh=PGAoRXoN0hyS54Lr9Rc8E3c+eY5oWMkvJfeVcCjTjho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3Q9LORmdX8kIekNWTyBC068oqJ5Gyg89e06naAYALhcZiowsJol0vQ28oN17Oo4yTZi7BrC6dBkhmoLpGAVp8CC8DeCoUacRUbmOf9sFVekm0d21wz/RSDIGB/iK12XqOHGBWtT/X3A+CLIRjr6aKTTyW4TQEDXQaESOFFrQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctWWWFFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctWWWFFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933C91F000E9;
	Mon,  3 Aug 2026 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768058;
	bh=FErana6KyfLoG+9M15o1hw3+E0XT2WYvRc8tNlGG7O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ctWWWFFnrwmypgMYWcxzJFo5TtsX6EMIUzsSXQXSHM0O9KZ/jg10h8NvvP0WaRdml
	 W2G56FZfmg3ex0ZUNrwaOMXBVsoksqdS0ZMb8fjNyINFRo2nQCxvf2PEYEkLc/L39+
	 NuZs3efWumZ/c40m43kfwHiKpa2A7pglgKMQgBWzuDzOi5RTyzpgBPuB8/ZdLDwIpy
	 RmcoG5msJuoXlDHlLnajejsnh3kUbc0BswKSC3hHX7H0yLBFP5m5JtFpF0pZsEvTXo
	 x6qNE6bGzKxeQ7FZ9/aOh1erx6tFuNk8k61XZKDnrCgNAhz3fzA72GZH9bs9XGdG0G
	 NtX63Hb20lddw==
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
Subject: [PATCH 05/39] spi: bcm-qspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:29 +0800
Message-ID: <20260803142003.12857-6-jszhang@kernel.org>
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
 drivers/spi/spi-bcm-qspi.c     | 6 +++---
 drivers/spi/spi-brcmstb-qspi.c | 2 +-
 drivers/spi/spi-iproc-qspi.c   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index dcade7b99cef..0db24fe7a109 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1689,7 +1689,7 @@ void bcm_qspi_remove(struct platform_device *pdev)
 /* function to be called by SoC specific platform driver remove() */
 EXPORT_SYMBOL_GPL(bcm_qspi_remove);
 
-static int __maybe_unused bcm_qspi_suspend(struct device *dev)
+static int bcm_qspi_suspend(struct device *dev)
 {
 	struct bcm_qspi *qspi = dev_get_drvdata(dev);
 
@@ -1705,7 +1705,7 @@ static int __maybe_unused bcm_qspi_suspend(struct device *dev)
 	return 0;
 };
 
-static int __maybe_unused bcm_qspi_resume(struct device *dev)
+static int bcm_qspi_resume(struct device *dev)
 {
 	struct bcm_qspi *qspi = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1724,7 +1724,7 @@ static int __maybe_unused bcm_qspi_resume(struct device *dev)
 	return ret;
 }
 
-SIMPLE_DEV_PM_OPS(bcm_qspi_pm_ops, bcm_qspi_suspend, bcm_qspi_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(bcm_qspi_pm_ops, bcm_qspi_suspend, bcm_qspi_resume);
 
 /* pm_ops to be called by SoC specific platform driver */
 EXPORT_SYMBOL_GPL(bcm_qspi_pm_ops);
diff --git a/drivers/spi/spi-brcmstb-qspi.c b/drivers/spi/spi-brcmstb-qspi.c
index 7a33b479c1f7..651a73446cff 100644
--- a/drivers/spi/spi-brcmstb-qspi.c
+++ b/drivers/spi/spi-brcmstb-qspi.c
@@ -31,7 +31,7 @@ static struct platform_driver brcmstb_qspi_driver = {
 	.remove			= brcmstb_qspi_remove,
 	.driver = {
 		.name		= "brcmstb_qspi",
-		.pm		= &bcm_qspi_pm_ops,
+		.pm		= pm_sleep_ptr(&bcm_qspi_pm_ops),
 		.of_match_table = brcmstb_qspi_of_match,
 	}
 };
diff --git a/drivers/spi/spi-iproc-qspi.c b/drivers/spi/spi-iproc-qspi.c
index 392acc4026ab..5255d5124385 100644
--- a/drivers/spi/spi-iproc-qspi.c
+++ b/drivers/spi/spi-iproc-qspi.c
@@ -141,7 +141,7 @@ static struct platform_driver bcm_iproc_driver = {
 	.remove			= bcm_iproc_remove,
 	.driver = {
 		.name		= "bcm_iproc",
-		.pm		= &bcm_qspi_pm_ops,
+		.pm		= pm_sleep_ptr(&bcm_qspi_pm_ops),
 		.of_match_table = bcm_iproc_of_match,
 	}
 };
-- 
2.53.0

