From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: clarify what driver can do with
 message->status
Date: Tue, 24 Feb 2015 15:33:27 +0200
Message-ID: <1424784807.14897.24.camel@linux.intel.com>
References: <1424772249-9676-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150224132411.GF6236@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150224132411.GF6236-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-02-24 at 22:24 +0900, Mark Brown wrote:
> On Tue, Feb 24, 2015 at 12:04:09PM +0200, Andy Shevchenko wrote:
> > Currently it's unclear from the documentation if an actual driver may or may
> > not override the message->status field. It seems there is no other way to
> > indicate an error when transfer is failed, e.g. when gets overrun or underrun
> > interrupt. The patch states this clearly in the comments near to field
> > definition.
> 
> > +
> > +	/* The actual driver may set this field to indicate an error, e.g. -EIO
> > +	 * for failed transfer. */
> >  	int			status;
> 
> Let's take a step back here: what documentation are you looking at which
> says anything else about status?

The description of this field above, namely " * @status: zero for
success, else negative errno".

> I'd also expect this to go with the other kerneldoc for the field.

Any place that suits better.

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
