Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D583267B07;
	Mon,  3 Aug 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768446; cv=none; b=owuiZLWXSWjK6cLCPcEdJYx5PIVY7YQGJmzGZbU2+9B3NNueYb2Q5+4H5ogQIMuj+VrcSYdKAOb3+DQ4TgTVKj7NPZf1aUELq2cgQBGZwhIwzz1ilq1OXAXt2eDa+VdiD6/cZh/Vke+FwpyFSbx6GwdrZ8drZ0moqP3hhaHlCGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768446; c=relaxed/simple;
	bh=OP4yhx7wZia7YCXeLoQEJ3Imk8DGC1p0azH81HLrnh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mn5a7yefiJzxyTqUtJ9P7eXFkpW31hSO48wRVXqK26vsRd8mghoxHGiO4fM49JMxWGyMnzj1ybxhkjD/9SnhSqKfqguDFB9aHbl377ihfntMvnk4rHKdCb2Xlxt3OAt2uCgoBajpRWPZvP5Y+ORfwqGbpfCSpdawo8BQtD78Ef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN+o+baV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN+o+baV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA321F00A3A;
	Mon,  3 Aug 2026 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768445;
	bh=Mo+WbYK0qfnbpg3vk5MVhQ1BxW8zq7G90SRaL0JyLX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JN+o+baVU/qosAsXKlbdV/gjb99HAu91oaUADIOH2LpRCjTYfsecT9mGwQmX1uBeu
	 1+uOCt6DfHZ6yFv46yNUuIMUfRf5y08/+rQO6/veoMA51d70hpCBOmSBgUUJgYR8o0
	 SkaMb1ZfnenpiXTLq25sZqA4GQdx1j9WeQawyBTZxKIRdHnCaocRq4S7L2NO7jeOj9
	 bYHWZujqU9nFWQpsBTdpOPibUUOns2rHW8wR2++OIyqCHoGboYkBVPe983a4ZkcNgA
	 tl+3QJ8jAH7IPiat6pGoDD6quAh4kN0XqweMGM4BoSgFeLQ1kQze2yTZG/UpUFib5H
	 8uCAzssAVSyyg==
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
Subject: [PATCH 37/39] spi: tegra210-quad: use modern PM macros
Date: Mon,  3 Aug 2026 22:20:01 +0800
Message-ID: <20260803142003.12857-38-jszhang@kernel.org>
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
 drivers/spi/spi-tegra210-quad.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 588a929a9785..8ede864c3d3c 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1837,14 +1837,14 @@ static void tegra_qspi_remove(struct platform_device *pdev)
 	tegra_qspi_deinit_dma(tqspi);
 }
 
-static int __maybe_unused tegra_qspi_suspend(struct device *dev)
+static int tegra_qspi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 
 	return spi_controller_suspend(host);
 }
 
-static int __maybe_unused tegra_qspi_resume(struct device *dev)
+static int tegra_qspi_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
@@ -1863,7 +1863,7 @@ static int __maybe_unused tegra_qspi_resume(struct device *dev)
 	return spi_controller_resume(host);
 }
 
-static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
+static int tegra_qspi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
@@ -1879,7 +1879,7 @@ static int __maybe_unused tegra_qspi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev)
+static int tegra_qspi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(host);
@@ -1896,14 +1896,14 @@ static int __maybe_unused tegra_qspi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops tegra_qspi_pm_ops = {
-	SET_RUNTIME_PM_OPS(tegra_qspi_runtime_suspend, tegra_qspi_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_qspi_suspend, tegra_qspi_resume)
+	RUNTIME_PM_OPS(tegra_qspi_runtime_suspend, tegra_qspi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(tegra_qspi_suspend, tegra_qspi_resume)
 };
 
 static struct platform_driver tegra_qspi_driver = {
 	.driver = {
 		.name		= "tegra-qspi",
-		.pm		= &tegra_qspi_pm_ops,
+		.pm		= pm_ptr(&tegra_qspi_pm_ops),
 		.of_match_table	= tegra_qspi_of_match,
 		.acpi_match_table = ACPI_PTR(tegra_qspi_acpi_match),
 	},
-- 
2.53.0

