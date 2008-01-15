From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Re: drivers/spi/mpc52xx_psc_spi.c,
	potential use after free
Date: Mon, 14 Jan 2008 17:02:24 -0800
Message-ID: <200801141702.24260.david-b@pacbell.net>
References: <20080107143025.GA21720@Chamillionaire.breakpoint.cc>
	<1199974746.3075.14.camel@carp.tuioptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sebastian Siewior <sfgeneral-tbOqE5TproD1e3ktjv5YCg@public.gmane.org>
To: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199974746.3075.14.camel-8qF8gS5z7PwcZLk9x1mbI9BPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
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

On Thursday 10 January 2008, Dragos Carp wrote:

> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -534,10 +534,10 @@ static int __exit mpc52xx_psc_spi_do_remove(struct
> device *dev)
>  
>         flush_workqueue(mps->workqueue);

Between here ...

>         destroy_workqueue(mps->workqueue);
> -       spi_unregister_master(master);
>         free_irq(mps->irq, mps);
>         if (mps->psc)
>                 iounmap(mps->psc);

... and here, drivers can submit I/O requests.  Which will then
be completely lost!!

Can you provide a proper shutdown sequence for this driver?

ISTR that some other adapters grab an extra reference to the
adapter so that they can unregister first (getting rid of
the spi_device children, unbinding their drivers, and ensuring
no more incoming requests) and then clean up resources stored
with the driver, and then finally spi_master_put().

- Dave


> +       spi_unregister_master(master);
>  
>         return 0;
>  }
> 
> 
> 

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
