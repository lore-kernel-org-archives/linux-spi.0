From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: added spi_resource management
Date: Wed, 2 Dec 2015 13:32:32 +0000
Message-ID: <20151202133232.GK1929@sirena.org.uk>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
 <1448888695-2260-2-git-send-email-kernel@martin.sperl.org>
 <20151201210410.GU1929@sirena.org.uk>
 <56C9120A-8979-4156-B3C4-5851D695BDF0@martin.sperl.org>
 <20151202122953.GG1929@sirena.org.uk>
 <565EEC58.4040006@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5HZuAPtaWzuxXW8L"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <565EEC58.4040006-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5HZuAPtaWzuxXW8L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2015 at 02:04:24PM +0100, Martin Sperl wrote:

> The bigger question (based on your comments to Patch 2/3) is:

I haven't even looked at your reply ot that yet.

> Do you want to follow the devres approach (i.e: hiding
> "struct spi_res" after allocation and returning "void *"
> to the data-payload only in spi_res_alloc)?

> Or do you prefer to have "struct spi_res" as an explicit member of
> a structure (i.e. in Patch 2/3 "struct spi_res_replaced_transfers")?

I wasn't aware that was an issue?

--5HZuAPtaWzuxXW8L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXvLvAAoJECTWi3JdVIfQ448H/jsZGX6mr5zLgx/TmoMxktkq
afU2xDsDjNdWZLqk2DO3R2AnO367CHeBfDD61u+/q0xr52eHQo10BKzpIB/7sLHe
EKG1wXUxZvDkdv1A5HmrCt/EoHGiJoABNIsz9JsbfTI3pxOn25b+wqYL/NglleD+
8sPY0lPDuFvIgGvQORCXJ4p/Vdw2Uv0msSljmQbYh7LwYD37viidUOZ3Fmfa5qFb
wbdFwKNTNuurHB8TOSCZL0QjBBCa5ifLN1bIFj1bDMpaphaR/67miJK8IzEyFWk9
mTdshQ6PhA5y/q/Wf1ZfL5tfkCpgOE338oZxy0Cl7Q+gs3eata87baAQ4prGls4=
=b+/7
-----END PGP SIGNATURE-----

--5HZuAPtaWzuxXW8L--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
