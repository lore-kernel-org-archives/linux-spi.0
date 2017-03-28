From: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>
Subject: [PATCH] spi: dynamycally allocated message initialization
Date: Tue, 28 Mar 2017 09:49:29 +0200
Message-ID: <20170328074929.GA3196@ingrassia.epigenesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Invoke the proper function while initializing
a dynamically allocated spi_message to avoid
NULL pointer dereference during resources deallocation.

Signed-off-by: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 5a8c4b24f2dc..805878d61a8f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -892,7 +892,7 @@ static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags
 		unsigned i;
 		struct spi_transfer *t = (struct spi_transfer *)(m + 1);
 
-		INIT_LIST_HEAD(&m->transfers);
+		spi_message_init_no_memset(m);
 		for (i = 0; i < ntrans; i++, t++)
 			spi_message_add_tail(t, m);
 	}
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
