From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: core: fix missing unlock on error in __spi_pump_messages()
Date: Tue, 26 Jul 2016 09:35:33 +0000
Message-ID: <1469525733-26302-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add the missing unlock before return from function
__spi_pump_messages() in the error handling case.

Fixes: ef4d96ec4ad9 ("spi: Split bus and I/O locking")
Signed-off-by: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51ad42f..a1be046 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1159,7 +1159,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 		if (ret < 0) {
 			dev_err(&master->dev, "Failed to power device: %d\n",
 				ret);
-			return;
+			goto out;
 		}
 	}
 
@@ -1174,7 +1174,7 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)
 
 			if (master->auto_runtime_pm)
 				pm_runtime_put(master->dev.parent);
-			return;
+			goto out;
 		}
 	}

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
