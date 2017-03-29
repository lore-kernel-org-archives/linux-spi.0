From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dynamycally allocated message initialization" to the spi tree
Date: Wed, 29 Mar 2017 12:02:50 +0100
Message-ID: <E1ctBNK-0007Tr-Qx@debutante>
References: <20170328074929.GA3196@ingrassia.epigenesys.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170328074929.GA3196-jmy0SlbNOkhImI5vKGm7D+z8H4t1NRXw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dynamycally allocated message initialization

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

>From ed77d6bcafd75d247cf3c6ad685aa221cda1b8ba Mon Sep 17 00:00:00 2001
From: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>
Date: Tue, 28 Mar 2017 09:49:29 +0200
Subject: [PATCH] spi: dynamycally allocated message initialization

Invoke the proper function while initializing
a dynamically allocated spi_message to avoid
NULL pointer dereference during resources deallocation.

Signed-off-by: Emiliano Ingrassia <ingrassia-rBIjXPeIPFWU+1/U8MakDg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 75c6bd0ac605..3b0070695375 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -891,7 +891,7 @@ static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags
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
