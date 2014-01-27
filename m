From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] spi: correct the transfer_one_message
 documentation wording
Date: Mon, 27 Jan 2014 18:45:17 +0000
Message-ID: <20140127184517.GI11841@sirena.org.uk>
References: <cover.1390681463.git.baruch@tkos.co.il>
 <c3cea38bd5e725eda84a72e5c9af9d0e66b48a5c.1390681463.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c3cea38bd5e725eda84a72e5c9af9d0e66b48a5c.1390681463.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 25, 2014 at 10:36:15PM +0200, Baruch Siach wrote:
> The transfer_one_message callback handles messages, not transfers.

Applied, thanks.

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5qk6AAoJELSic+t+oim9s6EP/3u6UFXvJYe4qJFLZGXzw0DW
SPG/nkoH1mFNMPtxb3HPbgEYp1AGbMtJGmhBaT+5aEzEkcRwGwclfUZafKkTH9Jy
dVysiWtjA6yOILc/RZ1c2Hq8V9+qsGud6Ghi2jLDRs6gB7tqHkxETqrdVTfqyz41
ydWXTDRkOT3PHApRCIi/0n7yJacavCD4ACS2wk82A2ao9WHs3wswMQNAwhsLWC1g
L2XyHofvY+mVSX8L9tvbV7UP3aLnuAK4qEzyadBfjzNzgc4bGqP1xvyjXGcBqX9V
gMasSvL4PTrYc9UnZPd9Z1i/mr2zJU1/jSX5Ga/ft2qE/Q0U/HPCW6LYxXhY07tP
Bc5zQrv3tPa5XPlKI/d2Nx1Dyil3jnVwmGYvkPBmy5esZzAQ/wYX+K+F4MgwMtSX
fQWODLNR4tGzsdzN9F3qZYTFGOydZydVAl/wVnDuZZFYYXi3/CF9f7nfUD3CnB/z
RkFXW/fT/mzpZJatbGp9/A7I7Du2ExHMNuRVh+VoN5B1eDfPEcOhkdDpzSaHh2f8
gRWcpWDcAowuU7gE+KC1HBxrobRhQzbZHMcd60lSkUFZDKAPMjQMPAe49qWj0qpF
L/ItDB78vTq0MkllBGTHJaoZIm7RsYzAXblijom+O/DMXPX7gZk2e9Do2BzCLzbw
oM5vFbJnGRdT+r3sfzQl
=Ysy0
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
