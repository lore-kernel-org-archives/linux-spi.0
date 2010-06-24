From: <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable
 chan between each SPI transfer
Date: Thu, 24 Jun 2010 16:32:14 +0200
Message-ID: <E1C7579D1379824DAE67858071C810382DD83846FB@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	<david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1277381565-6305-1-git-send-email-jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

 

>-----Original Message-----
>From: ext Jason Wang [mailto:jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] 
>Sent: 24 June, 2010 15:13
>To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org; Tereshonkov Roman 
>(Nokia-D/Helsinki); david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
>Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; 
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>Subject: [PATCH] spi/omap2_mcspi: disable and enable chan 
>between each SPI transfer
>
>In current design, the SPI channel is always enable during the period
>of handling a SPI message, it is risky when more than one SPI transfer
>are included in a message. Current working route like that:
>[
>  SPI channel enable
>  configure channel
>  handle transfer #1
>  configure channel
>  handle transfer #2
>  ...
>  SPI channel disable
>]
>If we can disable channel before configure it and reenable
>channel after it is configured, it will be more safe.
>
>The commit a330ce2 "omap2_mcspi: Flush posted writes" make this risk
>to a real problem for ads7846 driver on omap3530evm. The
>ads7846 driver will send a SPI messge which includes,
>[
>  TX_ONLY transfer (1 byte)
>  RX_ONLY transfer (2 bytes)
>  TX_ONLY transfer (1 byte)
>  RX_ONLY transfer (2 bytes)
>]
>If we don't add disable/reenable channel between TX and RX transfers,
>the RX transfer will get wrong datas sent from slave.
>
>Signed-off-by: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> drivers/spi/omap2_mcspi.c |   16 ++++++----------
> 1 files changed, 6 insertions(+), 10 deletions(-)
>
>diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
>index b3a94ca..1e3cb7b 100644
>--- a/drivers/spi/omap2_mcspi.c
>+++ b/drivers/spi/omap2_mcspi.c
>@@ -408,7 +408,6 @@ omap2_mcspi_txrx_dma(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 				count -= (word_len <= 8)  ? 2 :
> 					(word_len <= 16) ? 4 :
> 					/* word_len <= 32 */ 8;
>-				omap2_mcspi_set_enable(spi, 1);
> 				return count;
> 			}
> 		}
>@@ -430,8 +429,10 @@ omap2_mcspi_txrx_dma(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 				 (word_len <= 16) ? 2 :
> 			       /* word_len <= 32 */ 4;
> 		}
>-		omap2_mcspi_set_enable(spi, 1);
> 	}
>+
>+	omap2_mcspi_set_enable(spi, 0);
>+
> 	return count;
> }
> 
>@@ -517,8 +518,6 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 						goto out;
> 					}
> 					c = 0;
>-				} else if (c == 0 && tx == NULL) {
>-					omap2_mcspi_set_enable(spi, 0);
> 				}
> 
> 				*rx++ = __raw_readl(rx_reg);
>@@ -570,8 +569,6 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 						goto out;
> 					}
> 					c = 0;
>-				} else if (c == 0 && tx == NULL) {
>-					omap2_mcspi_set_enable(spi, 0);
> 				}
> 
> 				*rx++ = __raw_readl(rx_reg);
>@@ -623,8 +620,6 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 						goto out;
> 					}
> 					c = 0;
>-				} else if (c == 0 && tx == NULL) {
>-					omap2_mcspi_set_enable(spi, 0);
> 				}
> 
> 				*rx++ = __raw_readl(rx_reg);

Why do you do this?
Reading the last word from the shift register buffer leads to 
the receiving new data to the buffer.
The channel needs to be disabled before the last word reading.



>@@ -646,7 +641,7 @@ omap2_mcspi_txrx_pio(struct spi_device 
>*spi, struct spi_transfer *xfer)
> 			dev_err(&spi->dev, "EOT timed out\n");
> 	}
> out:
>-	omap2_mcspi_set_enable(spi, 1);
>+	omap2_mcspi_set_enable(spi, 0);
> 	return count - c;
> }
> 
>@@ -894,7 +889,6 @@ static void omap2_mcspi_work(struct 
>work_struct *work)
> 		cs = spi->controller_state;
> 		cd = spi->controller_data;
> 
>-		omap2_mcspi_set_enable(spi, 1);
> 		list_for_each_entry(t, &m->transfers, transfer_list) {
> 			if (t->tx_buf == NULL && t->rx_buf == 
>NULL && t->len) {
> 				status = -EINVAL;
>@@ -931,6 +925,8 @@ static void omap2_mcspi_work(struct 
>work_struct *work)
> 
> 			mcspi_write_chconf0(spi, chconf);
> 
>+			omap2_mcspi_set_enable(spi, 1);
>+
> 			if (t->len) {
> 				unsigned	count;
> 
>-- 
>1.5.6.5
>
>
------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
