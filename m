From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Validate lenght of the transfers in message
Date: Fri, 14 Feb 2014 15:05:20 +0000
Message-ID: <20140214150520.GD4451@sirena.org.uk>
References: <1392302806-17267-1-git-send-email-iivanov@mm-sol.com>
 <20140213212757.GM4524@book.gsilab.sittig.org>
 <20140214002627.GG28112@sirena.org.uk>
 <1392365765.12787.89.camel@iivanov-dev>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Cc: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392365765.12787.89.camel@iivanov-dev>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 10:16:05AM +0200, Ivan T. Ivanov wrote:

> "SPI transfer length should be multiple of SPI word size, where SPI
> word size should be power-of-two multiple"

Yes, that's clearer though you could in theory have a three byte word
(I'm not sure that anyone would actually do that but it's possible).  I
do have a comment on the code as well.

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/jCtAAoJELSic+t+oim9mo8P/2JMICQN2GFb3yMoCoNCuzt6
ieRjfgN9F2kkQSqumpGRXtZhwFuDL4eWO8K4tGRCT31jumCKJT+nkHwc6fesTwoY
HHASYD47TQPcMuulY+fwLZKt6TjGQdX2X/HUWcvAKa5kcgseyi4+vNdj/SKx20wX
kq27k2w1oKoSNBxxYWY2psnxVch/1mJ9Hw99O0ukpEqwxES/bODSVb/Rpzn2wtBu
9eZzga5KTEr1+a94qXHUE+nvzG1I7Nc9gjmKQD8N+hAbM/wF84U/wH39wl6IF/eB
qowoLSBOtKhmmliaizSjoFN4eNxNM2tD2mZMUJn6JhBQsVdD7AvsoiTsImP/UoT7
Y5IXjK68uV5owpdt/GMCA8PPKIj2nMP6XUamoqbUCl1K2GiwJERcXApTnV/Kyd9f
rYOmwvRi+2lsU5PLms04UB7kvGBvSbLctT38NdwpNRJJdk1Ci1Z9euqycZC9HTs8
Hsd3Y9SO6viBPeE6p9ar0Bs+AekqmTu55QpV0e5KcCZXiD9SzNFPo9tR9K4AUjfS
AR94kJc+7dP9+SmkMIWEqzsDo9s5igg8EAqQbP2H28gQp7JmbkEKEItUgi446Ur1
3vDIpP2OYir0WFMw8rRmCnQhhs9lq3XB0Y3foeYxoE6tiCo8PiJkKpAHlQh0YP4U
yyFE8hlZiKZJ8CEfAgVK
=0TMQ
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
