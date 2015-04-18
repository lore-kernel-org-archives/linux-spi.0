From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers shorter than 30us
Date: Sat, 18 Apr 2015 14:13:56 +0200
Message-ID: <EB2DE44C-29CA-422D-A89C-4173E02A2CEF@martin.sperl.org>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org> <20150410185132.GU6023@sirena.org.uk> <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org> <20150415185824.GU6023@sirena.org.uk> <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org> <20150418104202.GA26185@sirena.org.uk> <54169601-55F7-464C-8A0E-ABF833C0F3BA@martin.sperl.org> <20150418115343.GI26185@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418115343.GI26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 18.04.2015, at 13:53, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> As I've said several times now 1s seems far too long for a busy wait,
> the driver should fall back to something that sleeps after an initial
> busy wait (once it's clear we're over time).
Then I have misread what you wrote - I understood you wanted to avoid
having no timeout at all.

So you want something like:
* wait for 4 jiffies (which is 40ms typically)
* if we exceed that, then enable interrupts for the rest of the transfer
and let the 30s timeout handle everything else

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
