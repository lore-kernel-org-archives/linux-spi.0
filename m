From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi: spi-fsl-dspi: new(ish) memory leak in dspi_setup_transfer()
Date: Tue, 10 Feb 2015 10:20:59 -0800
Message-ID: <20150210182059.GW18140@ld-irv-0074>
References: <54d91b9c86b36_26777a33202121b@scan.coverity.com.mail>
 <20150209210741.GR18140@ld-irv-0074>
 <1ee64e5218bf046c00cbe97a5b04bc31@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1ee64e5218bf046c00cbe97a5b04bc31-XLVq0VzYD2Y@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 10, 2015 at 05:54:39PM +0100, Stefan Agner wrote:
> On 2015-02-09 22:07, Brian Norris wrote:
> > FYI, Coverity reported a "new" memory leak since this commit:
> > 
> >     commit 973fbce69ed8e79b5fe3ad19cfecb581a7ef8048
> >     Author: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
> >     Date:   Tue Jan 27 16:27:20 2015 +0530
> > 
> >         spi: spi-fsl-dspi: Remove usage of devm_kzalloc
> 
> Afaik, this has already been resolved by
> https://lkml.org/lkml/2015/1/31/145

Great, thanks for pointing me!

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
