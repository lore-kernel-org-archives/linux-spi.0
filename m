From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3 0/5] spi: dw: device tree and generic queue support
Date: Sun, 2 Feb 2014 15:31:48 +0100
Message-ID: <20140202143148.GT20094@book.gsilab.sittig.org>
References: <cover.1391162172.git.baruch@tkos.co.il>
 <20140202124941.GS20094@book.gsilab.sittig.org>
 <20140202133235.GF9184@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140202133235.GF9184@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Feb 02, 2014 at 15:32 +0200, Baruch Siach wrote:
> 
> Hi Gerhard,
> 
> On Sun, Feb 02, 2014 at 01:49:41PM +0100, Gerhard Sittig wrote:
> > On Fri, Jan 31, 2014 at 12:07 +0200, Baruch Siach wrote:
> > > Unfortunately, I probably have no chance access to thest this series on
> > > hardware, I's only compile tested. So I'm sending this as RFC for code review.
> > > If this series doesn't get merged, it may be used at least as a starting point
> > > for someone with hardware access.
> > 
> > Which repo and branch is the code based on?  I can't apply it
> > here, neither to v3.13 nor torvald's master nor broonie's
> > topic/dw nor broonie's for-next.
> 
> This sereis is based on the topic/dw branch as of 6d3a38819. Mark has applied 
> patch no. 5 from this series to topic/dw. Is this the cause of your problem?

I was looking into how I could test the GPIO based chip select
support.  Unfortunately I don't have much hardware around either,
it turned out that none of the available boards allow me to run
mainline kernels and access the signals or connect more slaves.
So I'm sorry but cannot help beyond review either. :(


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
