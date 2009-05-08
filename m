From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Fwd: Re: pxa2xx_spi: fix for SPI_CS_HIGH
Date: Fri, 8 May 2009 12:17:41 -0700
Message-ID: <200905081217.42060.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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


----------  Forwarded Message  ----------

Subject: Re: pxa2xx_spi: fix for SPI_CS_HIGH
Date: Friday 08 May 2009
From: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>

Em Sex, 2009-05-08 =E0s 09:33 -0700, David Brownell escreveu:
> This doesn't need to merge before 2.6.31, right?
> (That is, is is true that nothing in mainline is
> yet *relyings* on CS_HIGH working with this driver?)

2.6.31 is ok! :)

> Assuming that's true, this patch needs to be updated to
> apply properly against modebits changes in the MM tree.

Done. Applies after
spi-move-more-spi_setup-functionality-into-core.patch.

--

Commit a7bb3909b3293d503211d7f6af8ed62c1644b686 introduces chipselect
GPIO, and configures the CS polarity using SPI_CS_HIGH spi->mode flag.
Add SPI_CS_HIGH to the allowed modes.

Signed-off-by: Daniel Ribeiro <drwyrm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1482,7 +1482,7 @@
 	drv_data->ssp =3D ssp;
 =

 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits =3D SPI_CPOL | SPI_CPHA;
+	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 =

 	master->bus_num =3D pdev->id;
 	master->num_chipselect =3D platform_info->num_chipselect;


-- =

Daniel Ribeiro


-------------------------------------------------------

---------------------------------------------------------------------------=
---
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i7=
00
Series Scanner you'll get full speed at 300 dpi even with all image =

processing features enabled. http://p.sf.net/sfu/kodak-com
