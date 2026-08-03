Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36EF3126C0;
	Mon,  3 Aug 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768168; cv=none; b=Ye6SJe7iaafY5i0UZ+MlgWLPPkBXr9lp92Fly9ulVyVxBJxeGK0b+DAVO0aCj+1SBv1LEwCUwfl9sCrilbUCac/xCUmWqyjAa2i5cWTa3OLQWktMh+1l4MCNXmQReHEPPZJYv/QisNW8KugS/Fqqm8NajiODvRsaANXZQ/BvBxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768168; c=relaxed/simple;
	bh=cIObQkN3i8E7FNYuQ1EXWCTa23k7x49O2WzfO1Nwtjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTq/Rq58W/gkrguPsyvtT3oJWiVjNhA68gNlS2nVJfssis52/OUWih/SuI5tWcIZhxwxiklRFaYQBaP11G0MfhKjptsK7RLzLW2xPz6sfXlG68VPA3ddjghH+3Odrbttw/0TPS/DKx2RsmFKfNH02uhj84ja5Ws4WF71dYWfkms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq0SzQuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq0SzQuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A589F1F00A3A;
	Mon,  3 Aug 2026 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768166;
	bh=mu04nVcHEVGTHqVvLbmhVSQzsCdFINUhaQSAgnCXqz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jq0SzQuCKBUhLxcWGUxwGft/o2OElSpoXRZRXR5jPNRm2yedF5jG171F8u160+piV
	 UludJvSE1p6LTZkWNzEW+L5sOXZbb9S0s06zMY2HGUYUqvriUb6zLIylRjYZ66jitu
	 zPhbZBW62udEUl3MN1fFYwSbhRmiGV8kNP7qYYlfZk9ucSY5GE1jJKC16rDDctQ1J6
	 wEwpyeRDu1YA1cHZWZdzFofBUNFXP/Ce8dIBtY4kcj10qnAjO3y6eaF9GRsG3TFtzV
	 m+d5L6W/aTUn8ejSvS3Snclm3kfH6IrOSYzg47cPEWI8iiM4+OSNrs2wHKKy6oB51C
	 bA2q3zXjUjhbQ==
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
Subject: [PATCH 14/39] spi: fsl-lpspi: use modern PM macros
Date: Mon,  3 Aug 2026 22:19:38 +0800
Message-ID: <20260803142003.12857-15-jszhang@kernel.org>
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
 drivers/spi/spi-fsl-lpspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index e14753144e19..5aa0a75b4e57 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -842,7 +842,6 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-#ifdef CONFIG_PM
 static int fsl_lpspi_runtime_resume(struct device *dev)
 {
 	struct spi_controller *controller = dev_get_drvdata(dev);
@@ -876,7 +875,6 @@ static int fsl_lpspi_runtime_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
 {
@@ -1056,8 +1054,8 @@ static int fsl_lpspi_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops fsl_lpspi_pm_ops = {
-	SET_RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
-				fsl_lpspi_runtime_resume, NULL)
+	RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
+		       fsl_lpspi_runtime_resume, NULL)
 	SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
 };
 
-- 
2.53.0

