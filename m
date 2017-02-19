From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/6] spi: davinci: enable DMA when channels are
 defined in DT
Date: Sun, 19 Feb 2017 16:30:52 +0000
Message-ID: <20170219163052.hfs37ljvnt6sduai@sirena.org.uk>
References: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
 <1487327904-28311-3-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yfgxnfdgjsmlcabf"
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487327904-28311-3-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yfgxnfdgjsmlcabf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 11:38:20AM +0100, Frode Isaksen wrote:
> From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>=20
> When booting with DT the SPI driver is always using
> the SPI_IO_TYPE_INTR mode to transfer data even if DMA channels are
> defined in the DT.

This looks good but I'll hold off on applying it without patch 1 in case
it introduces regressions for existing systems due to switching to DMA
but not handling vmalloc() mappings.

--yfgxnfdgjsmlcabf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlipyDsACgkQJNaLcl1U
h9DDNgf+KStEA8hg+Dphujo3Smr/aeduLWJvNzz31LOB2L0eE7On8L1dLEcVZUSD
2ltqshN9J6MR4Q1oXfkxtvQR0hrFpu3pQa2RYNW2Isc8HBSI/m3gOA7PSWX4x6sn
QBMWhADNSiwKbXDTWntfPL2IqMY8zId9OvF/Yb6ucAVI0HL2HhaRs22cNCprNqhG
Wo4BPWF3772tph7zjv5+Hnxa18fN4Dvpb4I2d7ydvhamw57Ri5U/lemB8CC4sMTh
h3IPjpc7qCPH0rUqwoY+Q+uX8CctY9h3bBgD2JfTzX3Jiu7wN0MyCQO0NgM4jltk
/xg/IbvWMYYDkAjiaSgBq6VFpE+J9w==
=N2B2
-----END PGP SIGNATURE-----

--yfgxnfdgjsmlcabf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
