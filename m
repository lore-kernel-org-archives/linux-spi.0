From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: orion: Software control for inter-word delays
Date: Thu, 15 Feb 2018 15:19:07 +0000
Message-ID: <20180215151907.GD8374@sirena.org.uk>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
 <475b63c52b17187089d3f2ecf8ff4b8c45a7e58b.1518704854.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>,
        Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>,
        Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
To: Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <475b63c52b17187089d3f2ecf8ff4b8c45a7e58b.1518704854.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2018 at 01:25:32PM +0100, Jan Kundr=E1t wrote:

> Add a SW-controlled timer for inserting delays between individual words
> as transmitted over the SPI bus. The DT property name is loosely
> modelled after a similar, but HW-based feature in spi-davinci.c (commit
> 365a7bb32e09) -- hence the DT property name.

I think this is a sensible and reasonable thing to want to do however I
think we should move this from a DT property to being something in the
transfer structure which drivers then implement.  That way if a device
has an inter-word delay requirement it can go in the individual device
driver so it always gets applied.  Does that make sense to you?

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqFpOoACgkQJNaLcl1U
h9C4dQf+MiwTw1U3a0pFDYutCSq2ZoosfeKV2Hc3WbERpsTjEnd9aV57zNaWGceP
Dgwd5i/oBSXWUqxUp1n9xOIYzFDXKvYxhYVhSOztgUAyXqO6yAay4wU3SGbVXDkZ
tPJxWZjvTOEHHKB2pym/OM8Omr77hioehOvqKDhTItPVHMy3Aa9v4UXdTNMPF2nH
vxg4rtWQo5YejxHRbPWeKa2ROC7M8zOtLduAKd98kYAYgq32EMfEr//Y1O+DiaY/
eaD2ChY4t6MmkBYb1vvR/6BrTdroCZY3Lxw9IRrU7R6gkIoDHTAGio0BSLq+FzCK
rwt053AtV6W9W+hkzNVoANsNGkL31w==
=ENsn
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
