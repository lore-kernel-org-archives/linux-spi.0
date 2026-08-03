Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF741D21E;
	Mon,  3 Aug 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768376; cv=none; b=tWSieChI118+P+tPJ+xSOIRI8Tnyt4x/3QqFi2H12sDJBooR9I0KrQGPL2Fz1J6L6UObqaaeg1uaDSSVamqqKaolLqb42+BxZiyPxPHOw2+SY7++LikYcL4qwopVHeXu9jfaBjg1Dl9/JJ2C7XwUrv8hU4DfHN82KsAJPCdoVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768376; c=relaxed/simple;
	bh=HlpKTsyKoHTmzQrNpZAv5jOHHbvlj4P35xVIVLaPlDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rM9j8oRcs0VSLoEPW7km2yLnfa1Wiy+sV26lTkxp+wfcwue+hELQpIYFiG/Sa6XYAXcK/jBdJK/ByEz+UHe1H/TWMdJJSZr8zSFpKrmNz8fDJ2nPCe5UpDu0bD/8evuq/tEx2zDRQyBIowMqp0DEcLJuuRfFOjl+bVFfn60fCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzzocITx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzzocITx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01B61F00A3A;
	Mon,  3 Aug 2026 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768373;
	bh=llaQZ6uCqmKYby9DFqY5vdo6Mqo0ZPuV/PFMlIezwUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gzzocITx7naUalh1nwW/zr7lTVTdTp98MkwwzHocAJuEdCu/i2fuD+hcH4CaG3mvf
	 4vRKQIzIyUXyByMowUeWn6Ge4uVK7xtIfPMCbp8C2HgKeWXlj3cmJjZ5RylPYS7h4O
	 jv6JOv53PCv491baP45xMT3AvPbjxPOsQ5Or0CBwuD3k9UtfuufnovCxl1FgGFjOL/
	 h6k44kNs19I/qCGh/+XzPwqnJ8aa2COU7ky+fg32Uxv4cmIYVPIBwIZiX9xdPc38fB
	 EiW7Ftny1bGhQm9897ykYDxcYYwk5GxsL2lX/fquMh5w9HqXameEX5YMKn9Daw9nke
	 IyOhLKXqJ0YAg==
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
Subject: [PATCH 31/39] spi: sprd: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:55 +0800
Message-ID: <20260803142003.12857-32-jszhang@kernel.org>
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
 drivers/spi/spi-sprd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 29380938ef65..12b09174bb24 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -1016,7 +1016,7 @@ static void sprd_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)
+static int sprd_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *sctlr = dev_get_drvdata(dev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
@@ -1029,7 +1029,7 @@ static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused sprd_spi_runtime_resume(struct device *dev)
+static int sprd_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *sctlr = dev_get_drvdata(dev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
@@ -1050,8 +1050,7 @@ static int __maybe_unused sprd_spi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops sprd_spi_pm_ops = {
-	SET_RUNTIME_PM_OPS(sprd_spi_runtime_suspend,
-			   sprd_spi_runtime_resume, NULL)
+	RUNTIME_PM_OPS(sprd_spi_runtime_suspend, sprd_spi_runtime_resume, NULL)
 };
 
 static const struct of_device_id sprd_spi_of_match[] = {
@@ -1064,7 +1063,7 @@ static struct platform_driver sprd_spi_driver = {
 	.driver = {
 		.name = "sprd-spi",
 		.of_match_table = sprd_spi_of_match,
-		.pm = &sprd_spi_pm_ops,
+		.pm = pm_ptr(&sprd_spi_pm_ops),
 	},
 	.probe = sprd_spi_probe,
 	.remove = sprd_spi_remove,
-- 
2.53.0

