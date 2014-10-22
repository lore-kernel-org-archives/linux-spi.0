From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: orion: fix potential NULL pointer de-reference
Date: Wed, 22 Oct 2014 11:06:03 +0100
Message-ID: <20141022100603.GK2344@sirena.org.uk>
References: <1413871068-32174-1-git-send-email-gerg@uclinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, karl.beldan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413871068-32174-1-git-send-email-gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2014 at 03:57:48PM +1000, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org wrote:
> From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
>=20
> It's possible that the call to of_match_device() (introduced in commit
> df59fa7f ["spi: orion: support armada extended baud rates"]) may return
> a NULL if there is no match in the device tree (or perhaps no device tree
> at all). Check the return pointer and set the local device data to the
> lowest common denominator orion device data if it is NULL.

Applied, thanks.

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR4GKAAoJECTWi3JdVIfQwAcH/3F/KKDjd2B4d33IRmkpPO2K
vf1i/1/50207cAr9zqPs2zQESB9mt7MzfwFpnlLTe1TZ9Dls1pqEBHlpUM5GHWUD
KjKIzZ+DCyYGQGvnh0ANZ4ovuiVZvg12/K0YwAHOuutt3Weuaa5fcO7MsFzNDoOm
wUHYMul1w8hyiDrmyrHO18jQRnFXQWXei+xAVn3cefHoc+u3zyTP/X4rPoehk7hT
RrDgFcaROWgKI6nAXGOntQz1wDpsQ/eQfDJr4gSIKCC0wxQ+fpMQMDocJJQ/Jvyd
rHJHIAtnRxqehK89FkDsrQjNRb5fGcFuJsN2uQ5JgdCeEFUoRUVafY/pZ3w3RbI=
=uDpP
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
