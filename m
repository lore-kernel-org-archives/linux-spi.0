From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/pxa2xx-pci: Pass host clock rate info from PCI
 glue layer
Date: Tue, 22 Apr 2014 14:57:17 +0300
Message-ID: <20140422115716.GP30677@intel.com>
References: <1397751967-20250-1-git-send-email-chiau.ee.chew@intel.com>
 <1397751967-20250-3-git-send-email-chiau.ee.chew@intel.com>
 <20140418163054.GH12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140418163054.GH12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Apr 18, 2014 at 05:30:54PM +0100, Mark Brown wrote:
> On Fri, Apr 18, 2014 at 12:26:07AM +0800, Chew Chiau Ee wrote:
> > From: Chew, Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > Intel BayTrail PCI mode LPSS devices inclusive of SPI do not rely
> > on common clock framework. Thus, this patch allows the PCI mode
> > SPI host to pass the supported clock rate info to the core layer
> > which eventually used for speed calculation.
> 
> As you mention we already have a clock API for passing around
> information about clocks, it would be much better to fix the fact that
> this isn't enabled on x86 than to add custom code to deal with clocks
> (even simple things like this) - this is far from the only place where
> it causes issues.

We actually have clock API enabled on x86 if CONFIG_X86_INTEL_LPSS is
selected.

In this case the question is more like, where do we create clocks for PCI
enumerated devices? Surely we don't want to have board files to do this.

In ACPI mode, we do it in drivers/acpi/acpi_lpss.c but not sure where we
could do that in PCI code.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
