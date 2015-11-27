From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/2] spi: add spi_message_init_no_memset to avoid zeroing the spi_message
Date: Fri, 27 Nov 2015 13:56:03 +0000
Message-ID: <1448632564-2381-2-git-send-email-kernel@martin.sperl.org>
References: <1448632564-2381-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448632564-2381-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

In the spi_loopback_test driver there is the need to initialize
a spi_message that is filled with values from a static structure.

Applying spi_message_init to such a prefilled structure results in
all the settings getting reset to zero, which is not what we want.
Copying each field of spi_message separately instead always includes
the risk that some new fields have not been implemented in the copying
code.

So here we introduce a version of spi_message_init called
spi_message_init_no_memset that does not fill the structure
with zero first, but only initializes the relevant list_heads.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 include/linux/spi/spi.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index cce80e6..4c54d47 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -762,10 +762,15 @@ struct spi_message {
 	void			*state;
 };
 
+static inline void spi_message_init_no_memset(struct spi_message *m)
+{
+	INIT_LIST_HEAD(&m->transfers);
+}
+
 static inline void spi_message_init(struct spi_message *m)
 {
 	memset(m, 0, sizeof *m);
-	INIT_LIST_HEAD(&m->transfers);
+	spi_message_init_no_memset(m);
 }
 
 static inline void
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
