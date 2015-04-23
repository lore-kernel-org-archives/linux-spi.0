From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Warn loudly if instantiated from DT as "spidev"
Date: Thu, 23 Apr 2015 21:23:55 +0200
Message-ID: <1B291B64-3DF2-4476-B2C4-46013509F453@martin.sperl.org>
References: <1427499742-26916-1-git-send-email-broonie@kernel.org> <7C2BEBF5-5169-4804-A7B8-DBCE2E9E8C70@martin.sperl.org> <CAMuHMdUv0z=VOec+JbbRBeM9fg2TvQgRX4GefVbOZDoQoOECQQ@mail.gmail.com> <CAMuHMdW5hgB7vFmMc6TRqJ2wwWZ0=S+OKdQQoucXakoSnVixtw@mail.gmail.com> <20150423103652.GT22845@sirena.org.uk> <5538F1D6.7020503@martin.sperl.org> <20150423133622.GV22845@sirena.org.uk> <5538F95A.20203@martin.sperl.org> <20150423181317.GZ22845@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150423181317.GZ22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 23.04.2015, at 20:13, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> As *repeatedly* mentioned before please stop taking things off-list. =
 I
> really shouldn't need to remind you of this quite so often, I'm very
> tempted to start ignoring such messages.
>=20
This was NOT my intention and I am really sorry for that.

>> I agree, that we need a long-term solution, but the way it is right =
now
>> in for-next/for-linux people think something is broken and will call=
 it
>> a regression or maybe an API change (because of a change in behaviou=
r on
>> the device-tree).
>=20
> The entire point of this change is to make it look like things are
> broken because they are, in fact, broken.  We continue to support the=
se
> systems, we just complain loudly about them.

Essentially you say: let us produce an error-message for some
situation where there is NO way around making it work without
an error message.

>> But even with that change proposed to automatically register spidev =
in
>> the absence of a dedicated driver, this would basically drive the
>> distributions for boards like the raspberry pi, beaglebone black or
>> similar to change:
>> compatiblity=3D"spidev";
>> to:
>> compatiblity=3D"spi,unknown_device";
>=20
>> The distribution does not know what people will connect, so they can
>> not set the "right" value, so they have to use a dummy - and spidev
>> is the "typical" dummy that works right now.
>=20
> The distributions should not be registering any devices at all, they'=
ve
> no idea if anything is there in the first place or if spidev is a
> suitable way of controlling it - it may even be that the pin
> configuration for SPI is totally unsuitable.  Users should be using
> device tree overlays to instantiate whatever hardware they have fitte=
d
> to their system or there should be some other system which enumerates
> connected modules (in the rare cases where that's viable), it was the
> BeagleBone people who started the overlay work in the first place for
> precisely this reason.

OK, so how should someone deploy a RFM12B device correctly with
device-tree?

There exists no (official) kernel support, but several user-drivers tha=
t
make use of spidev.

If I would define the following in my device-tree (overlay) as per your
request:
	compatiblity=3D=E2=80=9Choperf,rfm12b=E2=80=9D;

then (as of now) no spidev would get loaded and I can not use a
user-space driver that relies on spidev.

Similar for a max187 ADC.

Also note that the "beagle-bone people=E2=80=9D still provide device-tr=
ees that
explicitly set up compatiblity=3D=E2=80=9Cspidev=E2=80=9D - I just did =
a quick check:
/boot/dtbs/3.19.3-bone4/omap3-ha-lcd.dtb contains spidev.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
