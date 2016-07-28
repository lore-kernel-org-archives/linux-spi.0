From: Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] spi: octeon: Add thunderx driver
Date: Thu, 28 Jul 2016 10:12:55 +0200
Message-ID: <20160728081255.GB14682@hardcore>
References: <57963ED3.4090402@caviumnetworks.com>
 <20160725175622.7167-1-jglauber@cavium.com>
 <20160727180824.GS11806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160727180824.GS11806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jul 27, 2016 at 07:08:24PM +0100, Mark Brown wrote:
> On Mon, Jul 25, 2016 at 07:56:22PM +0200, Jan Glauber wrote:
> > Add ThunderX SPI driver using the shared part from the Octeon
> > driver. The main difference of the ThunderX driver is that it
> > is a PCI device so probing is different. The system clock settings
> > can be specified in device tree.
> 
> Don't send individual patches in reply to the middle of threads, it
> makes it really confusing what's going on.  I now have multiple patches
> from you for this driver completely unthreaded in my inbox with no
> indication of ordering or anything.  Please resend anything that's
> pending as a proper patch series.

With multiple being exactly two. I thought it to be easier this way
around and the ordering to be obvious (if you use threading),
but of course I can resend the two patches as a new series.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
