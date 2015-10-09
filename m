From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: Re: [RFC PATCH] spi: omap2-mcspi: disable other channels
 CHCONF_FORCE in prepare_message
Date: Fri, 9 Oct 2015 09:24:51 -0500
Message-ID: <20151009142451.GA25376@deathstar>
References: <5616816C.9020904@baylibre.com>
 <20151008152105.GA13157@deathstar>
 <20151009113810.GD1542@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151009113810.GD1542-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Oct 09, 2015 at 12:38:10PM +0100, Mark Brown wrote:
> On Thu, Oct 08, 2015 at 10:21:05AM -0500, Michael Welling wrote:
> > On Thu, Oct 08, 2015 at 04:45:00PM +0200, Neil Armstrong wrote:
> 
> > What is the point of doing this void cast below?
> > Avoiding compiler warning perhaps?
> > Perhaps you can __maybe_unused for the variable instead?
> 
> > > +	/* Ignore message */
> > > +	(void)msg;
> 
> You shouldn't need it at all, but yes if there is a good reason to mark
> something as unused the above annotation is better.

Which one?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
