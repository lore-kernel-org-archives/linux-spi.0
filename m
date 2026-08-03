Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A6414DFA;
	Mon,  3 Aug 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768016; cv=none; b=O5UKeIn2cHfmybDW+Sus0QaRyoCFrgApRDjDv99wICiwZ/Ten70CsXHd1HmMZ7q7uiiHcWZRwjk/fgLrQlOlm8atmHQtgWCIBDAWoO2kCc19E0KXaxUcbzR1Jc14dX6jt277WcQIvXeQDQFCPa8qHXrlVU0wgDiTplCJPSubOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768016; c=relaxed/simple;
	bh=j03Ip6HwLTm4Bm01zZdYl5S7cjV8eaaNcVDuFyQLqCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMnS7ReifhhxNr/3FOb13suUtFGDpmU51Sq4PM7oSXOmRo4SAHqJtucOX5SPxw9SFBbA5TSnZgfoLgsWjZzO6zfwIZ8J5P6SXnRHsZeElGSYOSHR50hjgC84ExSHol1AqCu/1NqlTKz1LpMegjYdGFbgYzYHpZyy7bxYNOemS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oouUE4Gu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oouUE4Gu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26601F000E9;
	Mon,  3 Aug 2026 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768014;
	bh=VxglCs+ea3c0Dxgwyd90UOXbko+4Uh7TAYs69rXIsqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oouUE4GuXW5dVVs3myp/tQcsUMd8xfQZda2iTuHW+9oFkcJs7BI6LWR+lVI0R/2a5
	 eHC1J7ShZaXwzs/pcK1cYmIsRboY8zzdy7j85tbXTHLQTOLWnMdJLQ47gRc0wRxCYY
	 8UaoO6/HNhVWmLq2a1EOTnbilu5Qik+RQ5KDDTx2rQOXxF8LyrN5RT2AH3JkmMNZT4
	 cDX3M97jvJN23HgzmDr5LzGW8ksEJ4whM5Yttqc74l1WnKF98s0l4mXino1kcRyJ3N
	 KAEXvu5fBwIP9JWDP++PpJ66E/ln0vrkpblvzBXBuabmnoW+YwHIXyVVYAR1w9C14s
	 9IMTj9vWPVDGg==
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
Subject: [PATCH 02/39] spi: amlogic-spifc-a1: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:26 +0800
Message-ID: <20260803142003.12857-3-jszhang@kernel.org>
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
 drivers/spi/spi-amlogic-spifc-a1.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a1.c b/drivers/spi/spi-amlogic-spifc-a1.c
index 77a2c11bec5e..388bd2472dc0 100644
--- a/drivers/spi/spi-amlogic-spifc-a1.c
+++ b/drivers/spi/spi-amlogic-spifc-a1.c
@@ -374,7 +374,6 @@ static int amlogic_spifc_a1_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int amlogic_spifc_a1_suspend(struct device *dev)
 {
 	struct amlogic_spifc_a1 *spifc = dev_get_drvdata(dev);
@@ -409,9 +408,7 @@ static int amlogic_spifc_a1_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int amlogic_spifc_a1_runtime_suspend(struct device *dev)
 {
 	struct amlogic_spifc_a1 *spifc = dev_get_drvdata(dev);
@@ -432,14 +429,12 @@ static int amlogic_spifc_a1_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops amlogic_spifc_a1_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(amlogic_spifc_a1_suspend,
-				amlogic_spifc_a1_resume)
-	SET_RUNTIME_PM_OPS(amlogic_spifc_a1_runtime_suspend,
-			   amlogic_spifc_a1_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(amlogic_spifc_a1_suspend, amlogic_spifc_a1_resume)
+	RUNTIME_PM_OPS(amlogic_spifc_a1_runtime_suspend,
+		       amlogic_spifc_a1_runtime_resume,
+		       NULL)
 };
 
 #ifdef CONFIG_OF
@@ -455,7 +450,7 @@ static struct platform_driver amlogic_spifc_a1_driver = {
 	.driver	= {
 		.name		= "amlogic-spifc-a1",
 		.of_match_table	= of_match_ptr(amlogic_spifc_a1_dt_match),
-		.pm		= &amlogic_spifc_a1_pm_ops,
+		.pm		= pm_ptr(&amlogic_spifc_a1_pm_ops),
 	},
 };
 module_platform_driver(amlogic_spifc_a1_driver);
-- 
2.53.0

