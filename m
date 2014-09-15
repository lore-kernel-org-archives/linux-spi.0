From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH 2/5] spi-nor: Remove spi_nor::read_id operation
Date: Mon, 15 Sep 2014 16:08:00 +0100
Message-ID: <1410793680.3040.62.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
	 <1410714676.3040.40.camel@decadent.org.uk>
	 <20140915145523.GA1963@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-m5tAeoflddnc9OWIxp2r"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140915145523.GA1963-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-m5tAeoflddnc9OWIxp2r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-09-15 at 22:55 +0800, Huang Shijie wrote:
> On Sun, Sep 14, 2014 at 06:11:16PM +0100, Ben Hutchings wrote:
> > There is currently no useful way to override the default
> > implementation of this operation.  The returned struct spi_device_id
> > must have a pointer to struct flash_info in its private data, but this
> > structure is defined inside spi-nor.
> >=20
> > Signed-off-by: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 4 +---
> >  include/linux/mtd/spi-nor.h   | 3 ---
> >  2 files changed, 1 insertion(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-no=
r.c
> > index 6b1bda2..6f699c5 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -902,8 +902,6 @@ static int spi_nor_check(struct spi_nor *nor)
> >  		return -EINVAL;
> >  	}
> > =20
> > -	if (!nor->read_id)
> > -		nor->read_id =3D spi_nor_read_id;
> >  	if (!nor->wait_till_ready)
> >  		nor->wait_till_ready =3D spi_nor_wait_till_ready;
> > =20
> > @@ -952,7 +950,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct =
spi_device_id *id,
> >  	if (info->jedec_id) {
> >  		const struct spi_device_id *jid;
> > =20
> > -		jid =3D nor->read_id(nor);
> > +		jid =3D spi_nor_read_id(nor);
> >  		if (IS_ERR(jid)) {
> >  			return PTR_ERR(jid);
> >  		} else if (jid !=3D id) {
> > diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> > index 5ec84cc..66af67a 100644
> > --- a/include/linux/mtd/spi-nor.h
> > +++ b/include/linux/mtd/spi-nor.h
> > @@ -139,8 +139,6 @@ enum spi_nor_ops {
> >   * @write_xfer:		[OPTIONAL] the writefundamental primitive
> >   * @read_reg:		[DRIVER-SPECIFIC] read out the register
> >   * @write_reg:		[DRIVER-SPECIFIC] write data to the register
> > - * @read_id:		[REPLACEABLE] read out the ID data, and find
> > - *			the proper spi_device_id
> If we remove this hook, i guess we will add it back in the later.
> Other new drivers will use this hook.
>=20
> so i suggest to keep it as it is.

It may well be needed, but it can't be implemented in its current form.

Ben.

--=20
Ben Hutchings
Make three consecutive correct guesses and you will be considered an expert=
.

--=-m5tAeoflddnc9OWIxp2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVBcA0Oe/yOyVhhEJAQqtOQ/9FLTuhartT7l6IQPmqKTaLP+bXIytkFQO
7VsBu0WkiQorpqxcOZXN2kv0KFXBTmC+xGh6FdrbSqvDH6G+qAE0uMGxWKAkTX+k
7SKyVEZ9x+fkiA3P3r2CdeGo0X9cYpjtT2XfDnJVjJBui7ti+3d1mt0I0Hq6lJXO
P294LojD5imePO0tvNXRzfTBteZ7KwYgsnTHEEsELeYMYhG1/YX+7EFLVL9TYrIl
Dtw+chFaoc5CpvCazKEzIzUIYdXXXdcieAMHNJQkZRUZskaO0eLXTH7HH/XNlr2d
OsiKTIv7hdfC+Xv4RgxcF0ZSMs1gXckkjYwifbO4zGctxRAIjxVepdWazY7mhAie
+mN/vBuWrm7GaPwcOvSlM3lY6jnzxlT6u++1GuAAdfKZuILREhFVx1npw14s1/je
idOePXKzhWUrZizCPhLfjEjJorauLW4kJYhUnQLsSP+ZF5EStLvGZfqQGQTeLQia
Wpfsk3axVsCWOboFBz2TCEssIhw/DNfmGoMV4bmfLNRyp8Ry9VzZ0IfdcJgGnAmY
oPGlKbDv/MDZJBrb6+as8aLQU34Z9FQ5WnUQAd10CwLivJyZAlBC0J556PB5D8zJ
PNUgpAgmptWj57IvYRSK/0pKjUlNvbBqwj677tHpIReRQA4872qtWJjQKj/rTBQa
zg8gq9+gDPU=
=QYMC
-----END PGP SIGNATURE-----

--=-m5tAeoflddnc9OWIxp2r--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
