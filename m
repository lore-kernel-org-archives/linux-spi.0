From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/1] spi: bcm-qspi: Make BSPI default mode
Date: Thu, 29 Aug 2019 10:59:07 +0100
Message-ID: <20190829095907.GB4118@sirena.co.uk>
References: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Cc: Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1567052173-10256-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 09:46:13AM +0530, Rayagonda Kokatanur wrote:
> The spi-nor controller defaults to BSPI mode, hence switch back
> to its default mode after MSPI operations (write or erase)
> are completed.
>=20
> Changes from V1:
>  - Address code review comment from Mark Brown.

As covered in submitting-patches.rst inter-version changelogs should go
after the --- so they don't end up in git.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1noeoACgkQJNaLcl1U
h9CUYAf+M++ibN/14SNtvLXhF5fpC2dh40Q9FTVy7OsuIlbVuVpy7PFeKvnciNwp
eCMACa5b1BJPR/fsQO/XOuJYaOl6zxI3eQqN8jT44zGq61NX42nncJappFDr75we
Z45dLAMqxHcmZQ3U5SqlZVLn+m8jhgasIggPzPvpgUllrObaKmjf2ODqyf1McaHZ
GiloqwCmG+i1H2sWR9qlbbqUSuoNbLaRpeS8E3Qi0ebHf/e/N7eVaUhwLLfJQLCd
WHjr6gh/xRujyDPf//XPvTSXwQMAx25LhuQKI13Ml2Tpk62WnJjrcmS3hjJ594mb
MjDGMh4SN7qA9OEQnajSjb9pfx+P9Q==
=iSMZ
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
