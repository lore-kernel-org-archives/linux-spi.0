From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: bcm2835: warn about native-chip-selects being used
Date: Mon, 30 Mar 2015 21:20:20 +0200
Message-ID: <4790EEB6-C62D-4FE0-98AE-26ADE3024B04@martin.sperl.org>
References: <0330B85B-A297-482B-80A9-E01F236D33D2@martin.sperl.org> <20150330042205.GB1568@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150330042205.GB1568-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 30.03.2015, at 06:22, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> 
>> But I do not know what is the correct call to use.
> 
> I don't know what you mean by "correct call" here, sorry.  If you're
> talking about working out which GPIO maps to the /CS pin then can the
> pinctrl API help?

Well - how do I change the mode of a GPIO to output (which is typically ALT0)?
something like this:
>> 			gpio_set_output(spi->gpio_cs);

I was hoping someone would have an explicit pointer...

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
