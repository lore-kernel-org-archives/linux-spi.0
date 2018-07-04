From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC net-next 15/15] net: lora: Add Semtech SX1301
Date: Wed, 4 Jul 2018 12:43:55 +0100
Message-ID: <20180704114355.GB11693@sirena.org.uk>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-16-afaerber@suse.de>
 <20180702161258.GA18744@sirena.org.uk>
 <4e06cc72-2092-70f3-c801-bf6e4c3cbec2@suse.de>
 <20180703145022.GA13744@sirena.org.uk>
 <809fc546-6012-37f3-9485-cfd8eaf99488@suse.de>
 <20180703153137.GB13744@sirena.org.uk>
 <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        Michael =?iso-8859-1?Q?R=F6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        Steve deRosier <derosier@gmail.com>, linux-spi@vger.kernel.org,
        LoRa_Community_Support@semtech.com,
        Hasnain Virk <Hasnain.Virk@arm.com>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f6289f9-d345-39a7-f0dd-9d5fa7c86e82@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2018 at 06:40:41PM +0200, Andreas F=E4rber wrote:

> Do you have an alternative solution for abstraction? A regmap would seem
> to require putting everything into a monolithic SX1301 driver despite
> those connected chipsets actually being regular, external SPI chips that
> could also be attached to non-SX1301 SPI masters.

I'm suggesting a regmap for those external SPI chips.  It doesn't matter
what the host uses.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls8svoACgkQJNaLcl1U
h9BJzQf+MAsXjRHeQXvCHJN0ToPWII6jvxcjvoQYIZZxzeImZA2TyBNSJWMPR2Fm
vQDZ7DxwN6kk8vnSEjjzOGRm+bbVgja3qRkb0HS+WbDYGQNro80F1m35hT8O3B37
lZWZL9C20bImSJWQExgmr+il35fBvJUzkLQY1J9syMRLaaRJ4+CIKrH7Xj16mZKM
Hfr/G9HU0llJnefxKdyW5s5xNA7u2xSq+PrekNTVhAK0/sketwIueXHiuM4EF7pz
vNjy5KKIhnvdEDhKA1bI+podQlSOQyuox8y9zav42sy+Oz94lnUNo2D/+DlBgRFr
hcD5HtTKBAqZUKbMSJQOtoshneigLg==
=ldPE
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
