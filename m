From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers shorter than 30us
Date: Sat, 18 Apr 2015 13:12:02 +0200
Message-ID: <54169601-55F7-464C-8A0E-ABF833C0F3BA@martin.sperl.org>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org> <20150410185132.GU6023@sirena.org.uk> <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org> <20150415185824.GU6023@sirena.org.uk> <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org> <20150418104202.GA26185@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418104202.GA26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 18.04.2015, at 12:42, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Sure, if everythinng is working fine then there's never any need to t=
ime
> out - the question is what happens when things go wrong.  A hard lock=
up
> probably isn't the answer people were looking for there.

Well that is why I have implemented the 1s timeout patch,
which you have already merged (145367baa492246).=20

Such a timeout would typically also trigger a messages to
dmesg, so it becomes apparent that such a situation happened.

The only issues that could really trigger a timeout would be:
* heavy load on the system, where it takes >1s to reschedule
  the polling thread - but if you get to such a situation then
  all bets are off anyway.
* a hick-up in hardware=20

As said: I have tried one type of load where I had something like
3000M SPI messages all running with polling  (about 18000 per second)
without any issues or timeouts while compiling the linux kernel.
And except for rescheduling the polling thread and the corresponding
delays there were no issues with the 1s timeout - it never triggered!

If you think that timeout of 1 second is too long, then we can change
it to something more acceptable, but it should be in the order of
100ms or more to avoid those =E2=80=9Cfalse=E2=80=9D positives due to h=
igh cpu load
that the original code showed.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
