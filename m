From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH spi] spi: mediatek: mtk_spi_driver can be static
Date: Fri, 7 Aug 2015 22:33:11 +0800
Message-ID: <20150807143311.GA44461@lkp-nex05>
References: <201508072245.3TStW9QR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201508072245.3TStW9QR%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 spi-mt65xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 4676b01..e62d304 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -731,7 +731,7 @@ static const struct dev_pm_ops mtk_spi_pm = {
 			   mtk_spi_runtime_resume, NULL)
 };
 
-struct platform_driver mtk_spi_driver = {
+static struct platform_driver mtk_spi_driver = {
 	.driver = {
 		.name = "mtk-spi",
 		.pm	= &mtk_spi_pm,
