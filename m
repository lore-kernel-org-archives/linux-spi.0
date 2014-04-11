From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi-atmel: scheduling while atomic
Date: Fri, 11 Apr 2014 17:22:23 +0100
Message-ID: <20140411162223.GG28800@sirena.org.uk>
References: <1734135.RAAc8zgbc4@kongar>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexanders83-S0/GAf8tV78@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1734135.RAAc8zgbc4@kongar>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2014 at 03:25:43PM +0200, Alexander Stein wrote:

> Currently, I can't figure out why this happens. It's a plain v3.14
> kernel with some own patches which don't affect SPI.

It's because atmel_spi_lock() is a spinlock and we're waiting for the
transfer in transfer_one().  Either the scope of the lock needs to be
dramatically reduced or the lock needs to become something we can hold
while scheduling like a mutex.

Converting to use the core transfer_one_message() would also help, we
could then return from the transfer function and have the core implement
the wait for the completion.

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTSBa7AAoJELSic+t+oim9ZQwP/iMVCz+BnSKZrHwCsZxPe02G
Mj4i9+jGsT0vFt4ifpRk4yb0O+9FWDX4h44TI4lpERgzuv6sNB04a98HQ8Oif7lq
nUyMOxJRH8u76R8zhIon1MqgbtQ4MAcWYgNkd3orpig0vYetzU1LpkCLwGW0BRP7
boOYwg/JmaBFU7sVSSbxdrQ12gpbsZ/p7fOW397zxX4uHyIs/IXIitfeCIzU5ZE5
ocoTQi/ZjBR7j8uf3AVJdm5dXcm6DnQ/wyyzj+3WOFvA+Xt+sDVPeo3Eb6U1mTqR
Odx4zjjGNuaFT7+9IdQBadw0tdbpfGCtvHnifaE7JxlvwAATa44qaVJ+2T8BjQc5
EMnewU/iv+OxQekuytqWhj1mkboLhhkU2SHd4Q3HXIMpjSYj8u+Y59VZnnz+B8Zn
spNVY8/5zDGuwkAWRwO4A9DRLyTGlwBd0DdH9wOay1UNWBWqrRx3dUrrNs4YKSOQ
pLxtC7PzG1itl0vn2hNr5PcQ2EFC6ToQnnGjWupAKXUKPFb251tmCrzfVqHh9S8l
ssVhnPowpsDj1GUTvL8w/w3JL3VlZIFuhlVWMr1Z9V+r/Djja8Uh+smXAiWJnuox
Sc6E5MKjoIMy86vmVzeuNLJ3dCUVcR+0XP+sQjA6PWnPHmYw0ZJ32PwFc5AGAkRW
SV4tV6TkULISMQAH1v/Y
=I1mL
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
