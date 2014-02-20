From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] Documentation/spi/spidev_test.c: Document -N/--no-cs and -R/--ready
Date: Thu, 20 Feb 2014 16:01:43 +0100
Message-ID: <1392908503-23166-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

commit b55f627feeb9d48fdbde3835e18afbc76712e49b ("spi: new spi->mode bits")
added two new command line options without adding the respective help
texts.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 Documentation/spi/spidev_test.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 16feda901469..efd7385e907f 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -81,7 +81,9 @@ static void print_usage(const char *prog)
 	     "  -O --cpol     clock polarity\n"
 	     "  -L --lsb      least significant bit first\n"
 	     "  -C --cs-high  chip select active high\n"
-	     "  -3 --3wire    SI/SO signals shared\n");
+	     "  -3 --3wire    SI/SO signals shared\n"
+	     "  -N --no-cs    no chip select\n"
+	     "  -R --ready    slave pulls low to pause\n");
 	exit(1);
 }
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
