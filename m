From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: add support for changing message transfer
 speed
Date: Wed, 8 Jan 2014 13:01:54 +0000
Message-ID: <20140108130154.GD31886@sirena.org.uk>
References: <1383816846-10561-1-git-send-email-richard.genoud@gmail.com>
 <20131108111152.GL2493@sirena.org.uk>
 <CACQ1gAhsKeQUB_vN9iJDbBsJ+7CiOZH8O=ZPg96pP8qRDHf15g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VKb+owlsAeUnmGbp"
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Wenyou Yang <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACQ1gAhsKeQUB_vN9iJDbBsJ+7CiOZH8O=ZPg96pP8qRDHf15g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VKb+owlsAeUnmGbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 11:15:13AM +0100, Richard Genoud wrote:

> It seems that this patch got lost (or I missed something).
> As it will now conflict with Wenyou patch "Refactor spi-atmel to use
> SPI framework queue",
> should I resent it based on wenyou's path ?
> or on broonie/spi.git for-next and wenyou will rebase his patch on mine ?

It was applied but not pushed out, pushed it out now.

--VKb+owlsAeUnmGbp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUw/AAoJELSic+t+oim9PDAP/1L6sOBlm2PErhPVUnFaevIQ
dl42s+F88AWxC4iH6GCD7RAhgAFYIqoV09X+4mZJ3TyI3LiPdMieoOG5kSPszhFJ
aBxeUgzdy5V9vAXZz/GXrVxXs0Q/+p0nwI1sw21L2m1oticAvo9OGfZ3mLsDQhUW
2wiDBO5Jph6/pkrcIhwLDeCpQ1wEH5+eiLhj5BcWdhUBRSLQ2Qm563SF7Yq1+WX4
mh+XlooSf5tjbQBQvAV9yl6OfSLjg8x81F2MDXpPDxQbq2yUg4E9Qn7nGYNJXHN2
ybQRmP8gQcrQOVLCYQyf/0F5e5FPlLSa1bzKayWPctD4zepXhSdUy2DKZb6z002L
Nrrg/4m8t0RpeDh5PN+t36lAvf5+bTmGKexwq8HNLQLC5k65JPhmKd6O9Cl3mkwu
6E3E9impqjIhEYvBr1daCfC+422aM/OeI3RRJAZtosZVxgWBrAn4eMHwqQpT8Gwv
+TrUXoJmVa1vlL7wy9gAT2oTM5IOkWRzUsVqYSAclkrG2Ap4tzYaV71hVeboWyTs
Ry+4CaZfNHKhDVrsSoyYd0bIK5m6J1x5ImF8B04ALo/U0oz3N//FPbP5MZPY939r
iUoS5cJqESkdQm7xPg2188YAMUgv6lK6Q9aRU/mszf3VzquEwVytDcIwBP3WPDfC
YgLraiCHSu5jRZJgUc9j
=gD5H
-----END PGP SIGNATURE-----

--VKb+owlsAeUnmGbp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
