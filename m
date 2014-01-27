From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/5] spi: dw: document device tree binding
Date: Mon, 27 Jan 2014 19:22:51 +0000
Message-ID: <20140127192251.GP11841@sirena.org.uk>
References: <cover.1390723880.git.baruch@tkos.co.il>
 <211f8d2101fff1790526f7dff766d0d9efff9280.1390723880.git.baruch@tkos.co.il>
 <20140127190839.GN11841@sirena.org.uk>
 <20140127191810.GV5596@tarshish>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fjEAjMKpll6GDq3U"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140127191810.GV5596@tarshish>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fjEAjMKpll6GDq3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 09:18:10PM +0200, Baruch Siach wrote:
> On Mon, Jan 27, 2014 at 07:08:39PM +0000, Mark Brown wrote:
> > On Sun, Jan 26, 2014 at 10:14:35AM +0200, Baruch Siach wrote:

> > > +Required properties:

> > > +- num-cs: see spi-bus.txt

> > Why is this mandatory, in the code it was optional?  One or the other
> > ought to be updated.

> The code defaults to 4. I guess that's what the hardware this code was te=
sted=20
> on had. But this default doesn't make much sense in the general case. Any=
way,=20
> for backwards compatibility I'll document this property as optional, note=
 that=20
> the default is 4, and recommend to add this property anyway. Does this so=
und=20
> reasonable?

This is a new binding, why would it have to be backwards compatible with
anything?

--fjEAjMKpll6GDq3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5rIHAAoJELSic+t+oim9O2gP+wfr1+xl1KWDyIz1Uc0ppRbH
lnp/njldUbx4mBJ1rOmOK7pdlqT3q9owvhLktIYZqMWDMI3lLvoDFi9MtZQJhjPY
/bFOLNsmwsYAhffHxlPrUHy7vIl2zJ8LRb6IEqmhpHeEQEi+YugqAdu7QYDrRlID
tSblC72MbqzkPZLi/3jtEQPmbljK9yz8yZYyPGiW6Rxb3s0a/jz4yNYC5I1PtAte
rBCCv0xKnHygE8jvwwpUjVh5erV6aa62Ez60XpsDqP2nafJTOgiiN4JFHZxZ4tWA
8+Zhto/4K1UN35ZBbNQ1QDzffIZ8MrJlJ78JXwWdEoIaKpyav4vWupksP3GIU5sJ
qGes6dU6DKa9npYzJlhxSCCncdce7fmMdCidcQ3W8MrkKx+x8vgZOSt18lAXGODk
CDdO7hbxSjWUSlKeENRNBeMDEeNl6q9KfS/dLMHw6E17wySk8J/nzzB5qGBIm/pU
G08SqLAD8jQ1Flrze6wZWxIYH1fiireea1yOlx0faSe2om4IYbatDINZ4EWuaE6H
64maGFfl5EZzL1eTrBwBdl3kaA5W27Ei9kYfOiavICQ/3GiLXS3DBEBsRiv7RjJV
tqZ4BcpcQ5scdEa1cB12rHKewz/2t24Dv90QqNeiP0thtF93N4P70VGLBirz+07H
1GtOHkHuYQ6bg+y6LiC2
=WN+5
-----END PGP SIGNATURE-----

--fjEAjMKpll6GDq3U--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
