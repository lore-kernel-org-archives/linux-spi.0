From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: [PATCH 2/4] spi: orion: Respect per-transfer bits_per_word settings
Date: Thu, 15 Feb 2018 15:19:11 +0100
Message-ID: <b983963f1ad0400fdca2f8bf8095d25b62b0ffb0.1518704854.git.jan.kundrat@cesnet.cz>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It's a bug to look at the device's bits_per_word because each transfer
can override these settings. In fact, e.g., spidev cannot specify
"global" bits_per_word and instead relies on passing that through every
ioctl.

This code already did the right thing in orion_spi_setup_transfer, but
then failed to access the HW in an appropriate way here in
orion_spi_write_read.

Tested by 16-bit trnasfers via spidev on an Armada 388 (Solidrun
Clearfog).

Signed-off-by: Jan Kundrát <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
---
 drivers/spi/spi-orion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index ca52300baeb1..56e419a7ed78 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -427,7 +427,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	struct orion_spi *orion_spi;
 	int cs = spi->chip_select;
 
-	word_len = spi->bits_per_word;
+	word_len = xfer->bits_per_word ? xfer->bits_per_word : spi->bits_per_word;
 	count = xfer->len;
 
 	orion_spi = spi_master_get_devdata(spi->master);
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
