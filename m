From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: [PATCH] spi-imx: imx6q add single burst transfer support
Date: Wed,  1 Jun 2016 12:50:28 +0800
Message-ID: <1464756628-25463-1-git-send-email-chris.ruehl@gtsys.com.hk>
Cc: festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch add support for single burst transfer where chipselect will
hold active until transfer completes with a limit to 2^7 words transferred.
The single-burst-mode need set the burstlength in ECSPI_CONREG.BURST_LENGTH
and clear the ecspi channel related ss_ctl flag in ECSPI_CONFIGREG.SS_CTL.

The single-burst-mode is disabled by default. The activation from spidev
is implemented by set bit0 of the xfer.speed_hz, which don't break anything
in the mx51_ecspi_clkdiv() function.

xfer[0].speed_hz = 2000000 | 0x1; /* enable single burst mode with 1hz */

There is a bug in the SDMA firmware (referenced as TKT238285 or ERR008517)
which breaks the transmission with a odd numbers of bytes.
Its turns out, that its safe to use with slaves in half duplex mode where
always an even number of bytes is required.

function added:
spi_imx_buf_tx_sb()  - singleburst transmit
spi_imx_buf_rx_sb()  - singleburst receive

stucts modified:
spi_imx_config - add len ; add single_burst_mode:1
spi_imx_data   - add rxcount; add bits_per_word

Signed-off-by: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
---
 drivers/spi/spi-imx.c | 233 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 50769078..15708eb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -60,6 +60,8 @@ struct spi_imx_config {
 	unsigned int speed_hz;
 	unsigned int bpw;
 	unsigned int mode;
+	unsigned int len;
+	unsigned int single_burst_mode:1;
 	u8 cs;
 };
 
