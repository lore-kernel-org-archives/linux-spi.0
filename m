From: Matthias Brugger <matthias.bgg-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH] atmel_spi.c - typo in debug message
Date: Sat, 16 Oct 2010 01:39:49 +0200
Message-ID: <4CB8E645.2050701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Matthias Brugger <mensch0815-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, kernel-o2ulR9ObcgE/ohRxsw7f2g@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patches a typo in the debug message.
Hopefully this time not line-wrapped.

Signed-off-by: Matthias Brugger <mensch0815-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/atmel_spi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 5c03a5b..154529a 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -679,7 +679,7 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 			bits = (asd->csr >> 4) & 0xf;
 			if (bits != xfer->bits_per_word - 8) {
 				dev_dbg(&spi->dev, "you can't yet change "
-					 "bit_per_word in transfers\n");
+					 "bits_per_word in transfers\n");
 				return -ENOPROTOOPT;
 			}
 		}
-- 
1.6.3.3

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
