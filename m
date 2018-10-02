From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] spidev: Enable the Liebherr's BK4 board to work with
 spidev driver
Date: Tue, 2 Oct 2018 10:11:20 +0200
Message-ID: <20181002101120.0f92f296@jawa>
References: <20180927223152.24990-1-lukma@denx.de>
        <47e37a54-6df6-47c0-b38b-ad35e9bd4ce4@cesnet.cz>
        <20181001142219.GB19099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_u9a=FNUjzZxxdVoNt_xTQk"; protocol="application/pgp-signature"
Cc: Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001142219.GB19099@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/_u9a=FNUjzZxxdVoNt_xTQk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jan,

> On Mon, Oct 01, 2018 at 04:20:32PM +0200, Jan Kundr=C3=A1t wrote:
>=20
> > Hi Lukasz,
> > I tried submitting a similar patch for another devicem but got no
> > reaction [1]. In the meanwhile, there has been another proposal [2]
> > which moves =20
>=20
> As documented in SubmittingPatches please send patches to the=20
> maintainers for the code you would like to change.=20

I'm using the ./scripts/get_maintainer.py script to obtain list of
relevant people.

Moreover, you may want to look for gitk -- <patch to your modified
file> and add developers, who did some remarkable work in that file.

Also git-blame helps.

And another issue - maitainers are very often very busy (as
maintaining/reviewing is not their main occupation).
We would like to have a prompt response/review, but it is acceptable to
wait week or two for reply....=20


Please also document in the ./Documentation/devicetree the introduced
compatible -> there are some examples (ge,ahca) in the misc directory.

> The normal kernel
> workflow is that people apply patches from their inboxes, if they
> aren't copied they are likely to not see the patch at all and it is
> much more difficult to apply patches.




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/_u9a=FNUjzZxxdVoNt_xTQk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluzKCkACgkQAR8vZIA0
zr3AiwgAqda1Vt18KLTmjRn0zSmAmL8YKr/YvwZukHlAbjTFMGtqSBEcZogkVFfw
Vyu+shvI441kvcCMPFQpEZZlEBVUuSvHA64UgKKfs6mOlL8Kj2T1HPRfExTn0dnm
wGFyOSgP7JNW3a2h6/dmebO+Cl+Z15XXAcvEezK+WN16NPNmH3DX7ylprCpEi3WO
zhX0sP/f5vl2BFE99HhbPRXAcECMNEuAD89kKZHSl+Hnx9FlQhEMzwLvkoKgSdyB
JPyAfFcJbMzloZWnqQxTW8/A0U+uCmU7OtlIgo7nVNXNjCIyc+KjHHHrU27irxb6
q6y0EemSXHv/mV0Apk6p0m3TR97CEw==
=lchy
-----END PGP SIGNATURE-----

--Sig_/_u9a=FNUjzZxxdVoNt_xTQk--
