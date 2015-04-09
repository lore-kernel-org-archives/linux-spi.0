From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/1] Fix NULL pointer dereference
Date: Thu, 9 Apr 2015 16:26:49 +0100
Message-ID: <20150409152649.GX6023@sirena.org.uk>
References: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kqMyilcFgfUVP095"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428591822-24279-1-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kqMyilcFgfUVP095
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 05:03:41PM +0200, Pelle Nilsson wrote:
> As I reported earlier, spi-altera driver is broken and causes a kernel
> panic due to a NULL pointer dereference during first SPI

Please don't send cover letters for single patches, it tends to mean
you've not written enough in the commit message.  Either the mail is
redundant and shouldn't be sent or there should be more in the patch
either in the commit message or after the ---.

--kqMyilcFgfUVP095
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJpo4AAoJECTWi3JdVIfQTWoH/RSh/God43IjEAlrM9M1Ibou
pJS9mw1tBhNaPjvp4dMmZ7AsGGjTCnNriRZ4F2bGj5YfUz2Vz4z/jxDF4dVkVv//
mGm+YKFjoaUyyV6Orn0KqZLVogDPm9KKnEvSpUwx5/WLzrGa1mv9cxBwA893lC2g
gGdY0YK6+/mfaxdfytMO2KP5ug+k5n/6fofTW0F//df0xBVIzs+nqzrEO0NdV423
Czll51Co98xLOags07p6bT/oQnVC5medAsCpziGg9P4nDRX0yTRk5Nf4i/VRyv+c
asluyrgT0uhRPeId2yV3IuuRRY/3Bph512g0+mD/Sq8YoHWyHNZa84iqVA2lJSM=
=/6DO
-----END PGP SIGNATURE-----

--kqMyilcFgfUVP095--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
