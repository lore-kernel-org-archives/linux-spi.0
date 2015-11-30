From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: core: add max_msg_size to spi_master
Date: Mon, 30 Nov 2015 16:42:23 +0000
Message-ID: <20151130164223.GE1929@sirena.org.uk>
References: <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk>
 <56507B3B.4080608@gmail.com>
 <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
 <5650F7D4.1090209@gmail.com>
 <20151122131626.GN26072@sirena.org.uk>
 <5651EA08.5090400@gmail.com>
 <20151123113846.GH1929@sirena.org.uk>
 <5658AE7C.3050507@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tk7bxryrhVQGv1nz"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5658AE7C.3050507-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Tk7bxryrhVQGv1nz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 27, 2015 at 08:26:52PM +0100, Heiner Kallweit wrote:
> Am 23.11.2015 um 12:38 schrieb Mark Brown:

> > No, for the clients so they aren't peering at the struct.

> Sure, do you think of a simple getter like this or a more complex thing?

> size_t spi_get_max_msg_size(struct spi_master *master)
> {
> 	return master->max_msg_size;
> }

That's fine, the point is to allow it to get complicated later rather
than that we have anything else to put in there right now.

--Tk7bxryrhVQGv1nz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXHxuAAoJECTWi3JdVIfQhz8H/j6Q8safY93quZf53Pc3ZifY
MebdOPRqkXqW4jqJbDWJlMZWQxQT9GN8pX2jXpJ5ET+uuve6AnBKBZF2aTKOWJBK
XxSAEkIywhVmrjOv1ihsvjx6rZe+hKrBrXC/I7p0Krxzlq0Kv3rUsK0J/51E7+jZ
Cu73/qRyGc6/Y1tWhH/25UFL6ii0YyPRC9SAaxiuxYTmFcQh8L+vUgdSGHpuqptX
uhgP0bBCEUSj0yZZre2ZUkd97rO2ZN7hqgoWf+1pGUrkDDBLkoUWav2Gnhjqp35h
Er2+pA0iH7xQSHeAWa0m0tswxRvLvmJshHMxhaC6hbD/e2FWhqM/8hcFRxNhpPI=
=pmZU
-----END PGP SIGNATURE-----

--Tk7bxryrhVQGv1nz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
