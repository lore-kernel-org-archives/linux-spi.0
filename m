From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] spi: fsl-lpspi: Pre-initialize ret in fsl_lpspi_transfer_one_msg()
Date: Wed, 14 Dec 2016 12:20:55 +0100
Message-ID: <1481714455-14224-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

With gcc 4.1.2:

    drivers/spi/spi-fsl-lpspi.c: In function ‘fsl_lpspi_transfer_one_msg’:
    drivers/spi/spi-fsl-lpspi.c:369: warning: ‘ret’ may be used uninitialized in this function

If the message contains no transfers, the function will set the
message's status to an uninitialized value, and will return that
uninitialized value.

While __spi_validate() should have been called in all paths leading to
this, and thus have rejected such messages, we better pre-initialize ret
to be safe for future modifications (spi_transfer_one_message() also
does this).

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-fsl-lpspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 52551f6d0c7ddf71..2b93bc605b91c5ec 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -366,7 +366,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
 	struct spi_transfer *xfer;
 	bool is_first_xfer = true;
 	u32 temp;
-	int ret;
+	int ret = 0;
 
 	msg->status = 0;
 	msg->actual_length = 0;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
