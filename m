From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V5 1/4] spi: tegra114: add support for gpio based CS
Date: Wed, 15 May 2019 10:35:22 +0100
Message-ID: <20190515093522.GC5613@sirena.org.uk>
References: <1557810235-16401-1-git-send-email-skomatineni@nvidia.com>
 <1557810235-16401-2-git-send-email-skomatineni@nvidia.com>
 <cf4bd167-49b8-5649-a2e2-7bf5ddcc6e2d@nvidia.com>
 <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33986B88CF3A30036E3F1F04C2080@BYAPR12MB3398.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 05:18:48PM +0000, Sowjanya Komatineni wrote:

> Tegra SPI doesn=E2=80=99t support inter byte delay directly to meet some =
SPI slave requirements.
> So we use GPIO control CS in parallel with a dummy HW CS and use inactive=
 cycles delay of SPI controller to mimic inter byte delay.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzb3VkACgkQJNaLcl1U
h9DDwgf+IgSDwzI5qR9A6I3NzqXiuPcYQwmgXzmah1o3/xQ9fvEAUz4bAkK2FkqX
VtvQy+JWAMR/3O5ydxa3czZfwgWVTXvwM45kwrgye/uuc6plpsJmsHPNraBuy28z
iPEJZSuAWrhTYT/5sHrjAv4tEapzYRBMs/HIYxXclBbz3mvHy9TvgF49iwgScJF/
p2GZVLoX2cfaxzvhdFzV2HZrJA/838DdOp06vKR1PPr7csfwDtTBOnjpMd6WLEJ1
pi/+g/kRW7qCzshGjqBhKGorhPo5HONC9qap8+D1RU8ol7p4JjuxgDhjgaSDa/rY
x/RgG+BBwZjujStSaE/v31pqdFUAzA==
=GuwL
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
