From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/pxa2xx-pci: Pass host clock rate info from PCI
 glue layer
Date: Tue, 22 Apr 2014 15:27:23 +0100
Message-ID: <20140422152723.7542a3bc@alan.etchedpixels.co.uk>
References: <1397751967-20250-1-git-send-email-chiau.ee.chew@intel.com>
	<1397751967-20250-3-git-send-email-chiau.ee.chew@intel.com>
	<20140418163054.GH12304@sirena.org.uk>
	<20140422115716.GP30677@intel.com>
	<20140422120948.GT12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140422120948.GT12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> Why is this conditional?  It's really unhelpful for writing generic code
> handling clocks that the API isn't available as standard.  Allowing the
> user to disable it if it's not required makes sense but not making it
> available at all is just unhelpful.

KConfig allows drivers to select features they need - this seems to be a
non issue ?

> As far as I can tell the clock here is part of the same glue that allows
> the generic pxa2xx support to be instantiated from PCI.  I would
> therefore expect the glue to also instantiate the clock.  Or if it's a
> standard PCI clock then perhaps the PCI subsystem ought to be providing
> it.

For most cases it probably makes sense to do something of that form,
although as clk_enable/clk_disable allow NULL it's much less of an issue
than it might otherwise be for some of the other drivers.

Alan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
