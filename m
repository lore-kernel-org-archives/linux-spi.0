From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] devicetree: spi: fsl-dspi: Add cs-sck delays
Date: Mon, 6 Apr 2015 18:12:44 +0100
Message-ID: <20150406171244.GS6023@sirena.org.uk>
References: <1428093571-20407-1-git-send-email-aaron.brice@datasoft.com>
 <1428093571-20407-3-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JbRiNbyiMAY/EpXc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stefan-XLVq0VzYD2Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428093571-20407-3-git-send-email-aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JbRiNbyiMAY/EpXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 01:39:30PM -0700, Aaron Brice wrote:
> Adding fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay properties to
> support delays before and after starting the clock in a transfer.

Applied, please use subject lines matching the style for the subsystem.

--JbRiNbyiMAY/EpXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIr6LAAoJECTWi3JdVIfQv6gH/i0xHxLUbkZrAvBTSQ3zdOfK
nvQaEWRx7/hfSzRDrVZhvPmqFitJeQvBfETAOfNFxkWPqLYbW9kUHFeXsn3fDX24
8MvehsslK/4yLEhKC1ll7zgIdQTJsX5xGtxdHW72a/xksgVJKkQGnzte3vbcl22i
W1Bv1iiEOPbs3QRy3/qtNTK6kv5hXSCrLNTgInQTDb/YwJV63ZrIQ+nEYMsq+C3i
qJ0UglXRS3PqEX6nH3nXa6/sm0giTpSnuO+v/Pxd5+j3dZiG6rDanSA35RFwGSrl
/NvjlnTt5xyc1UOlcSOfkUVasJoftA6S/vTNTpO+1aWl2xl8teHf//rHHS5+bkk=
=54tw
-----END PGP SIGNATURE-----

--JbRiNbyiMAY/EpXc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
