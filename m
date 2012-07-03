From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 08/12] Kirkwood: Add basic device tree support for
 QNAP TS219.
Date: Tue, 3 Jul 2012 19:09:51 +0200
Message-ID: <20120703170951.GC1519@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-9-git-send-email-andrew@lunn.ch>
 <5219791.0WtDlTNBEQ@flexo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5219791.0WtDlTNBEQ@flexo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 03, 2012 at 05:47:57PM +0200, Florian Fainelli wrote:
> Hi Andrew,
> 
> On Tuesday 03 July 2012 16:22:41 Andrew Lunn wrote:
> > The two different variants of QNAP TS devices, varying by SoC, put the
> > GPIO keys on different GPIO lines. Hence we need two different DT
> > board descriptions, which share the same board-ts219.c file.
> 
> Why don't you reorder this patch to be after patch 11/12 so that you do not 
> need to update this file in patch 11/12?

It just reflects the order i did the work. I can rebase it, but what
is the advantage? It should be fully bisectable as is.

> 
> > 
> > Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> > Acked-by: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
> > ---
> [snip]
> >  
> > +config MACH_TS219_DT
> > +	bool "Device Tree for QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, 
> TS-219P and TS-219P+ Turbo NAS"
> 
> This looks too long, how about just "Device Tree for QNAP TS-11x, TS-21x NAS" 
> for instance?

Yes, i was not too happy with this. I copied the none DT version as a
basis, since that is what kernel builds know at the moment. Since i'm
not alone not liking it, i will change it as you suggested.

    Thanks
	Andrew
