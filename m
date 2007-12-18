From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 7/12] neo1973: JBT6K74 LCM control
 interface driver
Date: Tue, 18 Dec 2007 15:59:54 -0800
Message-ID: <20071218235954.5351225EA51@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071218110800.GN29882-jI4mzJ+yNOMOwssVsN95jSCwEArCW2h5@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Just one minor comment to start with:

> --- linux-2.6.orig/drivers/spi/Kconfig
> +++ linux-2.6/drivers/spi/Kconfig
> @@ -237,5 +237,11 @@
>  
>  # (slave support would go here)
>  
> +config SPI_SLAVE_JBT6K74
> +	tristate "tpo JP6K74 LCM ASIC control interface"
> +	depends on SPI_MASTER && SYSFS
> +	help
> +	  Driver for the tpo JP6K74-AS LCM SPI control interface.
> +
>  endmenu # "SPI support"
>  

It's not a slave-side driver though ... it's a master-side driver,
depending on SPI_MASTER, and making bus master calls like spi_write().

I think the Kconfig could stand to be more informative too.  "LCM" is
as cryptic as "tpo", there's no clue about what is controlled (SPI?),
and the symbols are internally inconsistent:  "JBT" != "JP", etc

So after I get you any technical comments, I'll want a new patch
with Kconfig and Makefile updates going in the proper place.  (I'm
not sure I'll have many technical comments.)

- Dave


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