@@ -99,11 +101,13 @@ struct spi_imx_data {
 	unsigned int bytes_per_word;
 
 	unsigned int count;
+	unsigned int rxcount;
 	void (*tx)(struct spi_imx_data *);
 	void (*rx)(struct spi_imx_data *);
 	void *rx_buf;
 	const void *tx_buf;
 	unsigned int txfifo; /* number of words pushed in tx FIFO */
+	u8 bits_per_word;
 
 	/* DMA */
 	bool usedma;
@@ -168,6 +172,188 @@ MXC_SPI_BUF_TX(u16)
 MXC_SPI_BUF_RX(u32)
 MXC_SPI_BUF_TX(u32)
 
+static void spi_imx_buf_rx_sb(struct spi_imx_data *spi_imx)
+{
+	unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
+
+	dev_dbg(spi_imx->dev, "%s: rxcount: %u val:0x%08x\n",
+		__func__, spi_imx->rxcount, val);
+
+	if (spi_imx->rxcount >= 4) {
+		if (spi_imx->rx_buf) {
+			if (spi_imx->bits_per_word == 32) {
+				spi_imx_buf_rx_u32(spi_imx);
+			} else if (spi_imx->bits_per_word == 16) {
+				*(u16 *)spi_imx->rx_buf = (val>>16);
+				spi_imx->rx_buf += sizeof(u16);
+				*(u16 *)spi_imx->rx_buf = val;
+				spi_imx->rx_buf += sizeof(u16);
+			} else {
+				*(u8 *)spi_imx->rx_buf = (val>>24);
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = (val>>16);
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = (val>>8);
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = val;
+				spi_imx->rx_buf += sizeof(u8);
+			}
+		}
+		spi_imx->rxcount -= 4;
+	} else if (spi_imx->rxcount == 3) {
+		if (spi_imx->rx_buf) {
+			if (spi_imx->bits_per_word == 32) {
+				*(u8 *)spi_imx->rx_buf = val>>24;
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = val>>16;
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = val>>8;
+				spi_imx->rx_buf += sizeof(u8);
+			} else if (spi_imx->bits_per_word == 16) {
+				*(u16 *)spi_imx->rx_buf = (val>>16);
+				spi_imx->rx_buf += sizeof(u16);
+				*(u8 *)spi_imx->rx_buf = val>>8;
+				spi_imx->rx_buf += sizeof(u8);
+			} else {
+				*(u8 *)spi_imx->rx_buf = (val>>16);
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = (val>>8);
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = val;
+				spi_imx->rx_buf += sizeof(u8);
+			}
+		}
+		spi_imx->rxcount -= 3;
+	} else if (spi_imx->rxcount == 2) {
+		if (spi_imx->rx_buf) {
+			if (spi_imx->bits_per_word == 32) {
+				*(u8 *)spi_imx->rx_buf = val>>24;
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = val>>16;
+				spi_imx->rx_buf += sizeof(u8);
+			} else if (spi_imx->bits_per_word == 16) {
+				spi_imx_buf_rx_u16(spi_imx);
+			} else {
+				*(u8 *)spi_imx->rx_buf = (val>>8);
+				spi_imx->rx_buf += sizeof(u8);
+				*(u8 *)spi_imx->rx_buf = val;
+				spi_imx->rx_buf += sizeof(u8);
+			}
+		}
+		spi_imx->rxcount -= 2;
+	} else if (spi_imx->rxcount == 1) {
+		if (spi_imx->rx_buf) {
+			if (spi_imx->bits_per_word == 32)
+				*(u8 *)spi_imx->rx_buf = val>>24;
+			else if (spi_imx->bits_per_word == 16)
+				*(u8 *)spi_imx->rx_buf = val>>8;
+			else
+				spi_imx_buf_rx_u8(spi_imx);
+		}
+		spi_imx->rxcount -= 1;
+	}
+}
+
+static void spi_imx_buf_tx_sb(struct spi_imx_data *spi_imx)
+{
+	unsigned int val = 0;
+
+	dev_dbg(spi_imx->dev, "%s: txcount: %u ptr:0x%08x\n",
+		__func__, spi_imx->count, *(u32 *)spi_imx->tx_buf);
+
+	if (spi_imx->count >= 4) {
+		if (spi_imx->bits_per_word == 32) {
+			spi_imx_buf_tx_u32(spi_imx);
+		} else {
+			if (spi_imx->tx_buf) {
+				if (spi_imx->bits_per_word == 16) {
+					val = *(u16 *)spi_imx->tx_buf<<16;
+					spi_imx->tx_buf += sizeof(u16);
+					val |= *(u16 *)spi_imx->tx_buf;
+					spi_imx->tx_buf += sizeof(u16);
+				} else {
+					val = *(u8 *)spi_imx->tx_buf<<24;
+					spi_imx->tx_buf += sizeof(u8);
+					val |= *(u8 *)spi_imx->tx_buf<<16;
+					spi_imx->tx_buf += sizeof(u8);
+					val |= *(u8 *)spi_imx->tx_buf<<8;
+					spi_imx->tx_buf += sizeof(u8);
+					val |= *(u8 *)spi_imx->tx_buf;
+					spi_imx->tx_buf += sizeof(u8);
+				}
+				writel(val, spi_imx->base + MXC_CSPITXDATA);
+			}
+			spi_imx->count -= 4;
+		}
+	} else if (spi_imx->count == 3) {
+		if (spi_imx->tx_buf) {
+			if (spi_imx->bits_per_word == 32) {
+				val = *(u8 *)spi_imx->tx_buf<<24;
+				spi_imx->tx_buf += sizeof(u8);
+				val |= *(u8 *)spi_imx->tx_buf<<16;
+				spi_imx->tx_buf += sizeof(u8);
+				val |= *(u8 *)spi_imx->tx_buf<<8;
+				spi_imx->tx_buf += sizeof(u8);
+
+			} else if (spi_imx->bits_per_word == 16) {
+				val = *(u8 *)spi_imx->tx_buf<<24;
+				spi_imx->tx_buf += sizeof(u8);
+				val |= *(u8 *)spi_imx->tx_buf<<16;
+				spi_imx->tx_buf += sizeof(u8);
+				val |= *(u8 *)spi_imx->tx_buf;
+				spi_imx->tx_buf += sizeof(u8);
+
+			} else {
+				val = *(u8 *)spi_imx->tx_buf<<16;
+				spi_imx->tx_buf += sizeof(u8);
+				val |= *(u8 *)spi_imx->tx_buf<<8;
+				spi_imx->tx_buf += sizeof(u8);
+				val |= *(u8 *)spi_imx->tx_buf;
+				spi_imx->tx_buf += sizeof(u8);
+			}
+			writel(val, spi_imx->base + MXC_CSPITXDATA);
+		}
+		spi_imx->count -= 3;
+	} else if (spi_imx->count == 2) {
+		if (spi_imx->bits_per_word == 16) {
+			spi_imx_buf_tx_u16(spi_imx);
+		} else {
+			if (spi_imx->tx_buf) {
+				if (spi_imx->bits_per_word == 32) {
+					val = *(u8 *)spi_imx->tx_buf<<24;
+					spi_imx->tx_buf += sizeof(u8);
+					val |= *(u8 *)spi_imx->tx_buf<<16;
+					spi_imx->tx_buf += sizeof(u8);
+				} else {
+					val = *(u8 *)spi_imx->tx_buf<<8;
+					spi_imx->tx_buf += sizeof(u8);
+					val |= *(u8 *)spi_imx->tx_buf;
+					spi_imx->tx_buf += sizeof(u8);
+				}
+				writel(val, spi_imx->base + MXC_CSPITXDATA);
+			}
+			spi_imx->count -= 2;
+		}
+	} else if (spi_imx->count == 1) {
+		if (spi_imx->bits_per_word == 8) {
+			spi_imx_buf_tx_u8(spi_imx);
+		} else {
+			if (spi_imx->tx_buf) {
+				if (spi_imx->bits_per_word == 32) {
+					val = *(u8 *)spi_imx->tx_buf<<24;
+					spi_imx->tx_buf += sizeof(u8);
+				} else if (spi_imx->bits_per_word == 16) {
+					val = *(u8 *)spi_imx->tx_buf<<8;
+					spi_imx->tx_buf += sizeof(u8);
+				}
+				writel(val, spi_imx->base + MXC_CSPITXDATA);
+			}
+			spi_imx->count -= 1;
+		}
+	}
+}
+
+
 /* First entry is reserved, second entry is valid only if SDHC_SPIEN is set
  * (which is currently not the case in this driver)
  */
@@ -357,9 +543,49 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	/* set chip select to use */
 	ctrl |= MX51_ECSPI_CTRL_CS(config->cs);
 
-	ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+	/* set single else multible burst parameters */
+	if (config->single_burst_mode > 0) {
+		reg = 0;
+		spi_imx->rx = spi_imx_buf_rx_sb;
+		spi_imx->tx = spi_imx_buf_tx_sb;
+		spi_imx->rxcount = config->len;
+		spi_imx->bits_per_word = config->bpw;
+
+		/*
+		 * calculate the Burst Length,
+		 * refer to 21.7.3 Control Register (ECSPIx_CONREG)
+		 * for details.
+		 */
+		switch (config->len%4) {
+		case 1:
+			ctrl |= 7 << MX51_ECSPI_CTRL_BL_OFFSET;
+			reg = (config->len-1) / 4;
+			break;
+		case 2:
+			ctrl |= 15 << MX51_ECSPI_CTRL_BL_OFFSET;
+			reg = (config->len-2) / 4;
+			break;
+		case 3:
+			ctrl |= 23 << MX51_ECSPI_CTRL_BL_OFFSET;
+			reg = (config->len-3) / 4;
+			break;
+		case 0:
+			ctrl |= 31 << MX51_ECSPI_CTRL_BL_OFFSET;
+			reg = (config->len-4) / 4;
+			break;
+		}
+
+		if (reg > 0)
+			ctrl |= reg << (MX51_ECSPI_CTRL_BL_OFFSET + 5);
 
-	cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
+		cfg &= ~(MX51_ECSPI_CONFIG_SBBCTRL(config->cs));
+
+		dev_dbg(spi_imx->dev, "Single Burst reg:0x%08x cfg:0x%08x ctrl:0x%08x\n",
+			reg, cfg, ctrl);
+	} else {
+		ctrl |= (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
+	}
 
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
@@ -861,6 +1087,9 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
 	config.mode = spi->mode;
 	config.cs = spi->chip_select;
+	config.len = t->len;
+	/* using bit0 of hz to enable the single burst mode */
+	config.single_burst_mode = (config.speed_hz&0x1) > 0 ? true : false;
 
 	if (!config.speed_hz)
 		config.speed_hz = spi->max_speed_hz;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
