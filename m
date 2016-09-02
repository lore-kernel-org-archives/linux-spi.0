From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 12/23] spi: fsl-espi: fix status handling in
 fsl_espi_do_one_msg
Date: Fri, 2 Sep 2016 23:22:15 +0200
Message-ID: <7aede0d3-1ec5-81c4-5079-7685b3b2d3bf@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If an error occurred during message handling return this error instead
of always returning 0 and align the code with the generic
implementation in spi_transfer_one_message.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 5f01b65..6b60f7b 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -381,9 +381,12 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 		ret = fsl_espi_rw_trans(m, &espi_trans, rx_buf);
 
 	m->actual_length = espi_trans.actual_length;
-	m->status = ret;
+	if (m->status == -EINPROGRESS)
+		m->status = ret;
+
 	spi_finalize_current_message(master);
-	return 0;
+
+	return ret;
 }
 
 static int fsl_espi_setup(struct spi_device *spi)
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
