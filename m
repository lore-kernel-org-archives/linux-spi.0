From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi/ppc4xx: Adjust checks for null pointers in two functions
Date: Tue, 17 Jan 2017 19:37:28 +0000
Message-ID: <20170117193728.gtgqotjoaelgu4sl@sirena.org.uk>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
 <d9bd24b0-d4d5-233c-756d-71aaed63c5ef@users.sourceforge.net>
 <20170117183411.7isqrvu3o55ydjcb@sirena.org.uk>
 <20ac3577-3b0e-e7d3-d5de-8e511a6e9fd2@users.sourceforge.net>
 <20170117191101.ndcmoafymhqixwnv@sirena.org.uk>
 <2eb15f70-ecac-fafc-c2b8-323e1b9381f8@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gkd7lde2yy7kbo7k"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2eb15f70-ecac-fafc-c2b8-323e1b9381f8-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gkd7lde2yy7kbo7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 08:28:12PM +0100, SF Markus Elfring wrote:
> > You've got MIME headers in the middle of the patch description.

> The extra header fields were automatically added by the tool =E2=80=9Cgit=
=E2=80=9D
> because I dared to use an Unicode character in the commit message
> for this patch (and a few others).

> Would you like to change the mentioned implementation detail at all?

Well, I've deleted the mails now so...

Better yet would be to send patches with a sender address matching the
author information in your patches so they don't get any mangling in the
body at all.

--gkd7lde2yy7kbo7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+cncACgkQJNaLcl1U
h9CpIwf/e3FbF8Ljr5IDaQIIbKy0tHWitWKRLqsVNLE9OEDqNCoV4EMrAVUgr1zW
LRvHBnwKGFac+LhlAqD3Ypn+sH/2rWKagesu3WMywGZZnXZAcGNeMWZnXgggV/oF
KMldtxRUr11WO9JUDFgQ9bzpkQy+GYhtYVbLpXaqhzoeGbQEerjxt+5OsQSgEH8D
/6IoTKmbauiX+cEttffqCyOptwesY1RfhUdl4DOKjGhY+B+N6SIw7QZ+qZ3dv6w6
4H6HS8FJBHF+TYkdTsLLpU56yPIgwDDq9ydLOgEAEWs/gPlDNS+vLFQ93zu6F/Ho
Gs2+wjUu1ggEzAWZp7pu75Af52SPrg==
=ZJEM
-----END PGP SIGNATURE-----

--gkd7lde2yy7kbo7k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
