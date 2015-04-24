From: Alban Bedel <albeu@free.fr>
Subject: [PATCH 3/4] spi: spi-ath79: Use clk_prepare_enable and clk_disable_unprepare
Date: Fri, 24 Apr 2015 16:19:23 +0200
Message-ID: <1429885164-28501-4-git-send-email-albeu@free.fr>
References: <1429885164-28501-1-git-send-email-albeu@free.fr>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Mark Brown <broonie@kernel.org>, Alban Bedel <albeu@free.fr>,
	Gabor Juhos <juhosg@openwrt.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429885164-28501-1-git-send-email-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Clocks should be prepared and unprepared, fix this by using
clk_prepare_enable() and clk_disable_unprepare() instead of
clk_enable() and clk_disable().

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/spi/spi-ath79.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 239bc31..b37bedd 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -249,7 +249,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
-	ret = clk_enable(sp->clk);
+	ret = clk_prepare_enable(sp->clk);
 	if (ret)
 		goto err_put_master;
 
@@ -273,7 +273,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 err_disable:
 	ath79_spi_disable(sp);
 err_clk_disable:
-	clk_disable(sp->clk);
+	clk_disable_unprepare(sp->clk);
 err_put_master:
 	spi_master_put(sp->bitbang.master);
 
@@ -286,7 +286,7 @@ static int ath79_spi_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&sp->bitbang);
 	ath79_spi_disable(sp);
-	clk_disable(sp->clk);
+	clk_disable_unprepare(sp->clk);
 	spi_master_put(sp->bitbang.master);
 
 	return 0;
-- 
2.0.0
