Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9441F7E9;
	Mon,  3 Aug 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768399; cv=none; b=uwO300wlICYYoAoBsqIX/mtHSJVb7eimEjfDk6Z74P5mt2kg8dvoInMYVvK/SGZSe+x0BMl+QroJTA0hsMPc85kzKYaamPgvIZmKsfd7qkE1U66x1G1Pm3QhqCUAvILfsTgUBHuNntA0gU3D6zS1OgxL2pGOrqavDlctAn3I5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768399; c=relaxed/simple;
	bh=eVDYNxzibgGEnzdKlm5tkSAIZrnvBCygHRYmPVA9tmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUbm8DKFN/VMVWN59thz4rfS5zWq26cdsB4YhV44JE3TRg+xmErE65ZsM2+k0QszHiuwwUxM/fBgO4I9WP/3AdYBs6xXpZj72I+4YmQb7WEsiIEYUbppKeJZbFWCHqIuE87/fvS1dEeKYAVXI0wHHSALEMH8XTbL3bJ/B9DGbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9H/RQdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9H/RQdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514B61F00A3A;
	Mon,  3 Aug 2026 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768397;
	bh=M6KcyTYYdhKMb90eB7bE0t1c7687yortLmew/Ul/dm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9H/RQdXCRnqmyicFBdwcAhCDsoJRlBPSmc3DqSLuRiUF52ZdqpjV5mASbaTKBD7n
	 j1am6pXzUirCpxOc37IppWJ+xBAPM9/6Y0B+7iMZ6H8SchaTjmbp5GXBGUKn7xWLz2
	 JjLym+HjARhfQcYmDm02lMZbhXO8uWgKqsMpkWWUnFDTtivcMXt1y385jtOD5M1CT5
	 l4qqiMShfRJzuLdZIOdu59Wy0H5rCpdo9nhDYSkTwENspARQpZXYSAuQ6CzXNXSjWg
	 9U7Wm02Mul8Cyr4p7A1NfT7GztNZ9P0cXMSZZZqb0q6+b4nJ4AvzTmSj/WaIzoFQIO
	 Nai8JKT5kyoGA==
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
Subject: [PATCH 33/39] spi: syncuacer: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:57 +0800
Message-ID: <20260803142003.12857-34-jszhang@kernel.org>
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
 drivers/spi/spi-synquacer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index c14225e39fd1..6d0cd11637b5 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -738,7 +738,7 @@ static void synquacer_spi_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sspi->clk);
 }
 
-static int __maybe_unused synquacer_spi_suspend(struct device *dev)
+static int synquacer_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
@@ -754,7 +754,7 @@ static int __maybe_unused synquacer_spi_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused synquacer_spi_resume(struct device *dev)
+static int synquacer_spi_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct synquacer_spi *sspi = spi_controller_get_devdata(host);
@@ -786,8 +786,8 @@ static int __maybe_unused synquacer_spi_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(synquacer_spi_pm_ops, synquacer_spi_suspend,
-			 synquacer_spi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(synquacer_spi_pm_ops, synquacer_spi_suspend,
+				synquacer_spi_resume);
 
 static const struct of_device_id synquacer_spi_of_match[] = {
 	{.compatible = "socionext,synquacer-spi"},
@@ -806,7 +806,7 @@ MODULE_DEVICE_TABLE(acpi, synquacer_hsspi_acpi_ids);
 static struct platform_driver synquacer_spi_driver = {
 	.driver = {
 		.name = "synquacer-spi",
-		.pm = &synquacer_spi_pm_ops,
+		.pm = pm_sleep_ptr(&synquacer_spi_pm_ops),
 		.of_match_table = synquacer_spi_of_match,
 		.acpi_match_table = ACPI_PTR(synquacer_hsspi_acpi_ids),
 	},
-- 
2.53.0

