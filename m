From: Sebastian Siewior <sfgeneral-tbOqE5TproD1e3ktjv5YCg@public.gmane.org>
Subject: Re: [PATCH] Re: drivers/spi/mpc52xx_psc_spi.c,
	potential use after	free
Date: Thu, 10 Jan 2008 19:22:02 +0100
Message-ID: <20080110182202.GA16112@Chamillionaire.breakpoint.cc>
References: <20080107143025.GA21720@Chamillionaire.breakpoint.cc>
	<1199974746.3075.14.camel@carp.tuioptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1199974746.3075.14.camel-8qF8gS5z7PwcZLk9x1mbI9BPR1lH4CV8@public.gmane.org>
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

* Dragos Carp | 2008-01-10 15:19:06 [+0100]:

>Fix mpc52xx_psc_spi_do_remove() use of drvdata after spi master
>unregister.
>
>Signed-off-by: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
Acked-by Sebastian Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

>---
>
> mpc52xx_psc_spi.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/spi/mpc52xx_psc_spi.c
>b/drivers/spi/mpc52xx_psc_spi.c
>index 7051e6c..a4463ba 100644
>--- a/drivers/spi/mpc52xx_psc_spi.c
>+++ b/drivers/spi/mpc52xx_psc_spi.c
>@@ -534,10 +534,10 @@ static int __exit mpc52xx_psc_spi_do_remove(struct
>device *dev)
> 
>        flush_workqueue(mps->workqueue);
>        destroy_workqueue(mps->workqueue);
>-       spi_unregister_master(master);
>        free_irq(mps->irq, mps);
>        if (mps->psc)
>                iounmap(mps->psc);
>+       spi_unregister_master(master);
> 
>        return 0;
> }
This should work since you don't touch HW in cleanup.
Another question: It seems you don't use any release_mem_region() /
request_mem_region(). Are those hidden somewhere behind DT parsing or
you don't do them at all?

Sebastian

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
