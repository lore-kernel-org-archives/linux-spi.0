From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 2/2] spi: Add gfp parameter to kernel-doc to fix build warning
Date: Thu, 10 Mar 2016 15:01:14 -0300
Message-ID: <1457632874-11250-3-git-send-email-javier@osg.samsung.com>
References: <1457632874-11250-1-git-send-email-javier@osg.samsung.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457632874-11250-1-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi_split_transfers_maxsize() gfp parameter is missing in the
function kernel-doc so building gives the following warning:

.//drivers/spi/spi.c:2359: warning: No description found for parameter 'gfp'

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

---

 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 78b7e899ce76..f88161247a2c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2349,6 +2349,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
  * @master:    the @spi_master for this transfer
  * @msg:   the @spi_message to transform
  * @maxsize:  the maximum when to apply this
+ * @gfp: GFP allocation flags
  *
  * Return: status of transformation
  */
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
