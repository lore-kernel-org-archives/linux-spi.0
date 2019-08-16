From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH net-next 03/11] spi: Add a PTP system timestamp to
 the transfer structure
Date: Fri, 16 Aug 2019 13:18:37 +0100
Message-ID: <20190816121837.GD4039@sirena.co.uk>
References: <20190816004449.10100-1-olteanv@gmail.com>
 <20190816004449.10100-4-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Cc: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-spi@vger.kernel.org, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190816004449.10100-4-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 03:44:41AM +0300, Vladimir Oltean wrote:

> @@ -842,6 +843,9 @@ struct spi_transfer {
> =20
>  	u32		effective_speed_hz;
> =20
> +	struct ptp_system_timestamp *ptp_sts;
> +	unsigned int	ptp_sts_word_offset;
> +

You've not documented these fields at all so it's not clear what the
intended usage is.

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1WnxwACgkQJNaLcl1U
h9D8nwf8DrLh/nyypE5Z9eyCgD6tjtuKC/OLPBwFr+Ok3tAYfcVFUJ32DJ8ZsCMh
U3HfHE/KSUK/VgOCv3d6iuNk/2fozEYiFgggeyqoDagiyssXjNSFQwaBI1jNh/8A
9gG+00aG06VCwcYtFPeXNZGyv1ifPFZOuyuwZjIyM9Wfl4B4CbX3o+cxGBhpHQvE
F1Nn4b4/rttBYAmxt5whDtU6ZgGnilVy9i3naqH5bO1ZPR8Mi3i8lOtntBetVVHG
obyEBNVcgWAfxcuHoGZnQXRVJjYicjNa3odkE971eZnqFJlBlQdOWZc5sOpdVFrs
/3NmdZUt9i/YniIdFEhbJ2YM954ivg==
=C5En
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
