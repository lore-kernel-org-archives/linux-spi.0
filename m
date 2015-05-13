From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 19:51:49 +0100
Message-ID: <20150513185149.GL2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513171300.GD2761@sirena.org.uk>
 <20150513172028.GA18303@kroah.com>
 <20150513173922.GF2761@sirena.org.uk>
 <20150513181631.GB16811@kroah.com>
 <20150513183211.GK2761@sirena.org.uk>
 <20150513183653.GA879@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="171LwGa4zcdgM9o6"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513183653.GA879-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--171LwGa4zcdgM9o6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 11:36:53AM -0700, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2015 at 07:32:11PM +0100, Mark Brown wrote:

> > Oh, right.  For this to be useful here we'd need to implement a new_id
> > file, bind and unbind don't do anything helpful here.  I think I'd have
> > expected this to have a default implementation that non-enumerable buses
> > could pick up.

> No one has ever asked for that, so feel free to make a patch that adds
> it :)

Maxime?  :P

--171LwGa4zcdgM9o6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU51EAAoJECTWi3JdVIfQJ74H/RbRvxn2z64mrExxhK9OccZG
l5IVBWL37AcF10ku12rjozBowF2JHcbgyvfsbVyToLP9ReFRREXe2lZIpNx7I3dx
SxoJIjRnQz1KdmX1mOKaPg/+lQc0EXZ0SALHIzcH000Ydhe7dsY+7BOdKDnLRcka
N2kdh0W2x7dETBHpuCOwZ21WSfqDeawbC3m8VTcbhUREtDQTt4oYmzO5XaDiENK0
R+IBV8Z98ZSlk8fHARg+DPvw6PJMMfvMj0T9iWd/8cd/muuC2c9Ks9j1FYdXNLxB
8LYfDrhlwjShQVtLnQe5ISlCCpMML4ucD7XwdXeDI0WvXnqopEJDS6IH9VZvi0s=
=p7MW
-----END PGP SIGNATURE-----

--171LwGa4zcdgM9o6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
