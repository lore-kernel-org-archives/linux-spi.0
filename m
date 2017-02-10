From: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Add Master Sample Data Mode for SPI
Date: Fri, 10 Feb 2017 19:02:47 -0300
Message-ID: <20170210220247.8478-1-viniciusfre@gmail.com>
Reply-To: viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
	wens-jdAy2FN1RRM@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDNJJSMB6QFRBEHR7DCAKGQEUS3KNPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

In order to work appropriately, the max11043 ADC chip and probably
others, needs SPI master samples the data at the correct edge. From
max11043 datasheet: "The data at DIN is latched on the rising edge
of SCLK". Same to DOUT.

This patch add Master Sample Data Mode bit in normal sample mode.

Signed-off-by: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sun4i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index c5cd635c28f3..6325be2ce8d9 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -44,6 +44,7 @@
 #define SUN4I_CTL_CS_MANUAL			BIT(16)
 #define SUN4I_CTL_CS_LEVEL			BIT(17)
 #define SUN4I_CTL_TP				BIT(18)
+#define SUN4I_CTL_SDM				BIT(20)
 
 #define SUN4I_INT_CTL_REG		0x0c
 #define SUN4I_INT_CTL_RF_F34			BIT(4)
@@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP |
+			SUN4I_CTL_SDM);
 
 	return 0;
 
-- 
2.11.0
