From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Patch V1 2/2] imx: spi: read lpspi tx/rx fifo size in probe()
Date: Wed, 30 Nov 2016 17:55:44 +0000
Message-ID: <20161130175544.rdsl3wahswxewvyb@sirena.org.uk>
References: <1480302180-15550-1-git-send-email-pandy.gao@nxp.com>
 <1480302180-15550-2-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ycy3f3vbfmkunok6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank.li-3arQi8VN3Tc@public.gmane.org, fugang.duan-3arQi8VN3Tc@public.gmane.org
To: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480302180-15550-2-git-send-email-pandy.gao-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ycy3f3vbfmkunok6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 28, 2016 at 11:03:00AM +0800, Gao Pan wrote:
> The lpspi tx/rx fifo size is a read only parameter resides
> lpspi Parameter Register. It's better to read lpspi tx/rx
> fifo size in probe().


Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--ycy3f3vbfmkunok6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYPxKfAAoJECTWi3JdVIfQjU8H/0/R7Ar2zUQue4mcMA0UGQC2
445+ioD3DkD9V9QKRz3xaViX6R+wa7e1ev2EFfOXeje0qQOzXtvO6IXJpK4HaXBM
PM7ElU8WHi02gqxB94Da9PYTnwD4Y8wG1r5EIshUjQ3GLB7XLlw6v4XTse+OxCrg
3LfDfbzs4vhn9PtuZZucEr6cnQnR82YK1Ilp1NIJMHFf7dXsvuaY7uzF0XMaPbw9
svpjuK4CnXKoCty0D8xIFn2SrdPzVTg7KQg7CsVh2sQah7HBTEbOvcxTNzILFbDv
c3mWPTA474jInEdR8uYHSalS7P614fx0HyhD+XQHGtfxBZzBTiq0EsfV/qss/rI=
=zG4S
-----END PGP SIGNATURE-----

--ycy3f3vbfmkunok6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
