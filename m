Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E58415F08;
	Mon,  3 Aug 2026 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768254; cv=none; b=pbmel/1eNj43uIlQq/4ZllulIwUL+IEWYgxRBFcnv/O4nZnN7E6SjITIh3IqZQhs4RZ6oBIlvTu2BHoSHZUb4JafAOQHhiVY9K50f0tpwWzqqAWMuKbMkpuUoLpNiKQc95f095A3y50js2W8ao2D4gyz+nH5lh4hUMw9mWUFM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768254; c=relaxed/simple;
	bh=DunFNjHwf3icjYe5ZHlztX4j2oXJeKJ129eE46vw5/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUTAO/EYdmMG/11SlaSpIO9XHbeyt0ZtzZD0fIWjQ36gJVOJbGcyJ4Myi6zx5f7qTUI+qI9JR3blsvd6hq11XiM3Kn+6TQc4QSEOf/oZZmo94H+O1oKfdIvLArl230qFCkVft3Jq/S86beQ5cpLY7GLMShYDv6QY1t6loF2vBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrYZUQoq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrYZUQoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CBD1F00A3A;
	Mon,  3 Aug 2026 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768252;
	bh=0Wy9JOaeFGBeAJk92ZmHHFd5ZfCYJpWQRTgBXTS91c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OrYZUQoq0laq8B7dUK0dQO+htHpXQwZrGnduhQUnF9/U6evzdxDerO+bgxkoMHVVQ
	 x4oxojMN+2ehH0hWDWAzt5DZErNKnTLZjlckqMo+JDlvFmhGRs8RUYVxm2TqWOZ05C
	 /qnkRdlRhPXHlIB0Xd55ML6EhGbO1+4GP6MNMEjqJ1G8V1zM6JbOjgU1minK09vy1t
	 U69m6JMKdko8At1EYn16xcgcgS607UBhE1xBIepZU0ma4h+zSfAPnCVmhAvGIMfhDO
	 mSegpMW2pEmO/Jv7Jiq23zw6Q3sqUMa1hHFpgi3z50FaZsGN6Mogty05BM6UKRvFmX
	 vaTVmnq9UmkhQ==
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
Subject: [PATCH 21/39] spi: mxic: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:45 +0800
Message-ID: <20260803142003.12857-22-jszhang@kernel.org>
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
 drivers/spi/spi-mxic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 83b688e65284..e3c85e5191e3 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -721,7 +721,7 @@ static int mxic_spi_mem_ecc_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
+static int mxic_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_controller_get_devdata(host);
@@ -732,7 +732,7 @@ static int __maybe_unused mxic_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
+static int mxic_spi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct mxic_spi *mxic = spi_controller_get_devdata(host);
@@ -748,8 +748,7 @@ static int __maybe_unused mxic_spi_runtime_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mxic_spi_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(mxic_spi_runtime_suspend,
-			   mxic_spi_runtime_resume, NULL)
+	RUNTIME_PM_OPS(mxic_spi_runtime_suspend, mxic_spi_runtime_resume, NULL)
 };
 
 static int mxic_spi_probe(struct platform_device *pdev)
@@ -850,7 +849,7 @@ static struct platform_driver mxic_spi_driver = {
 	.driver = {
 		.name = "mxic-spi",
 		.of_match_table = mxic_spi_of_ids,
-		.pm = &mxic_spi_dev_pm_ops,
+		.pm = pm_ptr(&mxic_spi_dev_pm_ops),
 	},
 };
 module_platform_driver(mxic_spi_driver);
-- 
2.53.0

