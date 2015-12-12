From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: add spi_message_init_no_memset to avoid zeroing the spi_message" to the spi tree
Date: Sat, 12 Dec 2015 23:08:05 +0000
Message-ID: <E1a7tGn-0002s1-7B@finisterre>
References: <1448632564-2381-2-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448632564-2381-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: add spi_message_init_no_memset to avoid zeroing the spi_message

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 49ddedf3bfcb59a562c7db0e50aecd1422e9cdc9 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Fri, 27 Nov 2015 13:56:03 +0000
Subject: [PATCH] spi: add spi_message_init_no_memset to avoid zeroing the
 spi_message

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 7 ++++++-
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
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
