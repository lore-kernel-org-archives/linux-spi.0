From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/6] spi: bcm2835: fill FIFO before enabling interrupts
 to
Date: Sat, 04 Apr 2015 19:49:41 -0600
Message-ID: <552094B5.3050109@wwwdotorg.org>
References: <3628E5E2-7EA9-488F-AF5F-A2E43D2D1E3E@martin.sperl.org> <551A1185.6060502@wwwdotorg.org> <20150331052519.GZ2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150331052519.GZ2869-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/30/2015 11:25 PM, Mark Brown wrote:
> On Mon, Mar 30, 2015 at 09:16:21PM -0600, Stephen Warren wrote:
>> On 03/29/2015 08:03 AM, Martin Sperl wrote:
> 
>>> There have been rare cases where short (<200ns) chip-select
>>> switches with native CS have been observed during such
>>> operation, this is why this optimization is only enabled for
>>> GPIO-CS.
> 
>>> +	/* fill in fifo if we have gpio-cs +	 * note that there have
>>> been rare events where the native-CS +	 * flapped for <1us
>>> which may change the behaviour +	 * with gpio-cs this does not
>>> happen, so it is implemented +	 * only for this case +	 */
> 
>> However, I'm not sure why this is in any way related to whether
>> the chip-select GPIO is valid. Surely we always want to do this?
>> How does the mechanism used to control chip selects influence
>> whether we want to pre-fill the FIFO?
> 
> I think both the comment and the commit message answer that
> question - something triggers spurious chip select changes?

I must admit I don't feel either the commit message or the comment
explain the situation. They certainly state that there are glitches in
the "native CS" case, but that doesn't *explain* them. It seems more
likely the under-filling the FIFO would cause periods where the FIFO
was empty which would be aout the only case I could naively think of
for the CS to be de-asserted. More investigation would be useful.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
