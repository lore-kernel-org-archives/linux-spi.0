From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
Date: Sat, 21 Dec 2019 19:20:57 +0100
Message-ID: <20191221182057.GA32732@amd>
References: <20191212033952.5967-1-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org, Roc He <hepeng@zidoo.tv>,
        zypeng@titanmec.com, sales@fdhisi.com, csd@princeton.com.tw
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191212033952.5967-1-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series implements the LED controllers found in some RTD1295 ba=
sed
> TV set-top boxes.
>=20
> Ever since I've had mainline Linux kernels booting on my Zidoo X9S TV box,
> it's been bugging me that it kept displaying "boot" on its front display.
> A hot lead was a TM1628 chip on the front display's daughterboard, which
> English and Chinese datasheets were available for. The biggest
> hurdle

Fun :-).

> It goes on to add a "text" attribute to the driver that enables DT-config=
ured
> seven-segment displays; I was expecting to find precedence in auxdisplay
> subsystem but came up empty. So my driver currently integrates its own
> generic (but incomplete) character-to-8-segments mapping, as well as in a
> second step a combined-characters-to-8-segments mapping, which then gets
> mapped to the chipset's available output lines. Doing this as sysfs
> device

I did not investigate this in great detail; but if it is displaying
characters, auxdisplay is probably right subsystem to handle that. I
guess LEDs can still take the low-level parts...

Oh, and common dimming for many LEDs is seen on other hardware, too
(Turris routers). Not sure how to handle that, either :-(.

Best regards,
									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3+YokACgkQMOfwapXb+vJoqgCfY5/dzSIdT0c0DWaA1+WWkFdQ
6wkAoIzd/X2VTQwW3tq7WApoawbDjUdO
=xFhp
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
