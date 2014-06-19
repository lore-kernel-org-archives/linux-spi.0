From: dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: [PATCH] spi: spidev: Fix user-space memory access.
Date: Thu, 19 Jun 2014 21:52:15 -0000
Message-ID: <4277a609d7431f34663d19a006a5ada6.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When the spidev module tries to access the user space memory passed in via
an IOCTL the compat_ptr function should be called to ensure
compatibility between kernel space and user space.

Signed-off-by: Dan Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spidev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3bc23b..3a45158 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -252,14 +252,16 @@ static int spidev_message(struct spidev_data *spidev,
                if (u_tmp->rx_buf) {
                        k_tmp->rx_buf = buf;
                        if (!access_ok(VERIFY_WRITE, (u8 __user *)
-                                               (uintptr_t) u_tmp->rx_buf,
+                                               (uintptr_t)compat_ptr( +  
                                                    u_tmp->rx_buf),
                                                u_tmp->len))
                                goto done;
                }
                if (u_tmp->tx_buf) {
                        k_tmp->tx_buf = buf;
                        if (copy_from_user(buf, (const u8 __user *)
-                                               (uintptr_t) u_tmp->tx_buf,
+                                               (uintptr_t)compat_ptr( +  
                                                    u_tmp->tx_buf),
                                        u_tmp->len))
                                goto done;
                }
@@ -294,8 +296,8 @@ static int spidev_message(struct spidev_data *spidev,
        for (n = n_xfers, u_tmp = u_xfers; n; n--, u_tmp++) {
                if (u_tmp->rx_buf) {
                        if (__copy_to_user((u8 __user *)
-                                       (uintptr_t) u_tmp->rx_buf, buf, - 
                                     u_tmp->len)) {
+
(uintptr_t)compat_ptr(u_tmp->rx_buf),
+                                       buf, u_tmp->len)) {
                                status = -EFAULT;
                                goto done;
                        }
--
1.8.4






---
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
