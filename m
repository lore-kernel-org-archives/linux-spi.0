From: Maksims Matjakubovs <maksims.matjakubovs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Allwinner SPI sun6i : add dual mode support.
Date: Tue, 27 Mar 2018 19:11:02 +0300
Message-ID: <1522167062-4079-1-git-send-email-maksims.matjakubovs@gmail.com>
Reply-To: maksims.matjakubovs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org,
	wens-jdAy2FN1RRM@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	Maksims Matjakubovs <maksims.matjakubovs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-sunxi+bncBCD6TL67ZQFBBKG25HKQKGQEYJVTTWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Added Dual mode half duplex Rx and Tx support to Allwinner sun6i/sun8i SPI driver.
Main changes is related to SUN6I_BURST_CTL_CNT_REG register.
SPI transmit is in Dual mode if STC (Master Single Mode Transmit Counter) is 0 and DRM (Master Dual Mode RX Enable) is not set.
SPI receive is in Dual mode if DRM (Master Dual Mode RX Enable) is set.
Tested on Allwinner V3s (sun8i) CPU.

Signed-off-by: Maksims Matjakubovs <maksims.matjakubovs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sun6i.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 8533f4e..2da52ed 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -84,6 +84,7 @@
 
 #define SUN6I_BURST_CTL_CNT_REG		0x38
 #define SUN6I_BURST_CTL_CNT_STC(cnt)		((cnt) & SUN6I_MAX_XFER_SIZE)
+#define SUN6I_BURST_CTL_CNT_DRM		BIT(28)
 
 #define SUN6I_TXDATA_REG		0x200
 #define SUN6I_RXDATA_REG		0x300
@@ -312,6 +313,8 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_write(sspi, SUN6I_BURST_CNT_REG, SUN6I_BURST_CNT(tfr->len));
 	sun6i_spi_write(sspi, SUN6I_XMIT_CNT_REG, SUN6I_XMIT_CNT(tx_len));
 	sun6i_spi_write(sspi, SUN6I_BURST_CTL_CNT_REG,
+			(tfr->tx_nbits == SPI_NBITS_DUAL) ? 0 :
+			(tfr->rx_nbits == SPI_NBITS_DUAL) ? SUN6I_BURST_CTL_CNT_DRM :
 			SUN6I_BURST_CTL_CNT_STC(tx_len));
 
 	/* Fill the TX FIFO */
@@ -480,7 +483,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	master->set_cs = sun6i_spi_set_cs;
 	master->transfer_one = sun6i_spi_transfer_one;
 	master->num_chipselect = 4;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+				SPI_RX_DUAL | SPI_TX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
-- 
2.7.4
