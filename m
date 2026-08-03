Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774DC411FA9;
	Mon,  3 Aug 2026 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768213; cv=none; b=JgntCkVFcsovyddVxWjNhNwJxQjjNcIK4cst6IFuLTw7OsWRJZXqWnsFrE10GOM3spU+8eqOoiEoVYN/3bqxPF6LoTMTalEL6fjVqSbrU+rOW/uRQPIqXeATqMwwg+wkyDDap/82QMAJ1HacZKFUIvyeHNs/6Gr2i2FfcseCXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768213; c=relaxed/simple;
	bh=47hBFYwv1QdhUP4ows3APuspFj39h+bkn8E16rn4EEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ed46SP6DYOKiti5UBCB8it9nW+6ZVvjrkKXoA23Ky0E6dFmDiOhLRFO4gVQkmwzDMUQz0pRia1LJ+UCDLA2aq49KRcR3h8RuN6Ychi/XpxVn/giGhu3dBPgNPwNY5bpxS5+nfthtLSN+54gmM2xC5hJPGTFVlVCwgIzXrb11Mt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2WPZiZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2WPZiZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6771F00A3A;
	Mon,  3 Aug 2026 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768212;
	bh=qlIUiMjQYU3CDsVD7Nq654m9H5XXKXU9Fx2wGOali6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2WPZiZQm+TAUHy80rzSrKMgpSEkbdagezOFxnshMyTOfln15G1ptgLJTN4RoGiAU
	 fS8j9n9fgEVK5x87v+O3HTxsNS7Vo2RaUqBLrvMjvSVIZH0JByv6XSs0dIFM+Nlksj
	 jSNao/hBQDc/sBETw11b5p7tyScC4+TEK8+xI07pnjOaL1ArOgzppdkEEvx0xvjh6T
	 e+O1U1EnMOjFSkEYt99NItGIY+RTcSqHHsW3uqQBqmweHUrvsGWNwOCnXbIVMxxdmL
	 LCP7JN/lNfDWnN9lctSWJHQVdh8lockkPjQ1/c3hXc9GNgDX1BeX7wnrzJkucPTs2W
	 8dbV0G4jIhF2g==
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
Subject: [PATCH 18/39] spi: meson-spifc: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:42 +0800
Message-ID: <20260803142003.12857-19-jszhang@kernel.org>
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
 drivers/spi/spi-meson-spifc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index e36aa94bbdae..2ef090dec7ba 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -348,7 +348,6 @@ static void meson_spifc_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int meson_spifc_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -385,9 +384,7 @@ static int meson_spifc_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int meson_spifc_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
@@ -405,13 +402,12 @@ static int meson_spifc_runtime_resume(struct device *dev)
 
 	return clk_prepare_enable(spifc->clk);
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops meson_spifc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(meson_spifc_suspend, meson_spifc_resume)
-	SET_RUNTIME_PM_OPS(meson_spifc_runtime_suspend,
-			   meson_spifc_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(meson_spifc_suspend, meson_spifc_resume)
+	RUNTIME_PM_OPS(meson_spifc_runtime_suspend,
+		       meson_spifc_runtime_resume,
+		       NULL)
 };
 
 static const struct of_device_id meson_spifc_dt_match[] = {
@@ -427,7 +423,7 @@ static struct platform_driver meson_spifc_driver = {
 	.driver	= {
 		.name		= "meson-spifc",
 		.of_match_table	= of_match_ptr(meson_spifc_dt_match),
-		.pm		= &meson_spifc_pm_ops,
+		.pm		= pm_ptr(&meson_spifc_pm_ops),
 	},
 };
 
-- 
2.53.0

