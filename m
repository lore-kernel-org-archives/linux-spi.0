From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH v2] spi-topcliff-pch: Transform noisy message to dev_vdbg
Date: Tue, 25 Mar 2014 08:10:32 +0100
Message-ID: <1395731432-30027-1-git-send-email-alexander.stein@systec-electronic.com>
References: <20140219124150.GO2669@sirena.org.uk>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140219124150.GO2669-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If during a SPI transfer with len larger than PCH_MAX_FIFO_DEPTH and the
IRQ handler happens to be called when the transmit FIFO is already empty,
and SPSR_FI_BIT is set consequently, the message
"spi_master spi32766: pch_spi_handler_sub : Transfer is not completed"
is spammed to the systemlog, because tx_index has already increased
further due to the next bytes to be written. This case is uncritical as
new bytes have already been written.

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
Changes in v2:
* use dev_vdbg instead of dev_dbg

 drivers/spi/spi-topcliff-pch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 88eb57e..667a1bb 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -332,7 +332,7 @@ static void pch_spi_handler_sub(struct pch_spi_data *data, u32 reg_spsr_val,
 				data->transfer_active = false;
 				wake_up(&data->wait);
 			} else {
-				dev_err(&data->master->dev,
+				dev_vdbg(&data->master->dev,
 					"%s : Transfer is not completed",
 					__func__);
 			}
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
