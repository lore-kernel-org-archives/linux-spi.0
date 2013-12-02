From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: remove pointless _remove function
Date: Mon, 2 Dec 2013 17:36:12 +0000
Message-ID: <20131202173612.GL27568@sirena.org.uk>
References: <1385744947-10283-1-git-send-email-mpn@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hun9kSK4g7A5t+iU"
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Nazarewicz <mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385744947-10283-1-git-send-email-mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hun9kSK4g7A5t+iU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2013 at 06:09:07PM +0100, Michal Nazarewicz wrote:
> From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
>=20
> Commit [8074cf06: use devm_spi_register_master()] removed the last
> bit of omap1_spi100k_remove function that had side effects.  After
> call to spi_unregister_master was removed, the function consisted
> of:

Applied, thanks.

--hun9kSK4g7A5t+iU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnMUJAAoJELSic+t+oim9huAP/jOSBU9eTdhgqx4MocERlJH9
EmND7C7i8z+vDkueW70g4iNDHx4PvGSojCtmPVKhOw8EIf/K1OMzO0qwOdvIlaiJ
2h0soCqf21FsaxqGcH0GnT8ejQv4ryX7ghHJh7Wyu5r0dzKXLFKo9t0JdIsWAppd
mLasQFj18BiywJ+WyiSCE+Sq9dmxIATbaSHTodnDeibZkjCg62b/y3zCjmCX5lvb
+dHnMBGT1N9Mpjq66KIuRFNvQDCTYwgu/VvdV/KefyYoKQhloTdeh4wfBBgrj+sH
B4fJLyroWGbOu1daxCbuclFJfASgkp+ug+dj8Dz0ZntTCeMuU/lhnLOgzqVMecYO
4uHgxuj1/JVgYAQz8Dm06cZq6cA+Y/ZStJwbW1gzb30+hV9S37vXSbpeJDPszju+
Am7j6hIUKZTte5mC41rw2CJquBvzbyiMrmdgbOFqDzexwnLmWzMO5dyzvQd41h4z
2K0uRyWu+j0UXYa1kECirdCEP8piahrNNR+TT80UIZ3G2Ii5VJsp8eyFACxQ56Ex
RFPzacGwGBf7f3w+pzVMMw9D2eoQMJSafRi7A+QRwNJ+YXLTiD/O7vQCABEw5v2v
EJHDPozx8nXhXu+yJGGzY1HyZyd+cmZelPnlSVXSFTdHk9/LEisYU7mrhmJ8Cura
Oz2Yhm6fxah7UD3I48SU
=zNyN
-----END PGP SIGNATURE-----

--hun9kSK4g7A5t+iU--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
