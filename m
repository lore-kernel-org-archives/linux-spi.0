From: Josh Cartwright <joshc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Fri, 7 Feb 2014 11:46:43 -0600
Message-ID: <20140207174643.GX20228@joshc.qualcomm.com>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
 <20140207073952.GA2610@qualcomm.com>
 <20140207165127.GV20228@joshc.qualcomm.com>
 <20140207171834.GF1757@sirena.org.uk>
 <20140207172051.GW20228@joshc.qualcomm.com>
 <20140207173108.GH1757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Gilad Avidov <gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140207173108.GH1757-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Feb 07, 2014 at 05:31:08PM +0000, Mark Brown wrote:
> On Fri, Feb 07, 2014 at 11:20:51AM -0600, Josh Cartwright wrote:
> > On Fri, Feb 07, 2014 at 05:18:34PM +0000, Mark Brown wrote:
> > > On Fri, Feb 07, 2014 at 10:51:27AM -0600, Josh Cartwright wrote:
> > > > 	config SPI_QUP
> > > > 		tristate "Qualcomm SPI Support with QUP interface"
> > > > 		depends on OF
> > > > 		depends on ARM
> 
> > > Does this really depend on ARM?  If so why?
> 
> > The ARM dependency is there for the use of _relaxed io accessor
> > variants.
> 
> That's not ARM only and I thought we were getting generic versions of it
> anyway?  ARMv8, MIPS, Microblaze, Hexagon and SH also define it.

Okay, that's fair.  I'm only vaguely familiar with the generic _relaxed
variants, but until they land, how do we appropriately declare the
dependency to prevent breaking COMPILE_TEST builds on architectures that
don't have them?  Or should we either bother?

Do we need to introduce a HAVE_RELAXED_IO_ACCESSORS selected by those
architectures with support?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
