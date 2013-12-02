From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/11] spi: spi-sh-msiof: set hi/low Active for HW CS
Date: Mon, 2 Dec 2013 12:54:45 +0000
Message-ID: <20131202125445.GE27568@sirena.org.uk>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
 <1385921962-19843-4-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QdA8+0Hc+u1HcecE"
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385921962-19843-4-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QdA8+0Hc+u1HcecE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2013 at 03:19:15AM +0900, takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org wrote:
> From: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
>=20
> Set hardware CS(CS control function on MSIOF <-> GPIO CS) polarity
> according to SPI_CS_HIGH flag on spi->mode.

Applied, thanks.

--QdA8+0Hc+u1HcecE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnIMSAAoJELSic+t+oim9Vy0P/2A8Z4j22p/rMGqDpB2YFo8W
hQILrTa8XaxYhiT/MdTkBcv2f3KOJ0dqTS/ko9maYrIxBSLvCaaH6rbcI8G6gGOT
irBKq+CjWkGvpHsu1IpHW8LinZBXMWEpKvJgJsqbkGD9BkLEto4Id83ROrR4+e/o
VCfwEAzAJKr1J3O3u11BwfFpTnPCkJ4RhhYZa0zFU8DmZmfF26bUhYFVNip2+X5P
3CKTtOja8l/ffN+XR8hNykYyEWxGxWuYgg29UHfjSyvFKgyKwbkru6ZXx2k90I3h
dzLw7xUlgyHAj8wVXOVkAAtv+ZbnNMo68w3dfSST1+pjBCXc5xb77k305xiYuFyt
1gC6P41L2soWU09XVYEslDrvy5KajNM4smvazMfL9gYnGCcKuGRiVdSaJprdOqza
ybdKtTFhJLuAxCjDUZFLJ9uNC0t6OHOnmUqbPguOb/O8lucdnjQkJ/4MLMHjhqKR
5JKHWAoLkhY9Od90exBwLy7MHBnJrSEWfQ8w3abIt/bydU2SKfgcDNpw8tvqQSZx
S5JBfnGlhFJ8rxOkCArDGC5TT88s+95/eBl/ARnqaf9OcTgJRIKaqQ6JuElsCW//
RyvV/DA3i4M2LscS7IiQ1I132MWcT06HJu2awaLkZMvFJtlUdv1cpuNt0MouAsLc
j81uwYSnsy4MPXl4EDzl
=aYrG
-----END PGP SIGNATURE-----

--QdA8+0Hc+u1HcecE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
