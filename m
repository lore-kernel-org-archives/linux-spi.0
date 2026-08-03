Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A83E1693;
	Mon,  3 Aug 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768437; cv=none; b=jw5v6BQKx07ctPqNcyi21Z1kdv8m1pXYh9pBFraZOvRmvY8Cu5SMYtIOBKWRC3UsuhExRaVavWD1Bo51EdYEzskdtBHWlwBA8GIhMTeXWoo5e/UQcj1TpgGsK5waGISOQHVNGnv2Mjn4HQFtpbd9m6+02LSIcFmhq+jMIouQE+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768437; c=relaxed/simple;
	bh=uclEmFxV03jriluxmcY89G7LolTTF7FzDhkDAFfCBaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYSNmfqWGy3SZlwrLNzukw/XSGeXfgQ7jYYj0nkXYo+TsWjDrbYIOykXuqPfQKgT3SeEGBv+dfL2KMIGQeelw9zXjXinWssoPEHn5Xj9RHTjwUSkKC0UBNNQj5KC6tU1hDkPQsvYH7HEPWJM6Nm6IEMUsX9x+x6SVqFtfM8ZIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8afrLM0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8afrLM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B54A1F000E9;
	Mon,  3 Aug 2026 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768436;
	bh=6NkiNvgbgYuE5f4JQ+Ko6GUV8Jy8D2RlfkfEKUf2PDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K8afrLM0szciqnFhbEHQXQWkmd2S0ITwg0QdarhEepDiZHQr2HOAJCd+ZDh/Aju3P
	 3lYreLmtYDHjiPyTd+Ds/W3oPHLterDG4mBpqyr4wZgXN9peiAa8IfhOi5YxNZu3UW
	 YjhLM6Z+sqHCVlOHkT7uXDhcRxPwLddFQ0PaIEha+q91KYxKW28+DrnyWiALGBK1E3
	 gdPZL4oVgcOsO6b80fnZp/9pfMS2yoW2yXXtgk1x1njtkFlk/3NiBkgCWdhb3oyWJA
	 o89LEqB3VIbRik2m11jnXgHw606Ntet88RqJ9/Y0HIwjG2blmCGEogS1aYXAfbNZtJ
	 DF+48dnHOOWyA==
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
Subject: [PATCH 36/39] spi: tegra20-slink: use modern PM macros
Date: Mon,  3 Aug 2026 22:20:00 +0800
Message-ID: <20260803142003.12857-37-jszhang@kernel.org>
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
 drivers/spi/spi-tegra20-slink.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index c15c076295cd..ed1fcf57dd30 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1144,7 +1144,6 @@ static void tegra_slink_remove(struct platform_device *pdev)
 		tegra_slink_deinit_dma_param(tspi, true);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tegra_slink_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -1169,9 +1168,8 @@ static int tegra_slink_resume(struct device *dev)
 
 	return spi_controller_resume(host);
 }
-#endif
 
-static int __maybe_unused tegra_slink_runtime_suspend(struct device *dev)
+static int tegra_slink_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
@@ -1183,7 +1181,7 @@ static int __maybe_unused tegra_slink_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused tegra_slink_runtime_resume(struct device *dev)
+static int tegra_slink_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct tegra_slink_data *tspi = spi_controller_get_devdata(host);
@@ -1198,14 +1196,14 @@ static int __maybe_unused tegra_slink_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops slink_pm_ops = {
-	SET_RUNTIME_PM_OPS(tegra_slink_runtime_suspend,
-		tegra_slink_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_slink_suspend, tegra_slink_resume)
+	RUNTIME_PM_OPS(tegra_slink_runtime_suspend,
+		       tegra_slink_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(tegra_slink_suspend, tegra_slink_resume)
 };
 static struct platform_driver tegra_slink_driver = {
 	.driver = {
 		.name		= "spi-tegra-slink",
-		.pm		= &slink_pm_ops,
+		.pm		= pm_ptr(&slink_pm_ops),
 		.of_match_table	= tegra_slink_of_match,
 	},
 	.probe =	tegra_slink_probe,
-- 
2.53.0

