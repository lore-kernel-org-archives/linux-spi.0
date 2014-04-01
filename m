From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: convert spi-bfin-v3.c to a multiplatform driver
Date: Tue, 1 Apr 2014 11:29:10 +0100
Message-ID: <20140401102910.GI2269@sirena.org.uk>
References: <1396434021-13638-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wkL7YUqYamSjbA9H"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396434021-13638-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wkL7YUqYamSjbA9H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2014 at 06:20:21PM +0800, Scott Jiang wrote:
> Spi v3 controller is not only used in Blackfin. So rename it
> and use ioread/iowrite api to make it work on other platform.
>=20
> Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/blackfin/include/asm/bfin_spi3.h |  258 ---------
>  drivers/spi/Kconfig                   |    4 +-
>  drivers/spi/Makefile                  |    2 +-
>  drivers/spi/spi-adi-v3.c              |  989 +++++++++++++++++++++++++++=
++++++
>  drivers/spi/spi-bfin-v3.c             |  964 ---------------------------=
-----
>  include/linux/spi/adi_spi3.h          |  254 +++++++++
>  6 files changed, 1246 insertions(+), 1225 deletions(-)

Please use git format-patch -M for changes involving renames - it
formats things in a way that's much easier to read.  A straight diff
looks like deletion of the old driver and addition of a new one.

git grep also tells me that we need an update for the bf609 ezkit as
part of this patch since it uses the header - we need to update the user
at the same time as the header is moved to ensure it still builds.

--wkL7YUqYamSjbA9H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOpTzAAoJELSic+t+oim9LDoP/j4u48Ui+g3f4KnGyCep/iuH
h6vPSSzqjqWyhQ0QdG7VQFmBGvrz/lm5Wcfq4wDzLPGyr2Sa7GlmnQgwCBBHcDL1
HtJoKWtqJZDijAUnyWpiha/p5zTh/XQQpzSKTKcd9Oy/tR/+MftTFIol/VKACYwE
uen8K2bma6zgyeedoowKuYBxO4yomq07uZI4iKX6Pa+r0NW2fO7ooLnx7jmjkF0K
4wPTboeWj2Vnfp5ujMEFakoIfHjAtASbP0ypUKz/Uj6709xyQvWp/PRRz25ix+Nu
lejM5VmS92jx1vpwKBC0Njl7iDnkSIOMW9Skz8DX39lGBVKghiSeFXnwK6Tyx5ze
kzhf/cmzZBz6XOZJCn8ijnUXMeCGYQb9hh6KhIfV6GpVzmwGUoyBuPVPm6+NyXEI
sEh1gigEtbIqhRHQALNvN3T07h3+gEEOJPGfcGLBCnPQKq+sbFORMZ2FAOFPS5y2
b82xL07gb7KIbKyRn/VPaPPi+Wh1ux6o2OOQCd3SsdeyUTJIhRaT5hL/CLHWcpzx
EsU6ta5sKjO9wIM4gVXNkHUc0IS1vPEzBifyd9R/WkFwSHwuhk7bW6ZQopsYDWQP
GbTMZ5ijOS8yVI8VCbRZ/rLQ8OMBGJlgNCmuaqs8rT+qREiSk9vYjXEDsUwmeQag
1BQk9X0+yu/LgKA9ck+j
=fM1v
-----END PGP SIGNATURE-----

--wkL7YUqYamSjbA9H--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
