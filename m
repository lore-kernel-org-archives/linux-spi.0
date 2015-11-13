From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken (was: Re: m25p80:
 Commit "allow arbitrary OF matching for "jedec,spi-nor"" breaks module
 autoloading)
Date: Fri, 13 Nov 2015 23:14:10 +0000
Message-ID: <20151113231410.GV12392@sirena.org.uk>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk>
 <20151113225113.GJ8456@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1AtvaQRkIQxkm1Oe"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151113225113.GJ8456-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1AtvaQRkIQxkm1Oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2015 at 02:51:13PM -0800, Brian Norris wrote:
> On Fri, Nov 13, 2015 at 10:12:28PM +0000, Mark Brown wrote:
> > On Fri, Nov 13, 2015 at 11:40:31AM -0800, Brian Norris wrote:

> > > (Changing subject line, because apparently some people ignore mail if=
 it
> > > doesn't have 'SPI' in the subject line)

> > Well, if you mean me I'm getting CCed on such a large number of large
> > threads about MTD patches that only have relevance to SPI in that
> > they're for a driver that uses SPI that I pretty delete a very large
> > proportion of mail that looks like it's about MTD patch unread I'm
> > afraid.  It's almost all completely irrelevant and uninteresting to me.

> I understand, but I'm not sure how to fix that. In some cases, it's
> somewhat unavoidable, since there are series that need (or at least,
> think they need) upgrades to SPI infrastructure in order to support new
> things in MTD. But that's rare, and most of the time, people are just
> CC'ing anything and anyone that looks relevant.

Those I'm less worried about.  It's the serieses that have no SPI
content at all that get a bit much.

> Any suggestions are welcome. I'll try to discourage it when I notice.
> I'm not sure documentation helps, unless we can find something people
> actually read. And tooling doesn't exactly help, since
> scripts/get_maintainer.pl already doesn't suggest you or linux-spi@ for
> any of the drivers/mtd/spi-nor/ or drivers/mtd/devices/m25p80.c.

I get the impression a lot of it is "I once copied some vaugely related
patch set to these people, I'll add them to this one too" and that it's
mostly just about education.  I supposed I should write some boiler
plate to send to people, I've not=20

> General problem:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> The SPI core doesn't use the OF compatible property for generating
> uevent/modalias, and therefore can't autoload modules based on the full
> compatible property of a device. It *only* can use the 'modalias', which
> is a castrated version of the compatible property -- it only includes
> part of the 1st entry in 'compatible'.

> This forces SPI device drivers to use spi_device_id tables even when
> they might be better suited for of_match_tables.

Well, I don't actually see this as that bad a thing - it's good practice
to include the Linux ID tables even if you also support DT since not all
the world is DT.

> Specifics for m25p80:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

> We support many flash devices and have traditionally been doing so by
> simply adding more entries to the spi_device_id table. Recently, we have
> tried to get away from adding new entries and aliases for every single
> variation by instead supporting a common OF match: "jedec,spi-nor". So
> we might expect to see nodes like this:

> 	flash@xxx {
> 		compatible =3D "vendor,shiny-new-device", "jedec,spi-nor";
> 		...
> 	};

> We may or may not add "shiny-new-device" to the spi_device_id array. But
> "jedec,spi-nor" should be sufficient to load the driver and check if the
> READ ID string matches any known flash. If "shiny-new-device" isn't in
> the spi_device_id array, then we don't get module autoloading.

OK, so you're trying to do dynamic enumeration?  Then you don't want
specific things in any of the ID tables since you'll match it yourself
at runtime (which is obviously good).

> There's also the case of omitting "vendor,shiny-new-device" entirely,
> which is probably a little more dangerous, but still legal (and also
> won't autoload modules):

> 	flash@xxx {
> 		compatible =3D "jedec,spi-nor";
> 		...
> 	};

My immediate thought is that I'd expect to see spi-nor and (based on a
quick scan of the m25p80 driver) nor-jedec to appear in the spi_device_id
table since regardless of what happens with Javier's patch we want the
autoprobing mechanism to work for board file based platforms too
(there's a bunch of architectures that still use them).  That'd also
have the side effect of solving your immediate problem I think?

[Snip example with three different prefixes for m25p80 in compatible
strings]

> All three are supported by SPI's current modalias code, and so are part
> of the ABI. Thus, m25p80.c will always contain both a spi_device_id
> table and an of_match_table. But I think Javier's patch would break
> these three cases.

Right, IIRC I think that sort of thing was what I was looking for in
documentation for his patch.  Now you mention it I'm not sure we can do
wildcarding with DT which is a bit unfortunate for cases like this.
Hrm.  Not sure and it's getting late on a Friday night...

--1AtvaQRkIQxkm1Oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWRm7BAAoJECTWi3JdVIfQ+A0H/R5Lq9CeOUG8xrVElfs+Ac+G
0mk70Jny9f+zkIUXeRYlabuFXfv8oV2LmUQCRNo37WAb0BQ/UvGYSusPnHLwZxje
rQGXURULez34mZ1ng+bNwzHQvKTuZOezN34QTbVw03g6YadW4FwG+cs48SWLYx1b
ObxGq660S1uC5VaA4nsmuVdvlQhZIoknVlsNEJFSJeBlZsFhZF+RTH8nNqEiK+5M
EhJKvH/jbhstkxQ891SqF6/wQ++dfYrjoNHXDz3XYeT9DZxpS4gA7wuTIJ8eK/te
RysWMuCwhAp2Q80IJGrb3x0LwsnH/IeRri7UUMfsruom3s/EgYKaOJS375HNs7E=
=TNst
-----END PGP SIGNATURE-----

--1AtvaQRkIQxkm1Oe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
