From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] spi/mxs: Fix device remove function
Date: Fri, 24 Aug 2012 13:37:39 -0700
Message-ID: <20120824203739.GA7592@roeck-us.net>
References: <1345831382-7290-1-git-send-email-linux@roeck-us.net>
	<201208242210.12924.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201208242210.12924.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 24, 2012 at 10:10:12PM +0200, Marek Vasut wrote:
> Dear Guenter Roeck,
> 
> > The call sequence
> > spi_alloc_master/spi_register_master/spi_unregister_master is complete; it
> > reduces the device reference count to zero, which results in device memory
> > being freed. The remove function accesses the freed memory after the call
> > to spi_unregister_master(), _and_ it calls spi_master_put on the freed
> > memory.
> > 
> > Acquire a reference to the SPI master device and release it after cleanup
> > is complete (with the existing spi_master_put) to solve the problem.
> > 
> > Also, the device subsystem ensures that the remove function is only called
> > once, and resets device driver data to NULL. Remove the unnecessaary calls
> > to platform_set_drvdata().
> > 
> > Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> 
> Damn, I thought this was fixed, apparently not. Thanks!
> 
For some reason most spi drivers have similar problems. I learned it the hard way
when I tested my own driver, and decided to fix as many drivers as I can. Which is
why you see all those patches from me lately.

On a side note, at least some of the spi bitbang drivers have a similar problem.
Unfortunately, I can not fix it right now because I have no means to test it,
and have no idea what exactly is _supposed_ to happen.

> Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> 
> > ---
> > Applies to -next (as of 8/24/12).
> > 
> >  drivers/spi/spi-mxs.c |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> > index 130a436..cb189b7 100644
> > --- a/drivers/spi/spi-mxs.c
> > +++ b/drivers/spi/spi-mxs.c
> > @@ -582,7 +582,6 @@ static int __devinit mxs_spi_probe(struct
> > platform_device *pdev) return 0;
> > 
> >  out_free_dma:
> > -	platform_set_drvdata(pdev, NULL);
> >  	dma_release_channel(ssp->dmach);
> >  	clk_disable_unprepare(ssp->clk);
> >  out_master_free:
> > @@ -596,14 +595,12 @@ static int __devexit mxs_spi_remove(struct
> > platform_device *pdev) struct mxs_spi *spi;
> >  	struct mxs_ssp *ssp;
> > 
> > -	master = platform_get_drvdata(pdev);
> > +	master = spi_master_get(platform_get_drvdata(pdev));
> 
> What happens if platform_get_drvdata() returns NULL ? (is it possible?)
> 
The driver subsystem locks the device during remove, clears drvdata,
and only releases the lock after it is done. The code ensures that the remove
function is not called again. See drivers/base/dd.c:__device_release_driver().
The same happens during probe; see drivers/base/dd.c:really_probe().

Thanks,
Guenter

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
