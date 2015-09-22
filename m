From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi-imx: wait_for_completion should timeout even in non-DMA
 transfer cases
Date: Tue, 22 Sep 2015 10:29:19 -0700
Message-ID: <20150922172919.GK30445@sirena.org.uk>
References: <CAH-u=81E2RnMvm2UZxUasCSf6hMQtiMO9Y1VcNiy0pFR6Uy6vg@mail.gmail.com>
 <20150919175614.GM30445@sirena.org.uk>
 <CAH-u=816w-uGmWt-sf2AqahRL2j7RBCah8JAKOCXFFnvVdMzhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CzAS06hjyJnpEZQC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Jean-Michel Hautbois <jean-michel.hautbois-JiVWUdsMzBtWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAH-u=816w-uGmWt-sf2AqahRL2j7RBCah8JAKOCXFFnvVdMzhw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CzAS06hjyJnpEZQC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 11:08:55AM +0200, Jean-Michel Hautbois wrote:
> 2015-09-19 19:56 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> > A calculated timeout is probably best.

> Well, it depends...
> If you have a 20MHz clock, then you can transfer a byte in 4=B5s.
> As most of the time pio_transfer is used for 8 to 32 bytes max, it
> would be irrelevant to use such a small timeout.
> I can obviously do it, but not sure if using a small (say, 100ms)
> timeout would not be better.

You want a minimum threashold, yes, but you also need to be able toc ope
with larger transfers too so need to be able to raise that where
appropriate.

--CzAS06hjyJnpEZQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAY/qAAoJECTWi3JdVIfQ4HUH/2je3NMXhOip9ivAPoLICqx0
qDYlzUqrc8gS27d5Y/Zv75PZo4eFmmjxM0S4L72rj2uXSP2tBb82XW1OHDuEjx8Q
Iedb3JW7VP8YVJvLGaXQKD3BgOJGfmgyXh/NVUJcF6ePA6ahKnrMgmPf2cepe5i9
vhKOGvrfDP7RI+qlqSjEwUVKnoM2i+YVS8AES+mGAud+HzXaSNAU3CUcIwo1eMCK
C2JBXPHab2VjhG/oBAFwszP2PvMqTQTubPu9hiWXcS86u80GH7tudimjN0gaYPo1
ebazBS78Q3DYhcAFCYo3fSGXsWEi16ghRVKcYQ5IvW0CRTe7TOvzBKbSccmJCxA=
=9hDZ
-----END PGP SIGNATURE-----

--CzAS06hjyJnpEZQC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
