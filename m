From: "Kweh, Hock Leong" <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v2] spi/pxa2xx-pci: Add common clock framework support
 in PCI glue layer
Date: Wed, 13 Aug 2014 11:59:14 +0000
Message-ID: <F54AEECA5E2B9541821D670476DAE19C2B6D9010@PGSMSX102.gar.corp.intel.com>
References: <1406221854-12828-1-git-send-email-chiau.ee.chew@intel.com>
 <20140725053230.GT1857@lahna.fi.intel.com>
 <CAAQYJAtM79NJJtfNYda-yFk113nm-2D8gZE5x=gbnLt2_eUdzQ@mail.gmail.com>
 <20140729185529.GG17528@sirena.org.uk>
 <CAAQYJAtLVgqbs=n2gxyemDAoHhM=7PFJy9bqKUExTbC+1rSNMg@mail.gmail.com>
 <D004FADD.9F315%dvhart@linux.intel.com>
 <20140807084302.GO1657@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"Chew, Chiau Ee" <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	"chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140807084302.GO1657-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Thursday, August 07, 2014 4:43 PM
> To: Mark Brown; Darren Hart
> Cc: Andrea Adami; Chew, Chiau Ee; Kweh, Hock Leong; Russell King;
> chiauee85-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Haojian Zhuang; linux-
> spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Eric Miao; linux-arm-kernel
> Subject: Re: [PATCH v2] spi/pxa2xx-pci: Add common clock framework
> support in PCI glue layer
> 
> On Mon, Aug 04, 2014 at 08:55:50AM -0700, Darren Hart wrote:
> > On 7/29/14, 15:06, "Andrea Adami" <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > >On Tue, Jul 29, 2014 at 8:55 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > >> On Tue, Jul 29, 2014 at 06:13:06PM +0200, Andrea Adami wrote:
> > >>
> > >>> note that a previous version of the patch breaks spi on pxa machines:
> > >>> tested on pxa250 poodle and pxa255 corgi.
> > >>> The patch is included in linux-Yocto since 3.14.
> > >>
> > >> The interesting question is if this version works...
> > >
> > >Happy to report that I could finally test on poodle/pxa250 the
> > >current
> > >v2 and the patch doesn't seem to disturb the probe.
> > >Sorry for the noise.
> > >
> > >Andrea
> > >
> >
> > I tested this (v2) on the MinnowBoard-Max (Baytrail Atom E3825) in PCI
> > mode and successfully attached an MCP32XX ADC and tested it's IIO
> > interface.
> 
> Mark,
> 
> Any idea what happened to this patch? I didn't find it in linux-next and it
> looks like it is not merged with mainline either.

Hi Mark,

Would like to follow up with you about this patch. Do you have plan to merge it in ?


Regards,
Wilson
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
