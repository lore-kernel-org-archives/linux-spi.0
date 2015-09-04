From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
Date: Fri,  4 Sep 2015 11:05:40 +0300
Message-ID: <1441353940-9262-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Russell King <linux@arm.linux.org.uk>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
build error here because it removed the type LPSS_SSP and I didn't notice
the type was used here too.

I believe commit a6e56c28a178 ("ARM: pxa: ssp: add DT bindings") added it
accidentally by copying all enum pxa_ssp_type types from
include/linux/pxa2xx_ssp.h even LPSS_SSP was for Intel LPSS SPI devices.

Fix the build error by removing this incorrect binding.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reported-by: Axel Lin <axel.lin@ingics.com>
Cc: <stable@vger.kernel.org> # 4.2
---
Sorry if you got this multiple times day before yesterday. I had problems
with two addresses bouncing back without any obvious errors in the
git send-email command or those failing addresses and linux-spi archive
didn't show the patch either.

I'm surrounding now the stable@vger.kernel.org by angled brackets because I
think that was the problem here as the "# 4.2" got added into address.
---
 arch/arm/plat-pxa/ssp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index ad9529cc4203..daa1a65f2eb7 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -107,7 +107,6 @@ static const struct of_device_id pxa_ssp_of_ids[] = {
 	{ .compatible = "mvrl,pxa168-ssp",	.data = (void *) PXA168_SSP },
 	{ .compatible = "mrvl,pxa910-ssp",	.data = (void *) PXA910_SSP },
 	{ .compatible = "mrvl,ce4100-ssp",	.data = (void *) CE4100_SSP },
-	{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pxa_ssp_of_ids);
-- 
2.5.1
