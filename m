From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Fri, 13 May 2016 11:26:11 +0100
Message-ID: <20160513102611.GC10264@sirena.org.uk>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160509102840.GB6292@sirena.org.uk>
 <DB5PR0401MB192850FBCBE79EBBC61ACA3A91740@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Cc: Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
To: Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DB5PR0401MB192850FBCBE79EBBC61ACA3A91740-GXldUsIPo7Z/SeJcUcAJq43W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 03:08:55AM +0000, Scott Wood wrote:
> On 05/09/2016 05:29 AM, Mark Brown wrote:

> > Yes, if you find bugs in generic frameworks you should fix them rather
> > than just open coding something. =20

> That's often true, but using regmap to handle endianness is like
> swatting flies with a sledgehammer.  Regmap's code is quite (over?)
> complicated (e.g. the (user-visible!) difference between
> reg_format_endian and val_format_endian is quite confusing) and ideally

This is the register map API, not the register API - many buses,
including MMIO, have different endiannesses for their values and
addresses so of course we need to let users control that.

> people who aren't getting actual value from a buggy and/or awkward
> subsystem shouldn't be forced to use/fix it.  We're not talking about
> massive duplication here.  We're talking about a set of simple I/O
> wrappers (something that many drivers do) with an if-statement.

As far as I am aware any issues have been fixed by other users who
reported the problems they were seeing (which hasn't happened here).
When we encounter problems it is not OK to just bodge around the issue
in a driver without reporting them.  That doesn't help other users and
makes everything more fragile.

If there were some history or other indication of real problems here the
story would be different but if that's been happening it hasn't ever
been communicated.  As it is it looks like people have been using the
diagnostic tools (max_register is specified) and clock management
provided by regmap and the way this has been communicated is causing me
concern.

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNavCAAoJECTWi3JdVIfQhe0H/AmVfMJzVP14W2SsKcx0Awu4
8H0CTUkyUaiu3NP51kR/BIfjtHgNNinKB5YLGe5Ma7n5j5mCBRQVCkfMY4WytNUo
B9Oh/tvEkrugcwEfARalB1yIyb7k2EkX9CjRIk8iToFQPdBgVEEyt9Mez46jbiTm
KHvfhARRaYH0LCKopq0q6mRlz+frxNgcWrk5rqJ6LDDGoL1MTw9OT9971xnJHSZf
3aycq09X4iSCaH68DachVjv8NrKUYlDXp1K5SMT1gY3iepwl/MUAwrNoPtYvj60D
EOLrtSDL7D5QGbYQS1VC1lCpd4PiWbq+iegAWxUM983xgBiseXZcu4YU615K9zg=
=2Cje
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
