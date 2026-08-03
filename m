Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79354305680;
	Mon,  3 Aug 2026 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768031; cv=none; b=ov06QFbPjlNaAtLm13V+Gb/aiUqDSywooUdpGmLTvRmENzA8QDbzcvivPtoJkCrXC9TkVxRk6PQCD23s88h3e8WFQdhdg4Rk96/jCPWGZlhGFitz8hbFk2YqX9uBDvO08xmFNV1n+EX02Vv+0vltSMgLU3K8D0fI9pKCNORTAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768031; c=relaxed/simple;
	bh=FRMTeOORCNHJa+B3xULuyOtxsobQDwoma4CE7UPW16o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9JTJazBTFxgxgPypINBVYuA8rdiSd84xWp+q8f1QdAQxfwewMBNrj8YkdOXvX5ejZENR0tdQhSaT72saHntNbiyGD7+WxnzQGmuiU4ITE0lJtOJfkGkrUblhQ0yR5DHGZQWhbNjLzMwBtZdexXkW3dc4cs746dxmB0pM1E6OsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh6FaZZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh6FaZZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0481F00A3D;
	Mon,  3 Aug 2026 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768030;
	bh=bipLPRMz6JcFCwPqw3LLEk55cURIlQcQ9jExHCqAyWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fh6FaZZYr+oCLPA/RJwYvBZ22dX0wnTAK7oK9cJMnwrgAq9ck6bbORM/RE94u44ZP
	 XYhMZaOEIIyIEOKroZT8Yz/oFjyGNGvJXeGcTSwzloAKIiCBkg6qcVk/eS8YlNMJv1
	 IrCqJQdfKW1/uvhKqXabS/LCmuNQAuKCf8OHXKfMy+4vUGHHmOnt81Z+shapvFcCeS
	 7i8B9I9LFgCNqXdX0PwHf4m5JRtlgL+tAqSVvbCI1hWsauZRuUjiB7ONpS/WEeftzp
	 IZ5qf3WM6X+e8d4VN8XZOhmOdR3ufNjmSzHs30rqMBvMrBdr7JKUTUMyQButJmmHjh
	 DRa10br+6pgRg==
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
Subject: [PATCH 03/39] spi: at91-usart: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:27 +0800
Message-ID: <20260803142003.12857-4-jszhang@kernel.org>
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
 drivers/spi/spi-at91-usart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 77cad4118202..804f6194c830 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -571,7 +571,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-__maybe_unused static int at91_usart_spi_suspend(struct device *dev)
+static int at91_usart_spi_suspend(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
@@ -587,7 +587,7 @@ __maybe_unused static int at91_usart_spi_suspend(struct device *dev)
 	return 0;
 }
 
-__maybe_unused static int at91_usart_spi_resume(struct device *dev)
+static int at91_usart_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctrl = dev_get_drvdata(dev);
 	struct at91_usart_spi *aus = spi_controller_get_devdata(ctrl);
@@ -616,13 +616,13 @@ static void at91_usart_spi_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops at91_usart_spi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(at91_usart_spi_suspend, at91_usart_spi_resume)
+	SYSTEM_SLEEP_PM_OPS(at91_usart_spi_suspend, at91_usart_spi_resume)
 };
 
 static struct platform_driver at91_usart_spi_driver = {
 	.driver = {
 		.name = "at91_usart_spi",
-		.pm = &at91_usart_spi_pm_ops,
+		.pm = pm_sleep_ptr(&at91_usart_spi_pm_ops),
 	},
 	.probe = at91_usart_spi_probe,
 	.remove = at91_usart_spi_remove,
-- 
2.53.0

