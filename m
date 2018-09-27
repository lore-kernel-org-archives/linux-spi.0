From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
Date: Thu, 27 Sep 2018 23:47:23 +0100
Message-ID: <20180927224723.GF20825@sirena.org.uk>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
 <20180925203701.13605-2-dangtranhieu2012@gmail.com>
 <CABGGiszY6+UDwzfuS6ob0C1zcGL4DfhcZ_iYjUGSXwWcbjPYRg@mail.gmail.com>
 <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TUvp6TiFcfhGC84w"
Cc: robh@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: =?utf-8?B?xJDhurduZyBUcuG6p24gSGnhur91?=
        <dangtranhieu2012@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAObPoHOEYrDj8uoFK-gW8jvy8i-vtRhTkEEm5aVNn8ucLxRMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--TUvp6TiFcfhGC84w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 09:37:39PM +0700, =C4=90=E1=BA=B7ng Tr=E1=BA=A7n Hi=
=E1=BA=BFu wrote:

> Default value of the register is to allow stalling (NOSTALL bit not
> set) but the spi-fsl-lpspi driver defaults to setting the NOSTALL bit
> in CFGR1. To me, it's more logical to leave the NOSTALL bit off with
> fsl,nostall binding to set the bit but as I am not sure if there are
> other drivers depending on the NOSTALL bit being set and not wanting
> to break other drivers hence introduction of this binding to keep the
> current default behavior.

I can't see a situation where you'd actively want to report an error
rather than stall, stalling allows us to handle things gracefully by
restarting things.  Even if it's a timeout situation it sounds like we
can unblock by reading/writing the stalled FIFO, and normally you'd be
resetting the entire IP anyway.  I'd imagine the driver is this way
either through an oversight or because there's some bug on some silicon
which means that stalling breaks.

Probably best to just always enable stalling unless I'm misreading
things, if it is silicon bugs on some versions then either a whitelist
or blacklist of SoCs to enable on (depending on how common the bug is)
would be the way forwards - that way SoCs where it works get the benefit.

--TUvp6TiFcfhGC84w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlutXfoACgkQJNaLcl1U
h9ABMgf/czCL8Xz21qJvcfFwf1QCjMgUyRCWY9a16J/vrdk/aDgSAtCrloo/6M6e
Q2hByQEEQzinBT10Y280ZFhpfdqOCLJcXVGtEC4QIXUdY0FeNRWFvNyh2ipJ0WB+
ovlbt0puUcGIX0BQHCW/k9Yd33r5fawXq9ZYmmota43b6JjT+83LIXD8YwF+3MFH
RtRvcfN7hp09oQO1xiWsdbY8JTnvlnbV4Sriij8eMnlDBXfiAHEEcmZbeZ0kZ5M4
Y/x+x0A/RZgws5P2WKasI0DTbp3fJj72hdbStB7vfwXOcOmzAzGk6assdQNGgrKi
OFk3SNnVV8OGl7rwuNvyZ74whmIJqw==
=1ny+
-----END PGP SIGNATURE-----

--TUvp6TiFcfhGC84w--
