From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SPI: Add driver for Cadence SPI controller
Date: Tue, 18 Mar 2014 15:59:16 +0000
Message-ID: <20140318155916.GD11706@sirena.org.uk>
References: <1395057936-8643-1-git-send-email-harinik@xilinx.com>
 <20140317173017.GW11706@sirena.org.uk>
 <255edf4f-05a8-4d9a-b32d-1a4a8ddaffb5@CH1EHSMHS004.ehs.local>
 <20140318110401.GH11706@sirena.org.uk>
 <d7cf691a-c9cb-4a8a-bf5c-eae952a5d729@VA3EHSMHS045.ehs.local>
 <20140318123348.GR11706@sirena.org.uk>
 <aa8486d2-8571-4b31-8980-78806a80e600@CH1EHSMHS031.ehs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z4DYh21Th0UNJ5x"
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"rob@landley.net" <rob@landley.net>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Michal Simek <michals@xilinx.com>
To: Harini Katakam <harini.katakam@xilinx.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aa8486d2-8571-4b31-8980-78806a80e600@CH1EHSMHS031.ehs.local>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--2Z4DYh21Th0UNJ5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 02:45:09PM +0000, Harini Katakam wrote:

> OK. I dint consider interrupt sharing.=20
> Do you think the following implementation would be better?

> status =3D IRQ_NONE;
> if (intr_status & CDNS_SPI_IXR_MODF_MASK) {
> 	/* Handle this interrupt here */
> 	status =3D IRQ_HANDLED;
> } else if (intr_status & CDNS_SPI_IXR_TXOW_MASK) {
> 	/* Handle this interrupt here */
> 	status =3D IRQ_HANDLED;
> }

> return status;

Yes, that looks good.

--2Z4DYh21Th0UNJ5x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKG1QAAoJELSic+t+oim9STMP/RKGeGtOb5KYT2GZnDLOFnaO
37N957TIqJFycMYhY+mmWST81tGCHI0LQh8KBj09niR2kl7M/4grSj2ehmf5BQHI
NNdRJLHfO9vGHTFovOQQoFZeXoqqPBE84/uVmtLLL23jPDncACDHwPuItJV/J9YN
SibRUm1Hb9tDSAzmGj3b6s8ek7X/YhPMgsdxelLNnBC57AhaIRdOfgmy1zzN9YdK
4835CGkod+lZAesCQNq4VXeRImegAGJoUBNYqu6rgMsF6gjKh0WpdWZBZk7IcKkc
qZi7EoqWt69SCAhOFF5y3yx8NHen/aAWeXDyZsAFNCk/f6zpsnVaLSKv3hkb8PUu
KbpXzYuOk+4WQ4p33snte1kuWfoyN0d9dh7yu5VBwx6/Cq8Aocu8QN2zH0nWD5q/
Rj3fVu9ivPyned8QSxuSRxfDsQgGMnYF7L+KHTlBASiJWrBnmByGsYzmjccoLswG
z+zsSUV0mmHyxqG7qKER43X6YJZIqj6PfPWbSAdJuivbbV0b+kfTU8IIzyYHUiLR
q5jpika9ZfEan9sfW7SaRlU3IxjHy5/0xfUYQZsfBQOgp+XYMm9qjR8AKasoSJyS
+kOcr4aRg8yAHfP6KrzSzpgf5rEpj4K+6p60HFdd0cP6ovckuSi/J2uBbh7opP4C
dRBhxwM5fNOjmyETVoHM
=nRfP
-----END PGP SIGNATURE-----

--2Z4DYh21Th0UNJ5x--
