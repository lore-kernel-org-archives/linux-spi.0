Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401934F497;
	Mon,  3 Aug 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768421; cv=none; b=EO5l25qe+iC41lLReDf2Pp7MTg5v9DIke0+cjwfhWiGreHnUXLTkZsBRKeWE8CrjPlobrmIZPKiMRd+e14oxhsWHuq0t60qCm8HsseBrDBj+bsk3yb8eW/YroSQ18x22aVFUstKnO7aDKJQ4tWlZbqW4copd8UNZDslUmLnNot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768421; c=relaxed/simple;
	bh=aLet85za+RPwFLDE05XugohfAb4HItJodCGBtANfrEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrzHuU5xI+Xff1Tn2C7Usi6XKAo+gGuNhMY09D5vVayS8lZxO87zekIZkKVvnGuyxA+u5Zx259tp94eJKbTPA5TRiXW2aiNRD4JXVv5XrVUtIaDgVrW3MH6VDHr77DjA6wvFscpj2gbOgz2SVjAmfCGmCl8w2algLcSFKLFyb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEI4LUtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEI4LUtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8BD1F00A3A;
	Mon,  3 Aug 2026 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768420;
	bh=o0L9qc4oumavG1tn+aaIT7DAKheim9V6n6gw3jfXeek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEI4LUtc2sVv6whezpjlSywMZf6MDYdhXqbAUFjjZqKtN1xw5GuseXpUB9XMR+Yro
	 FI/6bwADIRxxY1lgVn/DtyUbL+I8Y/khgEUkRvXKbmqcYEISkxnnKsZslqyjXvOiSJ
	 vfCsyJJFJPgMWQTw1dogL/KwCFadwaUbxCvxeSgkP+dxKpEuGBUyPsQH8KeNHLBpxH
	 dWO1NdsXuUiIGllTEY0k1Lu4dyL0cLAActOzs9kl7CWj3XbqTFMRk2rpm0w/eWg5LA
	 xA6CMQWC019MYAh3GYxLYsyFzGlpF8seKEG99Uyg6VQiry826yZA38rk3vZdBiRbLM
	 QjkJy05h4HsIw==
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
Subject: [PATCH 35/39] spi: tegra20-sflash: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:59 +0800
Message-ID: <20260803142003.12857-36-jszhang@kernel.org>
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
 drivers/spi/spi-tegra20-sflash.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 2caa33f0a52c..2a5e3acea06b 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -533,7 +533,6 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 		tegra_sflash_runtime_suspend(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tegra_sflash_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -557,7 +556,6 @@ static int tegra_sflash_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif
 
 static int tegra_sflash_runtime_suspend(struct device *dev)
 {
@@ -586,14 +584,14 @@ static int tegra_sflash_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops slink_pm_ops = {
-	SET_RUNTIME_PM_OPS(tegra_sflash_runtime_suspend,
-		tegra_sflash_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_sflash_suspend, tegra_sflash_resume)
+	RUNTIME_PM_OPS(tegra_sflash_runtime_suspend,
+		       tegra_sflash_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(tegra_sflash_suspend, tegra_sflash_resume)
 };
 static struct platform_driver tegra_sflash_driver = {
 	.driver = {
 		.name		= "spi-tegra-sflash",
-		.pm		= &slink_pm_ops,
+		.pm		= pm_ptr(&slink_pm_ops),
 		.of_match_table	= tegra_sflash_of_match,
 	},
 	.probe =	tegra_sflash_probe,
-- 
2.53.0

