From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH net-next 04/11] spi: spi-fsl-dspi: Cosmetic cleanup
Date: Fri, 16 Aug 2019 13:59:42 +0100
Message-ID: <20190816125942.GG4039@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-5-olteanv@gmail.com>
 <20190816122103.GE4039@sirena.co.uk>
 <CA+h21hoP3t6j2mTd2BLwizqbFap+9Z2vdxQ4ahHS3-7Vr31Lxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Cc: Hubert Feurstein <h.feurstein@gmail.com>, mlichvar@redhat.com,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-spi@vger.kernel.org, netdev <netdev@vger.kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hoP3t6j2mTd2BLwizqbFap+9Z2vdxQ4ahHS3-7Vr31Lxw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2019 at 03:37:46PM +0300, Vladimir Oltean wrote:
> On Fri, 16 Aug 2019 at 15:21, Mark Brown <broonie@kernel.org> wrote:

> > This is difficult to review since there's a bunch of largely unrelated
> > changes all munged into one patch.  It'd be better to split this up so
> > each change makes one kind of fix, and better to do this separately to
> > the rest of the series.  In particular having alignment changes along
> > with other changes hurts reviewability as it's less immediately clear
> > what's a like for liken substitution.

> Yes, the diff of this patch looks relatively bad. But I don't know if
> splitting it in more patches isn't in fact going to pollute the git
> history, so I can just as well drop it.

No problem with lots of patches in git history if you want to split it
up (and probably split it out of the series).  Like I say it's mainly
the alignment changes that it'd be better to pull out, the others really
should be but it's easier to cope there.

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1WqL0ACgkQJNaLcl1U
h9DF+wf7B3B4JsNBW4VWkpFnGhsr4gl+XnKkqDJ7m73tC2Dl3/3FKwqSYXVfkUWS
LbcxZOobEr61s9fmfjA0TUFu8B4JB8wp/jKmmzTj5ygRP07LF0jYuGAiRBaS0X7m
tfDkFIaBbHbxUdVcjqkWPAJ5LxJWMhgsDJR4rWC4FW8/KYABGNTGtKzKiMA89UEI
1UeQ13P7LnA+uSIqgypnD1QOmucjJyBZH2QWGR3D/ZoxF9Uc4M+uticmdK6+baNM
0xXq29jl5RjwEJ33XgAL9I6bSNPooiu4QVRr4DkhVV7Tvu6w7O8/sLnrq8e/bZWM
Uvi+kxInQPyMoTHZdyylCtohid/Grg==
=1nYD
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
