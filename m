From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Fri, 19 Jun 2015 11:10:46 +0100
Message-ID: <20150619101046.GH14071@sirena.org.uk>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
 <556EE446.3060407@metafoo.de>
 <20150603115319.GF14071@sirena.org.uk>
 <8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
 <B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org>
 <20150618134918.GF14071@sirena.org.uk>
 <20150619113539.04a7fcf2@north>
 <20150619095346.GG14071@sirena.org.uk>
 <394B0003-AA2E-469F-AD9C-C291FAC60A94@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bRe6i2dqfB5QRoX4"
Cc: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <394B0003-AA2E-469F-AD9C-C291FAC60A94-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bRe6i2dqfB5QRoX4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2015 at 12:02:22PM +0200, Martin Sperl wrote:

> I got a patch in the meantime exposing the following files in
> /sys/devices/platform/soc/20204000.spi/spi_master/spi32766/statistics/:
> bytes
> bytes_rx
> bytes_tx
> bytes_transfer_histo_0-1
> bytes_transfer_histo_1024-2047

> If so then I would post a =E2=80=9Cbasic=E2=80=9D patch for the other sta=
tistics
> and have debugfs for the histogram as a separate patch.

Either approach works for me, though I suppose we might want to bikeshed
the naming of the histogram files above (but I can't think of better
ideas immediately) and I guess from a user point of view getting the
histogram as a histogram might be more helpful so people might be
happier with debugfs.

--bRe6i2dqfB5QRoX4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVg+qlAAoJECTWi3JdVIfQs7EH/iVMiIe/9PUDPbw/+pPHaBm8
kMXOznAgJ+YoZHM0Vj9oxw+Pot8SMPhysHZzH4+j3K2h8mFK+l8qNseizc+SH7oj
zQIcsC/o8xzxHwIVfx7U1mS6mxeaSTrP+Up0hhndlArqlCTACstBkxfOacxV9Dhr
pI7NikQFg4uFouN/txIFEL12Rrp585JYupkpTufSqZZRRb14LMtUWkRFPswnDtox
0M92LvvuTCdQnKeba7qMvaJ6qJaIoyHo9UiAjqzXeVSBKvYANOy7PeakLe66Z0HQ
HftPdkUKL8pH9IHplszVzZF+AgVS5g2olYEE1BLQaM3DKwRB2U8Q17gRv3RojdU=
=f+Ih
-----END PGP SIGNATURE-----

--bRe6i2dqfB5QRoX4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
