From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Date: Fri, 25 Jan 2019 17:47:13 +0000
Message-ID: <20190125174713.GA6939@sirena.org.uk>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Cc: Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
To: Jonas Bonn <jonas@norrbonn.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
> On 25/01/2019 12:53, Baolin Wang wrote:
> > On Fri, 25 Jan 2019 at 19:44, Jonas Bonn <jonas@norrbonn.se> wrote:

> > Can we configure it at runtime by the device rather than at DT time by
> > the controller? If yes, we already have a patch for this, please
> > check:

> It's a characteristic of the SPI slave, in the same sense as CPOL/CPHA are,
> and therefore it makes sense to specify it in the device tree.

No, that doesn't follow at all.  There's two bits here - where the
configuration gets done and the mechanism by which it gets done.  If
something in DT is completely orthogonal to which device it is a
property of.

> Having this as device property rather than a transfer property allows this
> to be configured one time in setup() rather than having to fiddle with the
> configuration register for every transfer.

That doesn't mean that the coniguration should be done in DT though, and
given that this presumably is a property of the device there seems to be
no reason why we'd have it in DT - if every instance of the device is
going to need to set the property we should just figure it out from the
compatble string instead.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxLS58ACgkQJNaLcl1U
h9Ci1Af+KPQ6Fd4EwOmXjTuA/3wvO5WHx034mRClNaY5DwGvpFwEr3ZJmUQlIDND
5Sd8+g6AjlOmkjsv7Lhoe2UCvYcPVUqbr5J0HId083UZDlHi7vIBChD9JnW5a0Up
u0aur6HuzudvMplSCT1eaCtp0EZ81TdwfPsLESCTAe1dGUQUSANCpv2SpbJfDtBO
dLituQEv3GeGhiGtoEcfajriq0k+IaI/zC6D+iaFgR1qgzU9YCmPQCYtw+MtaI2X
nUXxQyOx8G7W09bToK55cHSBd6k5uwrCBK0rGbDERSp+h+nnQoZMiLxxFMVd+PTm
ceJVw/ruBPHRTpIz0bLX3wrAUWLiXQ==
=xcYV
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
