From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number from
 DTS
Date: Wed, 19 Mar 2014 10:37:28 +0000
Message-ID: <20140319103728.GX11706@sirena.org.uk>
References: <1394789757-40732-1-git-send-email-B48286@freescale.com>
 <1394789757-40732-2-git-send-email-B48286@freescale.com>
 <20140314191922.GA366@sirena.org.uk>
 <c4b28b01b2f544ca9d264eaee2542257@DM2PR03MB301.namprd03.prod.outlook.com>
 <20140317130109.GE11706@sirena.org.uk>
 <9186860716f446f9a5773e7e47d39114@DM2PR03MB301.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uR7YiQvNOb/8Y6Dg"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: "B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9186860716f446f9a5773e7e47d39114-ufbTtyGzTTTk7ZsBhlipOOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uR7YiQvNOb/8Y6Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 07:40:28AM +0000, B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:

> > You are adding a property to specify a bus number.  There is no reason
> > why such a property should be specific to a single controller, every
> > controller in every system has a bus number assigned to it so if we have
> > a way to specify one controller via the device tree we should have a way
> > to specify it for all.

> The reason to specify a bus number to a single controller is to avoid=20
> allocating one dynamically, so we know the bus number before booting up t=
he
> kernel. If there are several controllers, you should add this property to=
 all
> of them. But it is unnecessary to add this property, if you do not care a=
bout
> the bus number, and it will be allocated dynamically.=20

Please re-read what I wrote above, you're completely missing the point.
The problem above is that you are adding this in driver specific code,
even if this is a good idea there's nothing specific to this device
about it so we shouldn't be doing it in a driver.

--uR7YiQvNOb/8Y6Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKXNkAAoJELSic+t+oim9cqcQAIEZJ13/8vKnoNlq+4iIi6JI
4lipNvyaoGdKAeIWVl00ZxFpvKHTlu+ya2r0ijHoUl07MEmdSAxTrOsG5OjaK5zO
KVJlT6s9SXrutCc4SoC/CK2QY7MRCGjj8V0Kn1+ncRr8lM5jmh2ARo0K7f1VeitP
aIhUhLxOx6qX81xfAP3pXWRB53X//Uusq7Y5f7S+cRCVuIZFwhKA26vDMmUwHlnG
f+gLIy76U2eUXwpvO0DZ6r5wgm2Tt9XSafafWXrKfoLqVNvYhda94DO9QDtS6SGX
wGBwFGtI8l+b3xm5GorTt3Zmc3f7xIh9CCHQOPlEbzTcD2n1fhA/daZWKFm7A+oH
8PF7pnjYxT29NjraJXAKeXcszcxr3zxudiFkvhzYSanbp1PAOaUWpM0scapWj2zF
RMUMs9F1du+e8ACyAZgF2e3WZPA69KuEjJqUjqWVgAjYDKrMyxd96Xh9F1+yP42w
aRL4NOZwwWJTxuJNPs40mP3GonRGBvSliREAi2X+9SNFrsjsBQ7k8QP/epHkpF0y
8JgOGk3nvoCDI5xzAuQXzP9xmf+/zG6y7iPw3ZIMrcC3sEes5J81rmFiXALzDiKx
/o4arhxQjFwMDoreyVj3hM7B3PoAT7eHa1WmzUaMtYcZ32PeGiDYIPpGTy2neaHW
SzpOccsRU7kjL/C7YyMt
=5Juc
-----END PGP SIGNATURE-----

--uR7YiQvNOb/8Y6Dg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
