From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: spi: OF module autoloading is still broken (was: Re: m25p80: Commit
 "allow arbitrary OF matching for "jedec,spi-nor"" breaks module autoloading)
Date: Fri, 13 Nov 2015 11:40:31 -0800
Message-ID: <20151113194031.GI8456@google.com>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151112185926.GC8456-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

(Changing subject line, because apparently some people ignore mail if it
doesn't have 'SPI' in the subject line)

On Thu, Nov 12, 2015 at 10:59:26AM -0800, Brian Norris wrote:
> + others
> 
> On Sat, Oct 03, 2015 at 11:54:16PM +0200, Heiner Kallweit wrote:
> > Seems like commit 43163022927b6e7d202a7e6f939c3f392465494d
> > (allow arbitrary OF matching for "jedec,spi-nor") broke autoloading
> > of the m25p80 module.
> > MODALIAS is "spi:spi-nor" and removing "spi-nor" as device alias
> > prevents module autoloading.
> > 
> > Of course we could revert the removal of the "spi-nor" device alias.
> > However it might be better to switch to DT-based matching for
> > DT-configured devices.
> > 
> > Adding a call to of_device_uevent_modalias to spi_uevent in spi.c
> > solved the issue for me, drawback however is that just the first
> > "compatible" value is used as modalias. In case of m25p80 this means
> > that "jedec,spi-nor" has to be the first "compatible" value.
> > This constraint might be too strict ..
> > 
> > Having said that I'm not sure what could be a better way to fix
> > the issue than just re-introducing the "spi-nor" device alias.
> 
> Is this [1] getting fixed in SPI any time soon? Looks like there was
> some progress [2], but AFAICT it's not completed.
> 
> I'd just like to know what the way forward here should be for m25p80.
> Really, "jedec,spi-nor" never autoloaded modules very reliably because
> of the SPI core constaints. So I'm not sure I'd consider this a
> regression, and I might be OK waiting around if it'll be fixed in a
> reasonable time frame.
> 
> FWIW, I can do testing if somebody's tackling this still. Just CC me.
> 
> Regards,
> Brian
> 
> [1] https://lkml.org/lkml/2014/9/11/458
> [2] https://lkml.org/lkml/2015/8/20/109
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
