From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean
 up chip identification
Date: Thu, 9 Oct 2014 21:52:00 -0700
Message-ID: <20141010045200.GC22169@norris-Latitude-E6410>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714795.3040.45.camel@decadent.org.uk>
 <20140928220300.GB3248@norris-Latitude-E6410>
 <1412041673.9388.75.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412041673.9388.75.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Sep 30, 2014 at 02:47:53AM +0100, Ben Hutchings wrote:
> On Sun, 2014-09-28 at 15:03 -0700, Brian Norris wrote:
> > On Sun, Sep 14, 2014 at 06:13:15PM +0100, Ben Hutchings wrote:
> > > Note that these patch are:
> > > - Based on your 'testing' branch
> > 
> > Which testing branch? These two are the only official
> > repos for MTD:
> > 
> >     git git://git.infradead.org/linux-mtd.git
> >     git git://git.infradead.org/l2-mtd.git
> 
> You had a testing branch in
> git://git.infradead.org/users/norris/linux-mtd.git, and that included
> commit af249c3a0ca8 ('mtd: spi-nor: remove duplicated w25q128 entry')
> which this patch series depended on.

That repository is very much unofficial. I have a MAINTAINERS patch
queued up to add git://git.infradead.org/l2-mtd.git (our -next repo) to
reduce future confusion.

Regards,
Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
