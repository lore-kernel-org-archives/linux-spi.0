From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH v6 2/4] spi: bcm2835: add bcm2835 auxiliary spi device driver
Date: Mon, 4 Jan 2016 15:23:52 +0100
Message-ID: <36C84129-0322-41C5-B01A-AF6F002E001E@martin.sperl.org>
References: <1441970527-2403-1-git-send-email-kernel@martin.sperl.org> <1441970527-2403-3-git-send-email-kernel@martin.sperl.org> <1866751.zFWfh0Kuks@chaos-desktop>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1866751.zFWfh0Kuks@chaos-desktop>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 04.01.2016, at 14:51, Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org> wrot=
e:
>=20
> According to the spi documentation [1]: "CPHA indicates the clock pha=
se used=20
> to sample data; CPHA=3D0 says sample on the leading edge, CPHA=3D1 me=
ans the=20
> trailing edge."
> Which is from my understanding different from what the BMC2835 ARM Pe=
ripherals=20
> [2] says for BCM2835_AUX_SPI_CNTL0_CPHA_IN:
> "If 1 data is clocked in on the rising edge of the SPI clock
> If 0 data is clocked in on the falling edge of the SPI clock"
>=20
> I would expect the bits to be set dependant on the clock polarity (CP=
OL).

I am only having =E2=80=9Ctypical=E2=80=9D devices with do Mode 0,0 or =
1,1 for which it
works.

Please come up with the =E2=80=9Ccorrect=E2=80=9D logic for this to be =
set up correctly
and create the corresponding patch, as I do not have a corresponding
device for testing.

>=20
> The other issue I have, is that the chip select is set before the clo=
ck=20
> polarity and the polarity is reset and set again between each transfe=
rs of a=20
> message. If CPOL is set to 1 this leads to additional rising and fall=
ing edges=20
> of the clock while chip select is active, where no data is sampled.
>=20

This is something I have seen before with the main spi HW.
We may need to port the same thing there.

The corresponding patch for spi-bcm2835.c is this:
acace73df2c1913a526c1b41e4741a4a6704c863

So we may need to move the corresponding logic in the same manner.

But this may be a more common problem when using GPIO-CS
which may need to get addressed at the spi-core level to avoid
such complications in other/future drivers - or it needs to be
=E2=80=9Cwell documented=E2=80=9D and may require a different =E2=80=9C=
hook=E2=80=9D, as the use
of prepare_message may not be 100% correct...

Martin


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
