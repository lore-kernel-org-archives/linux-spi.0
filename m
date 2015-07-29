From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: fix overflow in calculation of transfer time
Date: Wed, 29 Jul 2015 16:31:41 +0200
Message-ID: <0D1C5BFD-04A0-4074-8424-DE941B00F887@martin.sperl.org>
References: <1438155250-14476-1-git-send-email-kernel@martin.sperl.org> <20150729140331.GC11082@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150729140331.GC11082-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 29.07.2015, at 16:03, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> On Wed, Jul 29, 2015 at 07:34:10AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wro=
te:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>>=20
>> This resulted in the use of polling mode when other approaches
>> (dma or interrupts) would have been more appropriate.
>=20
> Please describe the actual issue and how it's being fixed in the comm=
it
> message.  In this case the fix appears to be converting the timeout
> variable to a long long which will make things better but obviously
> isn't a complete fix for overflows - presumably the ideal thing here =
is
> to handle saturation better?

Will change the description of the commit and resubmit.

As for saturation I guess that nobody will ever run a spi-transfer
of len=3D2049638230413 bytes (at which point it would wrap) which:

a) would take 4679 days to reach at 125MHz=20
  (the max frequency of the bcm2835 SPI HW limit)
b) would not fit spi_transfer->len (defined as unsigned)

So handling saturation is not an issue when using "long long=E2=80=9D
in the context of this device.

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
