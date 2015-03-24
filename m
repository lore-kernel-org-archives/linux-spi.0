From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: pxa2xx: allow to set mostly any baudrate
 for Quark case
Date: Tue, 24 Mar 2015 18:27:32 +0200
Message-ID: <1427214452.14897.401.camel@linux.intel.com>
References: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150324162323.GH17265@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150324162323.GH17265-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-03-24 at 09:23 -0700, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 05:43:20PM +0200, Andy Shevchenko wrote:
> 
> > Mark, it would be nice to have this in 4.0-rcX since it will be the first
> > kernel with Quark support. And I applied necessary patch to allow user to
> > select SPI driver for it, though it's up to you.
> 
> We're at -rc5 now, that seems too late to try to get a new feature into
> v4.0 I'm afraid.

I'm fine with it, we may push this to stable release then.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
