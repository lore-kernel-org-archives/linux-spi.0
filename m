Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313A741D12C;
	Mon,  3 Aug 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768470; cv=none; b=oIxTcEK0iyRbIafTcRxa/EHzkoMXPoNTFQYINOd083QIBxhOaLG3XxXdNBnje+ytdMxa/OMvFShnnbkUkj8Ytuq5nV/7PSMFPH60T2MzR8zAuDt0p9IPILWUjQZj0CLhboH+s4EAvvX8SQ86PiBWlempfP7f14ewYhKTxX0F5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768470; c=relaxed/simple;
	bh=th+gSz3ZfFcXLd9CAONrz47oXizCQjZk1hkgHWndUZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCcHYNjXKg22HBD4Gb7flZ/JJ6+U4JjJLN36L/+Ddu8VXJCggEZBLopjIxR0ju0QykGfYOXqUMCT8ZcPk8v+c5Va/AgPHQnHV7zy2K6su0Ris+4n+RwlMcpwaHL679CK4ub4Yp1vaqmE28PtgFWoNrlltKQnedgt2fM2A50ilvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmUJmptS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmUJmptS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1054D1F00A3A;
	Mon,  3 Aug 2026 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768468;
	bh=zkX/3dzt/quj43edlafhWH61EJ/HhtjA4rsT3qwwG8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmUJmptS05vLn302+g04AnpaBKS1dxJatne2B4RJkuqR28nUNl9c2VT6adbYuCDIL
	 EbIUB1yOAsI00pp47UXjpfecaATFregOwoEEoGFwMcPp7PJjvvq7Iki6pkJ2rBDfSb
	 +xKPYQ0A7aNBZGvH7slyomm7ypFAt01TqOTg1DCwh7vI1zkg2+Wz4lHOCqfca2OPu7
	 SardyHykGd/CC81EtpwAV+AEZzod12rvuexV4PiQe3bUX4qWRtRPlTJBlaS8dC83WY
	 lrcoebiUiuvdU81Gk8fbYHqeMDhc41S3MO+3XTfkHWOT+PGohbVu+wxEm18yWNpHyv
	 daTLK4vBWaTFQ==
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
Subject: [PATCH 39/39] spi: zynqmp-gqspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:20:03 +0800
Message-ID: <20260803142003.12857-40-jszhang@kernel.org>
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
 drivers/spi/spi-zynqmp-gqspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index f9a1427dabad..4d55090fa443 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -935,7 +935,7 @@ static int zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8 rx_nbits,
  *
  * Return:	Always 0
  */
-static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
+static int zynqmp_qspi_suspend(struct device *dev)
 {
 	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
 	struct spi_controller *ctlr = xqspi->ctlr;
@@ -959,7 +959,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
  *
  * Return:	0 on success; error value otherwise
  */
-static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
+static int zynqmp_qspi_resume(struct device *dev)
 {
 	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
 	struct spi_controller *ctlr = xqspi->ctlr;
@@ -979,7 +979,7 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
  *
  * Return:	Always 0
  */
-static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
+static int zynqmp_runtime_suspend(struct device *dev)
 {
 	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
 
@@ -997,7 +997,7 @@ static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
+static int zynqmp_runtime_resume(struct device *dev)
 {
 	struct zynqmp_qspi *xqspi = dev_get_drvdata(dev);
 	int ret;
@@ -1186,9 +1186,8 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 }
 
 static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(zynqmp_runtime_suspend,
-			   zynqmp_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
+	RUNTIME_PM_OPS(zynqmp_runtime_suspend, zynqmp_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
 };
 
 static const struct qspi_platform_data versal_qspi_def = {
@@ -1382,7 +1381,7 @@ static struct platform_driver zynqmp_qspi_driver = {
 	.driver = {
 		.name = "zynqmp-qspi",
 		.of_match_table = zynqmp_qspi_of_match,
-		.pm = &zynqmp_qspi_dev_pm_ops,
+		.pm = pm_ptr(&zynqmp_qspi_dev_pm_ops),
 	},
 };
 
-- 
2.53.0

