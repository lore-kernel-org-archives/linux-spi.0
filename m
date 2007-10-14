From: "Wu, Bryan" <cooloney.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/10] Blackfin SPI driver: use new
	GPIO API and add error handling
Date: Mon, 15 Oct 2007 01:06:53 +0800
Message-ID: <386072610710141006kc3897b3s80db77d348971c7e@mail.gmail.com>
References: <1192158304-8277-1-git-send-email-bryan.wu@analog.com>
	<200710112326.34500.david-b@pacbell.net>
	<1192172077.6247.15.camel@roc-laptop>
	<200710121017.47645.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200710121017.47645.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On 10/13/07, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Thursday 11 October 2007, Bryan Wu wrote:
> > On Thu, 2007-10-11 at 23:26 -0700, David Brownell wrote:
> > > On Thursday 11 October 2007, Bryan Wu wrote:
> > > > @@ -1182,12 +1198,9 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
> > > >                 return -ENOMEM;
> > > >         }
> > > >
> > > > -       if (peripheral_request(P_SPI0_SCK, DRV_NAME) ||
> > > > -                peripheral_request(P_SPI0_MISO, DRV_NAME) ||
> > > > -                peripheral_request(P_SPI0_MOSI, DRV_NAME) ) {
> > > > -
> > > > +       if (setup_pin_mux(1)) {
> > > >                 dev_err(&pdev->dev, ": Requesting Peripherals failed\n");
> > > > -               goto out_error_queue_alloc;
> > > > +               goto out_error;
> > > >         }
> > > >
> > > >         drv_data = spi_master_get_devdata(master);
> > > >
> > >
> > > Still doesn't apply ... what tree are you generating this series against??
> >
> > I apply this patch on Linus git tree at 2.6.23 tag
>
> Then why don't my copies of that tree have the lines flagged
> above with "-" ??
>
> In fact, if I look at the kernel.org GIT tree, it doesn't have
> them either.  Your tree must have somehow gotten a bunch of
> private changes.
>
>
Yes, the GIT tree's code is without that lines, which are introduced
by the first patch of my SPI update patches: Blackfin SPI driver:
Initial supporting BF54x in SPI driver.

So please apply the latest whole Blackfin SPI driver update patchset
including 10 patches instead of 9 patches in previous email.

Thanks a lot
Best Regards

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
