From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-sci: fix use-after-free in sh_sci_spi_remove()
Date: Tue, 17 Jun 2014 15:47:06 +0100
Message-ID: <20140617144706.GX5099@sirena.org.uk>
References: <1402929569-14500-1-git-send-email-j@bitron.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N2luHYDrPrGaLJcB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402929569-14500-1-git-send-email-j-dnHBHbooSPftRgLqZ5aouw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--N2luHYDrPrGaLJcB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2014 at 04:39:29PM +0200, J=FCrg Billeter wrote:
> setbits() uses sp->membase.

Applied, thanks.

--N2luHYDrPrGaLJcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToFTnAAoJELSic+t+oim9WJYP/1LC/kwx/8ki0cSdvjE4mgzR
zGhAHnKmIh6015AHxwaza6nJLbtmxnnlQKKgHEo5UAcYvKs26iKVxGZrIBV28zqO
PNufeWhfHQjfrqTFCueq9TCCQgCovKsVpcNvrWWhNrPkLxqT3Zg8PKcbd8HpdXMX
buSikY06kFm4KTyCXSw7jM/CuhfoB/5Dq4eLzTMDU1selVFc7IFWTBMm3pgakK+9
VgTAAKTZVpCP1q5Rm40nqBiUsjYjb4iYNGbH34Gm3BhrENy+HgzDvfMGL3ZSxXVV
i2fgbffgR6Pc1S9yPN/hfcacb8uc/sd+Cj+FwTWU+VSqZ2s8RtqqVMQxIwprIb+I
rRFqeR5JPQefNwCAXgIw1aaRFfD27p5YoKOY8F/j6C9gVSWhEqe7BweuwX5TeUpr
7k0ugriDylAg4mMVvOdiJHPF3zck/xImQGKvoa7u6D8oLl1zAgy7u/6FMtYD98l+
sdsWUou4fd366yhQJD3HW74rq4kj4kDP6qD4oIw790ov4jLTYai2h07H2cATb2EL
pZq3eQsR9cdQSv6TOO5ohY7ooFl3PZrEg7kz6BgVG1SytfuRMRX6H4Ww0Eap9O1i
n9qJ5WehP0EYUwv6VAA9umiRjGuaPtTB6/VJPlWNYxvxriTwBC6h1Gll4z4dCSNv
O21XiNl895AQRCKue6aZ
=NXX+
-----END PGP SIGNATURE-----

--N2luHYDrPrGaLJcB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
