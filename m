From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Fwd: pxa2xx_spi: prevent panic case setup()
	fails
Date: Fri, 8 May 2009 09:35:31 -0700
Message-ID: <200905080935.31564.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

for 2.6.30 please 

----------  Forwarded Message  ----------

Subject: pxa2xx_spi: prevent panic case setup() fails
Date: Friday 08 May 2009
From: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

setup() may fail before ctldata is set, causing a kernel panic on
cleanup().

Signed-off-by: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 885194a..2801307 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1373,6 +1373,9 @@ static void cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	if (!chip)
+		return;
+
 	if (gpio_is_valid(chip->gpio_cs))
 		gpio_free(chip->gpio_cs);
 

-- 
Daniel Ribeiro


-------------------------------------------------------

------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
