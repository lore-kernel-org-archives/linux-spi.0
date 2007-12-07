From: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: atmel_spi driver
Date: Fri, 7 Dec 2007 14:49:55 +0100
Message-ID: <20071207144955.54cf14e4@dhcp-252-066.norway.atmel.com>
References: <015e01c838d5$6b2b2bc0$2b00a8c0@ARV127>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Rini van Zetten" <rini-uOUtDB0q1vc@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <015e01c838d5$6b2b2bc0$2b00a8c0@ARV127>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 7 Dec 2007 14:31:04 +0100
"Rini van Zetten" <rini-uOUtDB0q1vc@public.gmane.org> wrote:

> Dear Haavard,
> 
> I think i found a bug in the atmel_spi driver which is maintained by you. Let me describe.
> 
> We have a wifi module connected to the spi bus and got sometimes FIFO overrun errors on the spi bus.
> After some investigation i found that the driver loads the TCR (transmit count) register before the RCR (receive count). When the transfer list is not empty the atmel_spi_next_message is called while tx and rx are enabled. As soon as the TCR is loaded, hardware starts transfer and causes a rx fifo overrun because the RCR is not loaded yet.
> Atached is a patch (for the 2.6.23.9 kernel) which loads the RCR before the TCR. After this patch the fifo overrun disapears at out setup.

Ah, nice catch. Thanks.

> Please review it and let me know if you need more details.

Makes sense to me. David, do you think this one should go in before
2.6.24? It may solve some of the other overrun problems people have
been seeing as well, especially those happening at low speed.

Btw, Rini, could you sign off the patch as well? Please see
Documentation/SubmittingPatches if you don't know what this means.

Haavard

===========[cut here]==============
From: Rini van Zetten <rini-uOUtDB0q1vc@public.gmane.org>
Date: Fri, 7 Dec 2007 14:41:56 +0100
Subject: [PATCH] atmel_spi: Reload RCR before TCR

We have a wifi module connected to the spi bus and got sometimes FIFO
overrun errors on the spi bus.

After some investigation i found that the driver loads the TCR
(transmit count) register before the RCR (receive count). When the
transfer list is not empty the atmel_spi_next_message is called while
tx and rx are enabled. As soon as the TCR is loaded, hardware starts
transfer and causes a rx fifo overrun because the RCR is not loaded
yet.

Below is a patch (for the 2.6.23.9 kernel) which loads the RCR
before the TCR. After this patch the fifo overrun disapears at out
setup.

Signed-off-by: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/atmel_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index ff6a14b..ff10808 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -195,8 +195,8 @@ static void atmel_spi_next_xfer(struct spi_master *master,
 		xfer, xfer->len, xfer->tx_buf, xfer->tx_dma,
 		xfer->rx_buf, xfer->rx_dma, spi_readl(as, IMR));
 
-	spi_writel(as, TCR, len);
 	spi_writel(as, RCR, len);
+	spi_writel(as, TCR, len);
 	spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
 }
 
-- 
1.5.3.4


-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
