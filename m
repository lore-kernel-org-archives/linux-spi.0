From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: spi-sun4i: how/where to set the bus number of spi_master ?
Date: Wed, 8 Mar 2017 08:16:00 +0100
Message-ID: <20170308071600.lcaajbpvok2s3kzz@lukather>
References: <d8190d82-c2bc-2ed0-79d6-d326248944aa@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5u5qwcehjcvgltkw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank =?iso-8859-1?Q?Sch=E4fer?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d8190d82-c2bc-2ed0-79d6-d326248944aa-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5u5qwcehjcvgltkw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2017 at 07:21:14PM +0100, Frank Sch=E4fer wrote:
> trying to get a TFT display working on a Banana Pi M1 board, I noticed th=
at
> the spi-sun4i driver doesn't set the bus number of the spi_master (which
> leaves it at its default value -1).
> fbtft_device driver fails to load for that reason.
> What's the right fix for this ? Is this something that needs to be added =
to
> the boards device tree file ?

Yes, you need to set an alias.
https://linux-sunxi.org/SPIdev#Configuring_your_device-tree_.28mainline.29

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5u5qwcehjcvgltkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYv6+sAAoJEBx+YmzsjxAgug0P/Rqet+qxSGIaP7Ngu/mt57Ip
8HQwgDMOGO3j8sArQoOx/Lgumg4dEmvIhylDnmQICWSJ0mwQ+cSlQYdmqn9CtsMv
u3xx9DRA0EsBoopORpKOuXCRxn9Ud+Nm1EFPo8FDqAzpaViiOoHcuEugFAHw85SG
Y988lZ06cjchFw+p4JOPyzi3ZUjpXCsmFZ9BSn70bK4MAN1r07WwMHabqdwdEIXH
u/CUbxEgqp6mY8W/Ch0X7C1CWUIrLjFU7LXY7nylRzpjXVxRuO7Bt8c9FPKlWqDI
/uYbpp8X44xXiRVBWBLK4PRv9FobhcS3giMd3beTeTsG52XD3hq0d8NsllP49Iid
guL8LJfiwcm8kyXceVLQvnHn1+0QiJWkov9KxpylEb36d+/GayYbZMjfpTOQmmmO
zWw88fRhSHrjgWUnrsT2Zs504TLTENklPLyub1s0pLpqBPoJEj/6s4sU+PLINGYD
U7hHidiUViTs3kODeoY4t+5etbpeDWWR9rmlMBfkD78TYmU1h/KtnxQ+9pwJk0z9
OyJCioAe4ieZ6dxvk+tQb25wlZtRe2KSaT1YLcUAu+J4Oyh+/jxsDrRm+GMBXlwS
88e4iZiWPt5NX1aHAWo7SAZYQJixeKKKhehc3FaeOMA/S7L2r70PbW6SCaimAVXB
bFS8YhzOFp2Im0o61ra+
=HPPC
-----END PGP SIGNATURE-----

--5u5qwcehjcvgltkw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
