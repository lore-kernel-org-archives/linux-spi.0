Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A573126C0;
	Mon,  3 Aug 2026 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768003; cv=none; b=NqMyGA2NNZTVBkG0s7LAw49JBTki+/hvXKga7Hkorv0gWDPKXWPrKl1H3i63Ab1PTDWLUQAKkmiYAPtGEL7D5hlVGcj57jF85tyo8xzeEMG13VZkYSrJQ0IzO1NgQ5Fi0SFWDq/CferH/qmXY9tDc1aPaHRfrOm+99EDkzO+WEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768003; c=relaxed/simple;
	bh=ol4uKXH7i4gu7VakjvIyR8hDTyorvMn2IbbT8yyJUqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0bAYR6StC6KDdkIqibjF0UTqEz8MYMgyVfidC6nENJn+pPCq75e8cR/bGrjeVydnLyNrxr8uoQs/EGdRzkjt5yhXDgUkBSchqp4LOOIECIqyaWTkhvhslwNlQ3uVOZcIQTbsZdH2Pwoexm+AcP16TrTxSb2vMEDGMyy93ZlrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJlGoIju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJlGoIju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136581F00A3A;
	Mon,  3 Aug 2026 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768002;
	bh=drBHcizTpLHwnjvGDS/+4JRuC2WyW4AxibKwlSKT+iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJlGoIjugiKqIfZy5lUV1psVwBjW5oXgyGaJuIJ1lkUGP4mTGYkahbca/cvsrUwdy
	 l9QOGdgQ6bPS8GjaLz7vWL7XiSWgTc2A0rJffFI1uKGKe2j+iGCaR+HW5u/19FIo10
	 CVmAD/9gGJe2izBWGDxuwivNWtk7TxU+0HLJKeClIEu9nABO1rIxFX//Q+28Fs1LZ7
	 XO4IBCEtubgTGgLS4Y16s9hoOitgwzFm7a5BPlvEO85Bsi6gjOOiaeB5uLMa0ghi06
	 mGvl89B9qza6V1HRxo2vM52oYsdr819Z9p9gZo7X3ZR++/oKdJB60fXVogs9nmV5HA
	 92mUwzbFjf2ug==
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
Subject: [PATCH 01/39] spi: atmel-quadspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:25 +0800
Message-ID: <20260803142003.12857-2-jszhang@kernel.org>
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
 drivers/spi/atmel-quadspi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index aaf7f4c46b22..28b6cfcaf34c 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1527,7 +1527,7 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 	}
 }
 
-static int __maybe_unused atmel_qspi_suspend(struct device *dev)
+static int atmel_qspi_suspend(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
@@ -1554,7 +1554,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused atmel_qspi_resume(struct device *dev)
+static int atmel_qspi_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
@@ -1586,7 +1586,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused atmel_qspi_runtime_suspend(struct device *dev)
+static int atmel_qspi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
@@ -1597,7 +1597,7 @@ static int __maybe_unused atmel_qspi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused atmel_qspi_runtime_resume(struct device *dev)
+static int atmel_qspi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
@@ -1614,10 +1614,10 @@ static int __maybe_unused atmel_qspi_runtime_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops __maybe_unused atmel_qspi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(atmel_qspi_suspend, atmel_qspi_resume)
-	SET_RUNTIME_PM_OPS(atmel_qspi_runtime_suspend,
-			   atmel_qspi_runtime_resume, NULL)
+static const struct dev_pm_ops atmel_qspi_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(atmel_qspi_suspend, atmel_qspi_resume)
+	RUNTIME_PM_OPS(atmel_qspi_runtime_suspend,
+		       atmel_qspi_runtime_resume, NULL)
 };
 
 static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {};
-- 
2.53.0

