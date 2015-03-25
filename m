From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: replace ugly table by approximation
Date: Wed, 25 Mar 2015 12:37:45 +0200
Message-ID: <1427279865.14897.405.camel@linux.intel.com>
References: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1427211802-217454-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20150324165954.GL17265@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150324165954.GL17265-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-03-24 at 09:59 -0700, Mark Brown wrote:
> On Tue, Mar 24, 2015 at 05:43:22PM +0200, Andy Shevchenko wrote:
> > The Quark SoC data sheet describes the baud rate setting using fractional
> > divider. The subset of possible values represented by a table suggests that the
> > divisor has one block that could divide by 5. This explains a satan number in
> > some cases in the table Thus, in this particular case the divisor can be
> > evaluated as
> 
> What is a "satan number"?

Number of the beast 666.

> 
> > +	/* Quark SoC has 200MHz xtal */
> > +	unsigned long xtal = 200000000, fref = xtal / 2;
> > +	/* Define two reference frequencies */
> > +	unsigned long fref1 = fref / 2, fref2 = fref * 2 / 5;
> 
> The Linux coding style generally frowns on multiple initializaitons on a
> single line for legibility reasons.

Not a problem, however they are tighten to each other.

> 
> > +	/* Choose the best between two */
> > +	if (r2 >= r1 || q2 > 256) {
> > +		r = r1;
> > +		q = q1;
> > +		mul = mul1;
> > +	} else {
> > +		r = r2;
> > +		q = q2;
> > +		mul = (1 << 24) * 2 / 5;		/* 0x666666 */
> > +	}
> 
> Making the comments on this a bit more explicit might be helpful - a
> mention of why it's better to pick pick one of the settings or the other
> would help.

Okay, I will make it more verbose.

> 
> > +	/* In case the divisor is big enough */
> > +	if (fref / rate >= 80) {
> > +		u64 fssp;
> > +
> > +		/* Calculate initial quot */
> > +		q1 = DIV_ROUND_CLOSEST(fref, rate);
> > +		mul1 = (1 << 24) / q1;
> > +
> > +		/* Get the remainder */
> > +		fssp = (u64)fref * mul1;
> > +		do_div(fssp, 1 << 24);
> > +		r1 = abs(fssp - rate);
> > +
> > +		/* Choose this one if it suits better */
> > +		if (r1 < r) {
> > +			q = 1;
> > +			mul = mul1;
> > +		}
> > +	}
> 
> So what do we do if the divisor is not big enough?  

Then we choose one of the first two variants.

> I'm not sure that
> one could reasonably expect someone to follow this code without doing
> detective work.  I think the biggest thing is that the comments aren't
> saying why the code is doing what it's doing.

Should I cite data sheet in case to explain some branches?

-- 
Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
