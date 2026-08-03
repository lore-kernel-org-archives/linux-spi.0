Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BC3126C0;
	Mon,  3 Aug 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768145; cv=none; b=OjuYfIZc/64KLVS9DO04rykEMS9n+bKAZmI4QqL5VB+IlZTs004UWruW14wMlZO3GheMZNiKCaSik36w+G89Jzhjx3uswbI/a7m66niN+VaAbwdaIkmWmji6VFUgX/j1F5c4Wkg54B9DTy61voH8gRA9QdgsVfsDaIIvsZlG5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768145; c=relaxed/simple;
	bh=T6TBlRBar53eqthofIswZsTIkJ6Qk7Bsw0hEzLkN7yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBywii0C76xYTMS+Ok6KG81h48m4B1kmG+tXLwca3AoDvjww5O8PPG9CDG6IG7d7bwXt42T/u2vRXpIzhCpNUSeFqg9bW0u2p+lHGnZQb1rTJs1hg0+dlMESxG54HjzA83shNd3/QUXblbEHBgCTbnZFE3VciKh1yZTZk/o6WNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyI+FJA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyI+FJA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A571F00A3A;
	Mon,  3 Aug 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768143;
	bh=QcD2hSb+okH/yv0zcBzalnMjVU7hZfPP7gfMFbX7jvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GyI+FJA7F4jVjUAnIoiA8GOxeFMfWJ4Uyq7527kt51nlLO2i/6NQCDI5U3Rln396c
	 GkB9MNuhBnZPICfYrsSH5EBeXkaLXdnml1BR8qDqWgFVcjTjp/0tx4X8/scl1H2IqF
	 ZOWWfVP59PKTE2RsFHM5C+Y/AOn5rjjkAabBDMsaiV6dhsnhGiCetYtkX1ZGYWuOfa
	 7FG9weUCtm8tZ8kAiDKWbMCo9luLpbXooUfhziww0vUl3qGRedOe4/kqHV5IceqqOH
	 cdXgV2M8QT2GAXT6Usoq93sbhHBmJASv4L4TS9jyyikiWf9wrRal3wcsj6GH7smFNu
	 3NnBativh0xJQ==
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
Subject: [PATCH 12/39] spi: spi-fsl-dspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:36 +0800
Message-ID: <20260803142003.12857-13-jszhang@kernel.org>
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
 drivers/spi/spi-fsl-dspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 019d05cdefe6..ef86267c1772 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1460,7 +1460,6 @@ static int dspi_init(struct fsl_dspi *dspi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dspi_suspend(struct device *dev)
 {
 	struct fsl_dspi *dspi = dev_get_drvdata(dev);
@@ -1500,9 +1499,8 @@ static int dspi_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
 static int dspi_target_abort(struct spi_controller *host)
 {
@@ -1727,7 +1725,7 @@ static void dspi_shutdown(struct platform_device *pdev)
 static struct platform_driver fsl_dspi_driver = {
 	.driver.name		= DRIVER_NAME,
 	.driver.of_match_table	= fsl_dspi_dt_ids,
-	.driver.pm		= &dspi_pm,
+	.driver.pm		= pm_sleep_ptr(&dspi_pm),
 	.probe			= dspi_probe,
 	.remove			= dspi_remove,
 	.shutdown		= dspi_shutdown,
-- 
2.53.0

