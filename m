From: Ben Nizette <bn@niasdigital.com>
Subject: Re: [PATCH] atmel_spi: fix dma addr calculation for len >
 BUFFER_SIZE
Date: Tue, 29 Sep 2009 10:55:59 +1000
Message-ID: <1254185759.7587.180.camel@ben-desktop>
References: <1254029187.7587.146.camel@ben-desktop>
	 <20090928091259.27485716@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: hskinnemoen@atmel.com, spi-devel-general@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	kernel <kernel@avr32linux.org>, dbrownell@users.sourceforge.net
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753917AbZI2Avo@vger.kernel.org>
In-Reply-To: <20090928091259.27485716@hskinnemoen-d830>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2009-09-28 at 09:12 +0200, Haavard Skinnemoen wrote:

> Wow, that is subtle. I had to stare at it for a long while before I
> understood what's going on, but I believe you're right.

Prolly just means my changelog was crappy ;-)

> 
> Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
> 
> While you're at it, could you send another patch renaming 'len' to
> 'next_len'? I think that would make it a bit more obvious why your
> patch is correct and prevent similar mistakes in the future.

Good plan, below.

Thx,
	--Ben.
> 
> Haavard

---8<---

From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH] atmel_spi: make "len" variable name less ambiguous in dma addr calculation

"[PATCH] atmel_spi: fix dma addr calculation for len > BUFFER_SIZE"
fixed a bug where the "len" variable in atmel_spi_next_xfer_data() was
taken to be the total number of bytes remaining in the transfer but it
actually represents the number of bytes which will be sent this dma
chunk.  While the 2 will be the same if there is less than 1 chunk to go
(or if we aren't using a scratch buffer and therefore aren't breaking
the transfers in to chunks), they won't be the same in general.

s/len/next_len to reflect the true nature and usage of this variable.

Signed-off-by: Ben Nizette <bn@niasdigital.com>
---
 drivers/spi/atmel_spi.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 8ce70cb..5d94fca 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -185,28 +185,28 @@ static void atmel_spi_next_xfer_data(struct spi_master *master,
 				u32 *plen)
 {
 	struct atmel_spi	*as = spi_master_get_devdata(master);
-	u32			len = *plen;
+	u32			next_len = *plen;
 
 	/* use scratch buffer only when rx or tx data is unspecified */
 	if (xfer->rx_buf)
 		*rx_dma = xfer->rx_dma + xfer->len - *plen;
 	else {
 		*rx_dma = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
+		if (next_len > BUFFER_SIZE)
+			next_len = BUFFER_SIZE;
 	}
 	if (xfer->tx_buf)
 		*tx_dma = xfer->tx_dma + xfer->len - *plen;
 	else {
 		*tx_dma = as->buffer_dma;
-		if (len > BUFFER_SIZE)
-			len = BUFFER_SIZE;
-		memset(as->buffer, 0, len);
+		if (next_len > BUFFER_SIZE)
+			next_len = BUFFER_SIZE;
+		memset(as->buffer, 0, next_len);
 		dma_sync_single_for_device(&as->pdev->dev,
-				as->buffer_dma, len, DMA_TO_DEVICE);
+				as->buffer_dma, next_len, DMA_TO_DEVICE);
 	}
 
-	*plen = len;
+	*plen = next_len;
 }
 
 /*
-- 
1.6.0.4
