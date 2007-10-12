From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/9] Blackfin SPI driver: use new
	GPIO API and add	error handling
Date: Fri, 12 Oct 2007 10:59:28 +0800
Message-ID: <1192157968.6247.1.camel@roc-laptop>
References: <1192097441-24962-1-git-send-email-bryan.wu@analog.com>
	<1192097441-24962-2-git-send-email-bryan.wu@analog.com>
	<200710111446.29725.david-b@pacbell.net>
Reply-To: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200710111446.29725.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, 2007-10-11 at 14:46 -0700, David Brownell wrote:
> On Thursday 11 October 2007, Bryan Wu wrote:
> > @@ -1182,12 +1198,9 @@ static int __init bfin5xx_spi_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >         }
> >  
> > -       if (peripheral_request(P_SPI0_SCK, DRV_NAME) ||
> > -                peripheral_request(P_SPI0_MISO, DRV_NAME) ||
> > -                peripheral_request(P_SPI0_MOSI, DRV_NAME) ) {
> > -
> > +       if (setup_pin_mux(1)) {
> >                 dev_err(&pdev->dev, ": Requesting Peripherals failed\n");
> > -               goto out_error_queue_alloc;
> > +               goto out_error;
> >         }
> >  
> >         drv_data = spi_master_get_devdata(master);
> 
> 
> This doesn't apply against 2.6.23 ... ?

Oops, I missed the first patch in this patch series.
It will be sent as soon as possible.

Thanks a lot
-Bryan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
