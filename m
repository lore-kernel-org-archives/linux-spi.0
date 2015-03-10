From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Tue, 10 Mar 2015 20:47:50 +0000
Message-ID: <20150310204750.GR28806@sirena.org.uk>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
 <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
 <20150307105948.GD28806@sirena.org.uk>
 <1425889415.2440.10.camel@mm-sol.com>
 <20150309182841.GW28806@sirena.org.uk>
 <1425975056.2440.24.camel@mm-sol.com>
 <20150310110638.GD28806@sirena.org.uk>
 <1425991997.12581.1.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QLqFJahxFu65lVwk"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425991997.12581.1.camel-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QLqFJahxFu65lVwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 02:53:17PM +0200, Ivan T. Ivanov wrote:
>=20
> On Tue, 2015-03-10 at 11:06 +0000, Mark Brown wrote:

> > I'm sorry but I can't parse the above.  What does "they could issue
> > setup method" mean and why is it a problem?

> Client drivers could execute spi_setup() in probe(), so we have
> to ensure that CS GPIO's are available before this, no?

I see.  Yes, that's a concern.  It should be in the changelog.

> > > Requesting GPIO's in core framework is also not a easy
> > > option because of arguments here[1].

> > We should really fix that though.

> I think that pinctrl framework should automatically
> request pins belonging to group when state is selected.

That doesn't help users as not every GPIO is associated with a pin
controller - they'd still have to handle the case where they had to do
things themselves.

--QLqFJahxFu65lVwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1h1AAoJECTWi3JdVIfQHIkH/jwhurdMF4W13lHvE8vDWpwi
lo7kaqGpZFj8SmBnVTxE1p7JYr197/VtMOgwUu09cMKugLGR1zn2QU0jPTqnxare
5LOPdAzg1/W1fbvlp4TXMGJ4YjslKj1P0tC0yrjdlOlrNnZAM64xLZAQh1MbJT5q
QCC3O5alyUg2JwD6hFbBMbOFZ5pwOVNoqyUDSMXmgFXRXA/KrXeQa11pv+dHUHsE
akw6OvDz+3DLjKZbNannrCPCd35x9l5yL7HCj6hBZvLKAd9RoFllNw5wYe8CieOn
j2kE+JN5jQOEK3J7eGzX/9kwWyHzRDLxbPZSUUE16WWIKpbVaLEf/JiIHvR+bzI=
=R5P+
-----END PGP SIGNATURE-----

--QLqFJahxFu65lVwk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
