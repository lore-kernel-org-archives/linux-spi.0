From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean
 up chip identification
Date: Sun, 28 Sep 2014 15:03:00 -0700
Message-ID: <20140928220300.GB3248@norris-Latitude-E6410>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714795.3040.45.camel@decadent.org.uk>
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
In-Reply-To: <1410714795.3040.45.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Sep 14, 2014 at 06:13:15PM +0100, Ben Hutchings wrote:
> On Sun, 2014-09-14 at 18:10 +0100, Ben Hutchings wrote:
> > The first patch in the series restores the module aliases to m25p80, but
> > it does so by duplicating the list of names.  This should be suitable
> > for stable, but it isn't viable in the longer term.
> > 
> > The following patches change the spi-nor interface so that this
> > duplication is no longer necessary.  This includes removing
> > spi_nor::read_id, but it could be re-added after this with a different
> > interface, e.g. returning a flash_info structure (which would need to be
> > defined in spi_nor.h).
> 
> Note that these patch are:
> - Based on your 'testing' branch

Which testing branch? These two are the only official
repos for MTD:

    git git://git.infradead.org/linux-mtd.git
    git git://git.infradead.org/l2-mtd.git

> - Untested by me, aside from compiling and checking that m25p80 has the
>   expected module aliases

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
