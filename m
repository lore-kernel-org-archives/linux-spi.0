From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 09/11] spi-dw: Fix condition in spi_dw_{writer/reader}
Date: Wed, 22 Jun 2011 20:30:02 -0700
Message-ID: <4E02B33A.3060805@gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com>	<1308794413-11069-10-git-send-email-dirk.brandewie@gmail.com>	<20110623104506.3cfd55ce@feng-i7>	<4E02AE6E.5010307@gmail.com> <20110623112552.6f22c3de@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
To: Feng Tang <feng.tang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110623112552.6f22c3de@feng-i7>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch should have been:

spi-dw: Fix condition in spi_dw_{writer/reader}

From: Dirk Brandewie <dirk.brandewie@gmail.com>

Fix the condition based on whether the current transfer has a tx/rx
buffer.

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
  drivers/spi/spi-dw.c |   10 +++++-----
  1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 96ae4a7..0a848bc 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -193,15 +193,15 @@ static void spi_dw_writer(struct spi_dw *dws)
         u16 txw = 0;

         while (max--) {
-               /* Set the tx word if the transfer's original "tx" is not null */
-               if (dws->tx_end - dws->len) {
+               /* Set the tx word if the transfer's "tx" is not null */
+               if (dws->tx) {
                         if (dws->n_bytes == 1)
                                 txw = *(u8 *)(dws->tx);
                         else
                                 txw = *(u16 *)(dws->tx);
+                       dws->tx += dws->n_bytes;
                 }
                 dw_writew(dws, dr, txw);
-               dws->tx += dws->n_bytes;
         }
  }

@@ -213,13 +213,13 @@ static void spi_dw_reader(struct spi_dw *dws)
         while (max--) {
                 rxw = dw_readw(dws, dr);
                 /* Care rx only if the transfer's original "rx" is not null */
-               if (dws->rx_end - dws->len) {
+               if (dws->rx) {
                         if (dws->n_bytes == 1)
                                 *(u8 *)(dws->rx) = rxw;
                         else
                                 *(u16 *)(dws->rx) = rxw;
+                       dws->rx += dws->n_bytes;
                 }
-               dws->rx += dws->n_bytes;
         }
  }
