From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap-uwire: Convert to use bits_per_word_mask
Date: Mon, 3 Mar 2014 11:58:46 +0800
Message-ID: <20140303035846.GE2411@sirena.org.uk>
References: <1392445581.32256.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fr7jhMP26BSURKlp"
Cc: Imre Deak <imre.deak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392445581.32256.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Fr7jhMP26BSURKlp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 15, 2014 at 02:26:21PM +0800, Axel Lin wrote:
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--Fr7jhMP26BSURKlp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE/3zAAoJELSic+t+oim91zQP/ju8YoRK1GHUm2PV4rIGDevP
olksmn+uhAJN2GRHOL/Hq/vl7/jZoFECLP0N53r8vugNhagQbSSy9nBNAX2q3BVs
3bBdBq6cXOWse/neNK7XK55k+vMN8vwF0ysAWLcbYSMm/+qBUk4LNLa2InNNaRNK
1sb/6FHe4FCwZlAXa/63M8Wf9Cr0W8lek//59o+mJduMhGPkwYQtp9G1XDFBroAo
uhZKaMlmU8zWPF4XkxC7/0drlmypOYvLF+oHGDlCKGhTsVg/y7kTi1p7Vh0rBWCa
zijszfFXuLPCsakZ7E/1siFVmPbKWilatzHsQ25Hwyk70n/nzfdUga8t0jvN/+jO
cP387X9YrvoIIKoE3pdp+6iR3sn7aUPDE9YTPmfvn7ZpVkttYInloM1j6oroFIJF
kXYAKhP+WVaWDF6eH87McrAICb9M2wibVekwgMnTXhun47W2MNJj939iVCUyrtZm
EqGGtyoQZWsfQrTRzg21EDJJzz6FAI0E9heB+vB+52LdAuqceAUaNnAEYMZcU8Ql
ItY+AeyUY330n7RYI2tndKASGBaRgMrK5Z/z9wc1ce9s0VSFtflX6vENr+pN0hxI
tTsazI4vbM9SE7e6ep92p5zsDMO270g8fAoBjpSRHIMMiHKPuSIBM/UXUcRo9Ftf
MXtP4+mJoKV1V5GuHD1e
=meay
-----END PGP SIGNATURE-----

--Fr7jhMP26BSURKlp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
