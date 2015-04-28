From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [PATCH v2] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Tue, 28 Apr 2015 17:49:46 -0500
Message-ID: <20150428224946.GA19294@deathray>
References: <1430106270-17142-1-git-send-email-mwelling@ieee.org>
 <20150427195550.GE22845@sirena.org.uk>
 <20150428012150.GA12713@deathray>
 <55B19D93-B930-4363-9D44-0E97B4B836BF@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55B19D93-B930-4363-9D44-0E97B4B836BF-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Apr 28, 2015 at 07:32:21AM +0200, Martin Sperl wrote:
> 
> > On 28.04.2015, at 03:21, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org> wrote:
> > If I were to attempt to convert the driver to use the core chipselect support,
> > how would I go about doing it?
> > 
> > Is there another driver that I can use for reference?
> You may look into this patch: e34ff011c70e5f4ef219141711142d5111ae6ebb
> for the spi-bcm2835 driver, which did the conversion to the new transfer_one
> interface (and framework based GPIO chipselects).

I will take a look.

Thanks.

> 
> For most parts all you have to do is take the contents of the loop over all the
> spi_transfers inside your master->transfer_one_message method and create a new
> method with it and assign it to master->transfer_one.
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
