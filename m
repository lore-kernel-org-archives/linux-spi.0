From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] spi: core: Validate Tx/Rx buffers for non-zero
 length transfer
Date: Sat, 16 Aug 2014 15:34:01 +0100
Message-ID: <20140816143401.GO28623@sirena.org.uk>
References: <1395201227.16346.1.camel@phoenix>
 <CAMuHMdWCdp_SW5CNt50cSfG700JRU3tr=Pbyhv8nv-1Ve=XUNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nljfjKcp9HDtPSOP"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWCdp_SW5CNt50cSfG700JRU3tr=Pbyhv8nv-1Ve=XUNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nljfjKcp9HDtPSOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 09:06:31AM +0100, Geert Uytterhoeven wrote:
> On Wed, Mar 19, 2014 at 4:53 AM, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:

> > Reject transfer if both tx_buf and rx_buf are NULL for non-zero length transfer.
> > Add the checking in spi core so we can remove the same checking in various
> > drivers.

> Just wondering: are there any SPI slave drivers that implement dummy cycles
> this way?

The ChromeOS EC apparently does this.

--nljfjKcp9HDtPSOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT72vVAAoJELSic+t+oim9HXsQAIFYrI/vxkvghDZakJqkSkex
o+lfmdb8u2cgcYs3BDKTFJi/cm2KjSerTrQcFedR1oGvcZfzfKSWtv4nXDhQANCv
OHy8ydsIUV51heu+i+YZWv2rPSlFx3m++/XrF9y6KxzYEkTJeHH8QUWHr9c4/Cdp
OiwKUsadTkjnJSuGJGcXcpRpkO9N0Z4mH56iGSkQqqgPhjf6HRhFKAKULQcP1uK1
zYywKkaAfCrVF4nATxf+vvrGE8J9EnH2mJ5zUc/ZmX8Am+KIhOChvpNDHTwnsc8x
RzvzauJC+ZINvdA8dqqmQ8FiR/ZMjQxJGvLyZV05mnM11bR4E3lM5DgHjxzocM1a
Gyyrq+dcymzZdXA6duVu+4hK4UaHQh2EFgCk39GYzHpp833IcpqKxvXGiKbyLsVH
lHZPaOE9BgVn02EnW+iYYw38SgrKSG5LByP4jE2l7vj2aZW9OVsNC0Lp5ozmI4RD
X8md2tPxUm/FhwVhwAE6uRICwBabTsQUlRBH69+fVjRs5LKX77XWxW0q/oOqOgvw
bajXm4r0G/hRSN1qEXdTChnQ/UCIhueg09u1MmM46dwLaeX4u3GWMsJQ6bza9X1z
9KD2LR2JOhLXTlzuoHndAraLDx9OuXiKxWNkSi0+wrxGL3t3K5VNYrJiICw6Bogq
vCBLI6fo2UDvVYsOPKSb
=bMfa
-----END PGP SIGNATURE-----

--nljfjKcp9HDtPSOP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
