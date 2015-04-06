From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: setting up cs_gpio levels prior to registering spi devices
Date: Mon, 6 Apr 2015 20:37:37 +0200
Message-ID: <897B0B6D-3885-4792-AD51-BB4D2656C3C5@martin.sperl.org>
References: <1428340592-3196-3-git-send-email-kernel@martin.sperl.org> <20150406173607.GX6023@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406173607.GX6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 06.04.2015, at 19:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> Please write a series of if statements with continues instead, the above
> block is pretty much illegible with the lack of vertical space, mixture
> of bracketing levels and small indent for the active statement at the
> end.
will do...

> As far as I can tell this code only works for GPIO chip selects?
Correct - unless you want to extend struct spi_master with a new method
to make this generic - maybe at a later point in time...

> Please don't write placeholders like this.
will do - I just was not sure if it is needed or not, so I wanted to make
it explicit to say: maybe we need something here as well...


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
