From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: sun4i: Prevent chip-select from being
 activated twice before a transfer
Date: Tue,  5 Jan 2016 21:46:20 +0100
Message-ID: <1452026780-8819-1-git-send-email-mweseloh42@gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Return-path: <linux-sunxi+bncBDFO74UEV4IRBKWXWC2AKGQELZGD7KA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

The SPI core calls set_cs before a transfer, but the SUN4I_CTL_CS_MANUAL
flag is only set in transfer_one. This leads to the following pattern on
the chip-select line (with runtime power-management on every transfer,
without it only on the first one):

activate, deactivate, activate, transfer, deactivate

Moving the configuration of the SUN4I_CTL_CS_MANUAL flag from transfer_one
to set_cs removes the double activation.

Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---

Changes from v1:
- Added Maximes Acked-by

---

 drivers/spi/spi-sun4i.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d..a6d936c 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -140,6 +140,9 @@ static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 	reg &= ~SUN4I_CTL_CS_MASK;
 	reg |= SUN4I_CTL_CS(spi->chip_select);
 
+	/* We want to control the chip select manually */
+	reg |= SUN4I_CTL_CS_MANUAL;
+
 	if (enable)
 		reg |= SUN4I_CTL_CS_LEVEL;
 	else
@@ -222,9 +225,6 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	else
 		reg |= SUN4I_CTL_DHB;
 
-	/* We want to control the chip select manually */
-	reg |= SUN4I_CTL_CS_MANUAL;
-
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
-- 
1.9.1
