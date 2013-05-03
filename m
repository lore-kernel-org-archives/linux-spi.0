From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 01/15] spi: altera: remove unnecessary
	platform_set_drvdata()
Date: Fri, 03 May 2013 16:16:17 +0900
Message-ID: <004d01ce47ce$1b473690$51d5a3b0$@samsung.com>
References: <003e01ce47ca$38f68910$aae39b30$@samsung.com>
	<CACxGe6vkjU_LroO9gtBY4d1wcU__Wk7n=hzo27Df5nbV6TJQvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: 'Grant Likely' <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <CACxGe6vkjU_LroO9gtBY4d1wcU__Wk7n=hzo27Df5nbV6TJQvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday, May 03, 2013 4:08 PM, Grant Likelywrote:
> On Fri, May 3, 2013 at 7:48 AM, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> > The driver core clears the driver data to NULL after device_release
> > or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> > (device-core: Ensure drvdata = NULL when no driver is bound).
> > Thus, it is not needed to manually clear the device driver data to NULL.
> >
> > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Hi Jingoo,
> 
> Thanks for doing this. However, there is no need to have a separate
> patch for each and every spi driver. Can you please squash them all
> into a single patch and repost?
> 
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Hi Grant,

OK, I see.
I prefer the separate patches, but I will squash them
into a single patch and repost it. :)
Thank you.


Best regards,
Jingoo Han

> 
> > ---
> >  drivers/spi/spi-altera.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
> > index a537f8d..81b9adb 100644
> > --- a/drivers/spi/spi-altera.c
> > +++ b/drivers/spi/spi-altera.c
> > @@ -285,7 +285,6 @@ static int altera_spi_probe(struct platform_device *pdev)
> >  exit_busy:
> >         err = -EBUSY;
> >  exit:
> > -       platform_set_drvdata(pdev, NULL);
> >         spi_master_put(master);
> >         return err;
> >  }
> > @@ -296,7 +295,6 @@ static int altera_spi_remove(struct platform_device *dev)
> >         struct spi_master *master = hw->bitbang.master;
> >
> >         spi_bitbang_stop(&hw->bitbang);
> > -       platform_set_drvdata(dev, NULL);
> >         spi_master_put(master);
> >         return 0;
> >  }
> > --
> > 1.7.2.5
> >
> >
> 
> 
> 
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
