From: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-pxa2xx: Fix potential NULL handler data in pump_transfers
Date: Tue,  3 Mar 2015 10:59:30 +0800
Message-ID: <1425351570-29571-1-git-send-email-huiquan.zhong@intel.com>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Set drv_data->cur_chip to NULL before finalize current message, otherwise
kernel may crash.

BUG: unable to handle kernel NULL pointer dereference at 000000000000001c
IP: [<ffffffff824a0ae2>] pump_transfers+0x32/0x640

It is possibility that workqueue schedule next pump_messages before
statement: drv_data->cur_chip = NULL;
This will override the drv_data->cur_chip to NULL.

Fix this by moving spi_finalize_current_message(drv_data->master) call after
drv_data->cur_chip = NULL in giveback().

Signed-off-by: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 05c623c..23822e7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -546,8 +546,8 @@ static void giveback(struct driver_data *drv_data)
 			cs_deassert(drv_data);
 	}
 
-	spi_finalize_current_message(drv_data->master);
 	drv_data->cur_chip = NULL;
+	spi_finalize_current_message(drv_data->master);
 }
 
 static void reset_sccr1(struct driver_data *drv_data)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
