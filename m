From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: replace ugly table by approximation
Date: Wed, 25 Mar 2015 17:28:42 +0200
Message-ID: <1427297322.14897.409.camel@linux.intel.com>
References: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1427211802-217454-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150324165954.GL17265@sirena.org.uk>
	 <1427279865.14897.405.camel@linux.intel.com>
	 <20150325151701.GB3572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150325151701.GB3572-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2015-03-25 at 08:17 -0700, Mark Brown wrote:
> On Wed, Mar 25, 2015 at 12:37:45PM +0200, Andy Shevchenko wrote:
> > On Tue, 2015-03-24 at 09:59 -0700, Mark Brown wrote:
> 
> > > I'm not sure that
> > > one could reasonably expect someone to follow this code without doing
> > > detective work.  I think the biggest thing is that the comments aren't
> > > saying why the code is doing what it's doing.
> 
> > Should I cite data sheet in case to explain some branches?
> 
> Yes, that should be helpful.

I early today sent v2, I hope it becomes more clear.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
