From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] spi: spidev: create spidev device for all spi
 slaves.
Date: Wed, 27 Jul 2016 19:27:34 +0100
Message-ID: <20160727182734.GX11806@sirena.org.uk>
References: <cover.1468880530.git.hramrach@gmail.com>
 <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
 <20160718225952.GW30372@sirena.org.uk>
 <CAOMqctQ7Uq7JEYZovYqzQHLpjgk8HoK8Q2Bei3gEzFboyUxNyg@mail.gmail.com>
 <20160719124409.GC30372@sirena.org.uk>
 <CAOMqctRTNRTKKLVMXgxzdJEq0giRp5f8ujAUf-gUty9fSjqGXA@mail.gmail.com>
 <20160719171959.GD30372@sirena.org.uk>
 <CAOMqctSqkSNHjsGn-qobNknZNM5cY=0SVgrYBFPZE=odWQR=FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="50RDeE14MEV4qpyy"
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctSqkSNHjsGn-qobNknZNM5cY=0SVgrYBFPZE=odWQR=FA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--50RDeE14MEV4qpyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 19, 2016 at 08:33:12PM +0200, Michal Suchanek wrote:
> On 19 July 2016 at 19:19, Mark Brown <broonie@kernel.org> wrote:

> > It's a string that's exposed to userspace (via /proc/devices if nothing
> > else).

> Yes, the change can be detected from userspace. The question is
> more like 'Is there any sane reason anyone would rely on seeing
> that exact string for something?'

People using it to create device files at runtime or detect board
variants would be the main ones.

> BTW the classes are also exported through /sys so the spidev devices
> would look differently there also.

Yup.

> That does not make device-specific hacks go away. Initially the user
> will do only as much as it takes to get the device working right now
> and that does not include writing devicetree description of the device
> when it is used with userspace driver.

Depends, especially if you see some long term use for your code it's
common to start with the enumeration part.  It's not there currently so
people can't do that but part of getting the good practice out there is
to make it the path of least resistance.

--50RDeE14MEV4qpyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmP0VAAoJECTWi3JdVIfQul8H/iJ3CjxRMTMlwrwZazsMuypA
cVI2wsrRF3WEpFUSEgOTaRSPRR9Axoouu9n2TiR0+CQ3OEngL6B7rOilpeToAfRc
vEN+9m2oR9GgTgKqJuy0Pys1U5xlpAiOkaIqoM3iRIAwzIz0PwPoH978AWeDzJi2
Ir6Ztmi2WEhLV2ds5+DcDdHOifE4fKrznJXfA0s+FrDTM4WqILqdxGnulL1SV1GF
Jrt+fzCj8wzcScoFcLtkQ9eYTnU309b+mSsA/2B+2DGS/0Ed4TNfMuvhcA+A3kHd
2rTDmAwmcqj/AsENqn5p2VDHxFcRk+Tr7u8pucWRivSF53Tnww5A6ZfgWjHkK1I=
=OAzC
-----END PGP SIGNATURE-----

--50RDeE14MEV4qpyy--
