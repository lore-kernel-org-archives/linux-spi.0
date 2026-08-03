Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198D41687C;
	Mon,  3 Aug 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768178; cv=none; b=HO7AjI9Rqw9M7LYikCTlkyPkCSmCmxPkKwXhyBYLBxFh7vU++nYb5+Aibfw5Hf76GY8X2Sar0L1vGSE878JQ8yUlFYKxsnKljlMhNAE0nJUbD02+9omChXxzHRLJz7setjGa6FHcglZF4911NCLvaRIJkug5LGqaHduiwrQyQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768178; c=relaxed/simple;
	bh=YjEkptkkjUucN7xS1M9k9TojJa6LecmCsbw/OO3hswo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWQE93Jwgv1oFjC26GzSD2OxEUDegRD1o53SvdCEEOzlN+Csk95ks8lnRDWKqbGOYjvrhRXdhUROyKtc7fRhPaDiqkYJVUDbqE9+FcB8J8sigGovLzkSilRRM8b2sNW/Nrcd8UDD/VJvOOoTaJ85sDPSUdfWAIcL/ImJbi599rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXHzpm6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXHzpm6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BFA1F000E9;
	Mon,  3 Aug 2026 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768177;
	bh=8NjXoA9GQkX96CvZjFUHkqjbXY29+/71VYBPqzvTc1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXHzpm6HXTzihvojHbQPerVlSMds4SS+IIHVpWnxJj6n1JMvLVLQ+PPWXb0rgHhF1
	 iFSWtQWQFDDbhupDplAViZ4CRDaEGy5IgKZrHci9RCimxh6Cix+WZFO9meDj+rAD0b
	 dN8elbzLrN2joyTd6C9qOFn9/Pqkp3KRxFBZKTnWsQyiCwA/Fxw+uQzKfRO3Zp5NMO
	 jAtKmRTXr1E8N6qqiagpSKaPX397MjJ6izkxy5+k14gCKqe+qlTqJy4/jdNTgT/2GS
	 6+v/sHOu4o1IN9QgUH8bGi9RslrknyiDmdtPjhXmpnz+ddtixiFb6Xk/2mqBsB3n3r
	 Wb69/7L7nSqFQ==
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
Subject: [PATCH 15/39] spi: qcom-geni: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:39 +0800
Message-ID: <20260803142003.12857-16-jszhang@kernel.org>
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
 drivers/spi/spi-geni-qcom.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 26e723cfea61..3b055d087b55 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1150,7 +1150,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	return devm_spi_register_controller(dev, spi);
 }
 
-static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
+static int spi_geni_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
@@ -1166,7 +1166,7 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	return geni_icc_disable(&mas->se);
 }
 
-static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
+static int spi_geni_runtime_resume(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
@@ -1183,7 +1183,7 @@ static int __maybe_unused spi_geni_runtime_resume(struct device *dev)
 	return dev_pm_opp_set_rate(mas->dev, mas->cur_sclk_hz);
 }
 
-static int __maybe_unused spi_geni_suspend(struct device *dev)
+static int spi_geni_suspend(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	int ret;
@@ -1199,7 +1199,7 @@ static int __maybe_unused spi_geni_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused spi_geni_resume(struct device *dev)
+static int spi_geni_resume(struct device *dev)
 {
 	struct spi_controller *spi = dev_get_drvdata(dev);
 	int ret;
@@ -1216,9 +1216,8 @@ static int __maybe_unused spi_geni_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops spi_geni_pm_ops = {
-	SET_RUNTIME_PM_OPS(spi_geni_runtime_suspend,
-					spi_geni_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, spi_geni_resume)
+	RUNTIME_PM_OPS(spi_geni_runtime_suspend, spi_geni_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(spi_geni_suspend, spi_geni_resume)
 };
 
 static const struct of_device_id spi_geni_dt_match[] = {
@@ -1231,7 +1230,7 @@ static struct platform_driver spi_geni_driver = {
 	.probe  = spi_geni_probe,
 	.driver = {
 		.name = "geni_spi",
-		.pm = &spi_geni_pm_ops,
+		.pm = pm_ptr(&spi_geni_pm_ops),
 		.of_match_table = spi_geni_dt_match,
 	},
 };
-- 
2.53.0

