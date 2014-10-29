From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] of: spi: Export single device registration method and
 accessors (v2)
Date: Wed, 29 Oct 2014 10:14:20 +0000
Message-ID: <20141029101420.GT18557@sirena.org.uk>
References: <1414572037-11306-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CLy2MrvMHpW9mjhY"
Cc: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Alison Chaiken <Alison_Chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jan Lubbe <jluebbe-H4yykcOXDpCzQB+pC5nmwQ@public.gmane.org>, Michael Stickel <ms-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alan Tull <delicious.quinoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Bohan <mbohan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>,
	Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>,
	Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joel Becker <jlbec-aKy9MeLSZ9dg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29Tb/PtFMR13I2A@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1414572037-11306-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--CLy2MrvMHpW9mjhY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2014 at 10:40:37AM +0200, Pantelis Antoniou wrote:
> Dynamically inserting spi device nodes requires the use of a single
> device registration method. Rework and export it.
>=20
> Methods to lookup a device/master using a device node are added
> as well, of_find_spi_master_by_node() & of_find_spi_device_by_node().

Why do we need to do this - I would expect that adding nodes would
trigger parsing in the same way we normally do it.  Where is the user
and how does it know that it's handling a SPI node?

This feels like there is an abstraction problem somewhere, whatever code
is supposed to use this is going to need to be taught about each
individual bus which is going to be tedious, I would expect that we'd
have something like the bus being able to provide a callback which will
get invoked whenever a new node appears on the parent node for the bus.

> Changes since v1:
> * Brown paper bug with parameter on of_register_spi_device().

Don't include noise like this in the changelog, put it after --- like
SubmittingPatches says.  Please also try to keep your CC list sane,
CCing random people just means that you're increasing the volume of mail
they have to process.  I'm surprised kernel.org accepts so many CCs.

I have to say I don't recall ever seeing v1...

--CLy2MrvMHpW9mjhY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUL37AAoJECTWi3JdVIfQGIYH/A5QRxNF6Y702k1x9f+6i2FM
3NW97Fh3F8FFzJ4ZkhzIvbJeDifru0aUFzucOku9JHnW5MZhU9bE2IfuOwinsipM
qvu+fo9yn7MVVk2Xvyq05gkz8Ckq8MuPdXGj94nYtsFPVYhWnAr/egVXqRdb2bem
pMc/YHfC74P3sv2QaoQF0AhA+tGvh3ZCocZPaKz7piqsrrLkotRG2tHDBDbztVvo
1t3yMJY4wztURF7DVCWjOw50/CEfwUEDyCER+FKgPTgn2T8DuD7Vn1XLRwDt72Sa
cua2SG4KOGNtzo//2MinVGYdEnzKOK/FoBsMzaidOWK/CXil3wR0R21F3l/yiBQ=
=D7UE
-----END PGP SIGNATURE-----

--CLy2MrvMHpW9mjhY--
