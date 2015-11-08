From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: sun4i: allow transfers to set transmission speed
Date: Sun, 8 Nov 2015 11:13:33 +0100
Message-ID: <CAGNoLaNR8av48D7T4XNt9KcdDuD0xYiC2O3f8qCSK8K5CntCCg@mail.gmail.com>
References: <1446936065-15868-1-git-send-email-mweseloh42@gmail.com>
	<20151108093515.GB6746@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151108093515.GB6746-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

2015-11-08 10:35 GMT+01:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Sat, Nov 07, 2015 at 11:41:05PM +0100, Marcus Weseloh wrote:
>
>> +     /* Transfer speed setup with fallback to board max_speed_hz */
>> +     if (tfr->speed_hz > 0 && tfr->speed_hz <= spi->max_speed_hz)
>> +             speed = tfr->speed_hz;
>> +     else
>> +             speed = spi->max_speed_hz;
>
> This is not needed, the core will always ensure that the transfer speed
> is set per on each transfer.

Ah, so we could always use tfr->speed_hz and completely ignore the
spi->max_speed_hz for the clock calculations, correct?

I did notice however, that the SPI system doesn't validate the
speed_hz value. So if I leave out the above quoted sanity checking,
then tfr->speed_hz could also contain values like -400, which trips up
the spi system in such a way that I could only repair with a reboot. I
was testing this with spidev... so maybe spidev should be patched to
check the speed value for validity?

Cheers,
  Marcus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
