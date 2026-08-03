Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D74137B9;
	Mon,  3 Aug 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768201; cv=none; b=dGkoF9fpUpVX6JTmY2WWKDBZn/yl8X5k0WxlTRHs3zfkZtIMt1r/Za+alm41g3Mol+z3TDfmR6NwzNS9KCGX8MCHvQFPvrG1foxddpHSevg4dxMTJzPrddHDw9loDBdwknk+8q08TkzT/fHvRqRDWqS0qWAH1KupfL7BXbA7eRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768201; c=relaxed/simple;
	bh=128D1CmfpB4hDCFvZHbrEcuX3UD620EghvWdnOwKeTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSDvbi5L2sYn1SVt1/ytlYtIrA3PVMbv2b51x27zzozeeOtSz7WZXzldJaB7NaZJ/arrgM8tc7HdDgh42dE20ScoC6C43HPxw9DBeSReIoCdqlPMmBp8oJaSHnTrz00CTnFb1P/JokYdV8XKZqHmb3fS1cAYsBbK26FhC/9lUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2s49sww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2s49sww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A0D1F000E9;
	Mon,  3 Aug 2026 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768200;
	bh=ivN5Aq/EyYjo0qiUP2YpxxDgbYqAgKxP7Zc3nRYCQaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2s49swwDTPZYVKstRSKor/OasJIfy5JkXJVanG3QXw37G34OoJG3D6julTn2dyDl
	 EdbTyzXnGJiWvebreM1RwPfcXqZTA+fGI9ERxBr4Q4/zg72bwvVlNoX5yDv+uFt6Pi
	 czWRNBbiEHXCiRVCLFf+/tfvTdjmUNiodd3f9vU6v3mDU8GSzclXIhRZDav1ass1Mx
	 CrFfOUW5WedVvdzly9IvbTeIEvNSYQ4F56lNTtNMaxkBiZ+88beZVhDPsMY6Z2OJfl
	 KOD1b/r/ySAdyoznCFGpo17czmLcqMsS9N1zWkoD/Yh4SIROoWNcShHNoWBauleV3Y
	 8nvm8GxkdojBw==
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
Subject: [PATCH 17/39] spi: loongson: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:41 +0800
Message-ID: <20260803142003.12857-18-jszhang@kernel.org>
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
 drivers/spi/spi-loongson-core.c | 4 ++--
 drivers/spi/spi-loongson-pci.c  | 2 +-
 drivers/spi/spi-loongson-plat.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-core.c
index f50423c3db4c..30b6a7176ce9 100644
--- a/drivers/spi/spi-loongson-core.c
+++ b/drivers/spi/spi-loongson-core.c
@@ -229,7 +229,7 @@ int loongson_spi_init_controller(struct device *dev, void __iomem *regs)
 }
 EXPORT_SYMBOL_NS_GPL(loongson_spi_init_controller, "SPI_LOONGSON_CORE");
 
-static int __maybe_unused loongson_spi_suspend(struct device *dev)
+static int loongson_spi_suspend(struct device *dev)
 {
 	struct loongson_spi *loongson_spi;
 	struct spi_controller *controller;
@@ -249,7 +249,7 @@ static int __maybe_unused loongson_spi_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused loongson_spi_resume(struct device *dev)
+static int loongson_spi_resume(struct device *dev)
 {
 	struct loongson_spi *loongson_spi;
 	struct spi_controller *controller;
diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pci.c
index 2fe5419a8dd2..ccc26efd88fe 100644
--- a/drivers/spi/spi-loongson-pci.c
+++ b/drivers/spi/spi-loongson-pci.c
@@ -43,7 +43,7 @@ static struct pci_driver loongson_spi_pci_driver = {
 	.probe      = loongson_spi_pci_register,
 	.driver	= {
 		.bus = &pci_bus_type,
-		.pm = &loongson_spi_dev_pm_ops,
+		.pm = pm_sleep_ptr(&loongson_spi_dev_pm_ops),
 	},
 };
 module_pci_driver(loongson_spi_pci_driver);
diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-plat.c
index 550b237838c0..6f8202264341 100644
--- a/drivers/spi/spi-loongson-plat.c
+++ b/drivers/spi/spi-loongson-plat.c
@@ -35,7 +35,7 @@ static struct platform_driver loongson_spi_plat_driver = {
 	.driver	= {
 		.name	= "loongson-spi",
 		.bus = &platform_bus_type,
-		.pm = &loongson_spi_dev_pm_ops,
+		.pm = pm_sleep_ptr(&loongson_spi_dev_pm_ops),
 		.of_match_table = loongson_spi_id_table,
 	},
 };
-- 
2.53.0

