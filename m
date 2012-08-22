From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] spi: Master driver for NXP SC18IS602/603
Date: Wed, 22 Aug 2012 20:24:34 +0100
Message-ID: <20120822192434.GR7995@opensource.wolfsonmicro.com>
References: <1345305987-1954-1-git-send-email-linux@roeck-us.net>
 <20120822183230.GC7995@opensource.wolfsonmicro.com>
 <20120822191959.GA12403@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvDmwISikgK05D7L"
Cc: spi-devel-general@lists.sourceforge.net,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120822191959.GA12403@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GvDmwISikgK05D7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 22, 2012 at 12:19:59PM -0700, Guenter Roeck wrote:
> On Wed, Aug 22, 2012 at 07:32:30PM +0100, Mark Brown wrote:

> > This feels like the wrong thing to do here: given that the user needs to
> > explicitly ask for the device to be instantiated we really ought to be
> > one the right bus so this should be more of an error.  Not sure what I
> > can constructively sugget except for an error message and perhaps
> > returning -EINVAL though.

> Makes sense. Changing the return value to -EINVAL results in the following
> warning message from the driver subsystem.

> sc18is602: probe of 7-0010 failed with error -22

> I think this should be good enough, as there are other possible reasons for the
> call to fail which result in similar messages. Do you want to make that change,
> or should I change it and resubmit ?

The above looks good, we don't need to go overboard - so long as it's
not a silent fail I think we're OK.  Please send an incremental change.

--GvDmwISikgK05D7L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNTG+AAoJEFJkBDiqVpZ4XEYQAJYGKKZXUmg5obZkCl3b6auQ
qBncWjF61V7AEdqGdvWIgXDnMzExizKG8gjbm153WKJrVh/LjoxCadWOl3z5qUsk
jQ2GTxTqTso0MAyQpIe3kEDnLQxw6la1e8rJ1F4giMvufvo4BCFWMqT+u+tEjT4o
OFcaQPHXepbAs6fbsTo92nwO2oJ8VZYIXccaH/79IB8TRmONZ+FRmDNJyncr8LRK
VnhDBWySV6Pul0cQek27Qi7z7MK5Bbq8WcfWC50vb3+SyNGcnWvYUpqyt3qe36iV
cAIARyO7R67pjL6/zrK9c/kpSUu3HKQzfPxqd6J/+WJ+NoGQP+a9zYuLPYlsrfX1
PIzXHV9tIZB31EtlBTl3xrknj1h8/S6t+UoUOjuzl6skJurLY7ij0ZFb1tgAAOvk
pkJI6Cg8csDOgSFpXarVx3n2sOSYipD5H/YPCJW/7Xk03ExFsD8bBmkJecL4Vouo
He4jcBFzlW0c3gDZMMmFGbiJ0hgoDI3arIxAadRuSb0efEHH8FgLQqH0VXH3iS2n
++jHKEkLS60+Fx/4QTJsSP+SRsSW+n+LiOw7j+mP8YQA0i0V/ss23c9fvSI0En8q
mGw5mXVAPpEP0pNM7Tl5ddVQVnYcih08vAe66T98zkBcDkeA/Jmak9icSo5+xXnO
bG2tncIPG6PD12Jr5CqF
=Zynn
-----END PGP SIGNATURE-----

--GvDmwISikgK05D7L--
