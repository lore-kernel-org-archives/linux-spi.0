From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sirf: refactor spi transfer functions
Date: Tue, 15 Apr 2014 12:40:27 +0100
Message-ID: <20140415114027.GT12304@sirena.org.uk>
References: <1397546700-21605-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nDmTXYS4kVhtHHfR"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397546700-21605-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nDmTXYS4kVhtHHfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2014 at 03:24:59PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> split sirfsoc_spi_transfer function into 3 sub-functions:
> spi_sirfsoc_cmd_transfer, spi_sirfsoc_pio_transfer and
> spi_sirfsoc_dma_transfer.

Applied, thanks.

--nDmTXYS4kVhtHHfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTRqoAAoJELSic+t+oim9FrEQAI4rrc2uO45s3I9bsNgCqL2W
QXYtVChClSaPPuw1mieCx97hlGOPyAN0lvujSQky1xjlvv7QC8KTeG8xPGJjNq5M
PEX+tQqjt6mqBA3A9RBwIiQyDJbRodTGQvOJ9iZAtRhGkFA5AHHMlEfNoyKZZCeR
qLZ874BdRm5k5f5e24apss3s0WUyi+yqldLKluPnAtFvj3o8MeGbN1V4lT4eJ3Sw
bCGoQfDBBGLsaeTrVMji73DR0SYZw4guxeSTOqoeKr22pRTyN4uAExPzaT6r1KLD
4jPOWCKv15GrQfxbYt9u0Z5oYOFAPpG/pZ4ryvqncofNHOgkj3gb20+Z3tYCJt7D
K62wxb2bh6pChHaulMl3XwNbmnPP0uD87MSqzfZ8OdNBGlEbsMSAkkN+mLVsJ6i1
Voar6aqe2a1dVsElcKsEc4OOFJvZIfexC4jjv3CHdvXQrDH486Vq0sZUdcieHfX3
+OqP2msibGB4LOlFB8ekcRI6YLkzgMHEzGE5ptBNQ+3WM5bO8Qtffv8Up1RHSrBg
AdSqzhZrS8nbqIofL7U7dMQzVUDmev44qcL2Mc9bzVeFbGYWj0HT4jKpJznRcqjB
sU64B6TDQ62v3bWS4qmB4Gs22y18y3f2iPITQ63SIo3/1bE6o8QSSEvJFsBSFqK8
I8VtVXAEXfHDF5DyX33e
=9Pd4
-----END PGP SIGNATURE-----

--nDmTXYS4kVhtHHfR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
