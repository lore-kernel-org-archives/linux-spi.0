Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635D42122B;
	Mon,  3 Aug 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768290; cv=none; b=uCzJZZdbYeSWKDf/bVefOYtg8oOqe7IW0l/9LqkJ0gEkE0vbCHeBjsvKipcTMseumrWmUh2oiTmep1/YLf2MlTBw18/xoBMQ6zPZU8G54TRgsIEskjezC9987kiL0CQisUhneSDowqoZt97fvRuNpuHpKOpx0bMvbgJy2jrKmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768290; c=relaxed/simple;
	bh=hYzhGLxgD9w7IbZFWF/gsM2g6Bjy4QmH6doHcS1NlDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yeonv9uR5EN+SlOzjnDF4JhNh50eJP6fHTcIxzRJWYBKDuLj4FJM+SaGHYTE6OzXU6+pvHRnIuloMT3y/g1l79z3cuK36D/U7CTZZ6HR3JrulcTnkIEtLKW/t9p76lajTEOmRIVdmkvl9DgQYegylOS8sibea+C1Ze7drtBN66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpQT0iHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpQT0iHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6434B1F000E9;
	Mon,  3 Aug 2026 14:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768289;
	bh=qy56uKywTC/l6VJWha0vrsN0jl56R/p44DX7cb65BIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YpQT0iHXQKfps7LyHkx3qAqVwoBah4JHtspAQ8zIrCB/hRwYVRv1H4ByaqiQio9sQ
	 9Wxb9Zh1KcvXmsIVnOF22fxsY3+7+7nWTMMjxmg+o556UjCwYmloY2AdOjBd9GQ7Pb
	 efK39my8hA+tE2EtW+p1lXZkKbwQ3R00j5nwnu6BX6+7jP3IFIbC9OgGwlHttsj39V
	 jJXwXN6oIgP/zuYWUSSFD7pk1gi3Ecrl6yS6nkERKvhEgaWGG7lNNFNePnVicbDDzI
	 BJD1MIL5Y9Hv1LE2B7OAHIYHVS0CmuuU+oiqHL04nfkpvy9dz2ZUSXaO2QleivT3A1
	 qinOQs7AMB0CQ==
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
Subject: [PATCH 24/39] spi: pl022: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:48 +0800
Message-ID: <20260803142003.12857-25-jszhang@kernel.org>
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
 drivers/spi/spi-pl022.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 95652df5fd09..4877ab909c51 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2011,7 +2011,6 @@ pl022_remove(struct amba_device *adev)
 	amba_release_regions(adev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int pl022_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
@@ -2049,9 +2048,7 @@ static int pl022_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int pl022_runtime_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
@@ -2071,11 +2068,10 @@ static int pl022_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops pl022_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
-	SET_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
+	RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
 };
 
 static struct vendor_data vendor_arm = {
@@ -2166,7 +2162,7 @@ MODULE_DEVICE_TABLE(amba, pl022_ids);
 static struct amba_driver pl022_driver = {
 	.drv = {
 		.name	= "ssp-pl022",
-		.pm	= &pl022_dev_pm_ops,
+		.pm	= pm_ptr(&pl022_dev_pm_ops),
 	},
 	.id_table	= pl022_ids,
 	.probe		= pl022_probe,
-- 
2.53.0

