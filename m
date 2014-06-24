From: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/1] spi: omap-uwire: Fix build error
Date: Tue, 24 Jun 2014 11:48:19 +0530
Message-ID: <1403590699-9625-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=46ixes the following build error introduced by commit b3f6a57506
("spi: omap-uwire: use devm_ functions"):
drivers/spi/spi-omap-uwire.c:465:2: error: implicit declaration of func=
tion =E2=80=98devm_ioremap=E2=80=99

Since we are including <linux/io.h>, <asm/io.h> is no longer
needed. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-omap-uwire.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.=
c
index cbf67f92ec22..4c5d09eb331d 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -45,10 +45,10 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/module.h>
+#include <linux/io.h>
=20
 #include <asm/irq.h>
 #include <mach/hardware.h>
-#include <asm/io.h>
 #include <asm/mach-types.h>
=20
 #include <mach/mux.h>
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
