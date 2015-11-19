From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Thu, 19 Nov 2015 11:40:57 +0000
Message-ID: <20151119114057.GN31303@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oWj5HoUXCVjyUFuT"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564D0098.4030107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oWj5HoUXCVjyUFuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2015 at 11:50:00PM +0100, Heiner Kallweit wrote:
> Am 18.11.2015 um 22:57 schrieb Mark Brown:
> > On Wed, Nov 18, 2015 at 10:19:29PM +0100, Heiner Kallweit wrote:

> >> There have been few discussions in the past about how to handle SPI controller
> >> limitations like max message length. However they don't seem to have resulted
> >> in accepted patches yet.

> > No, they've resulted in people writing code.  We've got a bunch of
> > things in the spi_master struct like the limits on speeds and bits per
> > word.

> Sure, I'm aware of this. To you it might sound obvious to handle such
> limitations in the SPI core, however there have been several attempts
> to deal with such limitations in controller or protocol drivers.

They're documented using terms like "limits" and "constraints" - it's
hard to see what we're missing there.

> >> Maybe a better approach would be to introduce a new member of spi_master
> >> dealing with controller limitations.

> > That's what we've been doing...

> Primary addressees of my comment were users of the SPI core trying to deal
> in their own code with things which might be better dealt with in the core.

Well, we do to the extent we can do anything useful in the core we have
code to deal with them - we constrain clocks and we have error checking
for the bits per word settings for example.

> In case there should be more need to reflect such limitations in spi_master
> it might be good to encapsulate them in a separate struct instead of adding
> more such members to spi_master directly.

It's going to be annoying to move everything over and TBH I'm not sure
it really helps much.  This is honestly the first time I can recall
anyone expressing any confusion here.

--oWj5HoUXCVjyUFuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTbVIAAoJECTWi3JdVIfQ+D4H/1Kvzg/gVzQiCTCMkuXmX3HA
d/V6dCj5lqpx/tvVRAm94e35qgwFIjZKX68py8Dlsseg0PBe13JR2KzS0eVnXsFj
EjUPQdhSkytEZU9BZ5eKP7RgrjiBM9rSIuBaubJIx2YDQds/gB4u31uToWIZnrTN
PSCxEUlrIKXjX+UzqVrrNEPSqD0+ZnEYfdxg2xcqcJH0puVupSLcruNlnCAtMP5T
1CKo+gVJ2aGhugRAlb2A60Aux0VTRX3lMhQQkkmhtoBPrHuGvZ3UV8gh6fISg3kG
KQTT27vlDu8TOBeeL6IfU9OOwvquB8L9TNxyqXrauD6U6SbWEy2LUYzL1sW78Do=
=/0Pl
-----END PGP SIGNATURE-----

--oWj5HoUXCVjyUFuT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
