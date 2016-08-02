From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: octeon: Add thunderx driver
Date: Tue, 2 Aug 2016 22:30:18 +0100
Message-ID: <20160802213018.GL10376@sirena.org.uk>
References: <20160728083144.16625-1-jglauber@cavium.com>
 <20160728083144.16625-3-jglauber@cavium.com>
 <20160801172838.GW10376@sirena.org.uk>
 <579F958F.9020508@caviumnetworks.com>
 <20160801184931.GB10376@sirena.org.uk>
 <579F9CDE.5050207@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bEAlbH1hodbw2omC"
Cc: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <579F9CDE.5050207-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bEAlbH1hodbw2omC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2016 at 12:02:54PM -0700, David Daney wrote:
> On 08/01/2016 11:49 AM, Mark Brown wrote:

> > What is that thing on ACPI systems?

> I don't know if it works ACPI, or if ACPI even has support for the clock
> framework.  But does it matter?  We are not currently using ACPI on systems
> where this driver is used.

> In the future, if we ever need ACPI support, we will add support for it.

Oh, that's surprising - I thought these were server systems.  With ACPI
you need to use DMI data or something to instantiate the clock.  In any
case if you've got it working that should be OK.

--bEAlbH1hodbw2omC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXoRDpAAoJECTWi3JdVIfQxg0H/3AwKbCO2lilvE3AVlD027mt
IjJhm4QvhCHgapSl4J6QjcDDJ45L8o6iDvtJtdtNwt9WEStqA0ItNYKPOE1vtP8R
Pqxo3zRPz2JUfJUNtKki4rHgxbnsNkqmtViVUogstvu5hH2O7EsfNgxhujIulggz
wrgUo2Pdopmu5azjqzNPDTiihAZlr8ZHEIkkzzjLwNTun0PK+K6+gVh9cdga5pK8
JMHKCMePZzg9p7gC4WvpKqiiTl5uOsvGy3Up98gOOAE5bxRrD2ajq7unPv+1mtCq
kZEC/lgropxygR1pbUJoMGo9Kmx1GPkVQxj2M+93ubFuBaUah9AELZwlLgu0Rik=
=78aJ
-----END PGP SIGNATURE-----

--bEAlbH1hodbw2omC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
