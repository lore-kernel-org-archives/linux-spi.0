From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] spi: core: Validate Tx/Rx buffers for non-zero
 length transfer
Date: Wed, 19 Mar 2014 16:08:46 +0000
Message-ID: <20140319160846.GO11706@sirena.org.uk>
References: <1395201227.16346.1.camel@phoenix>
 <CAMuHMdWCdp_SW5CNt50cSfG700JRU3tr=Pbyhv8nv-1Ve=XUNw@mail.gmail.com>
 <CAFRkauCUUOQ0xxa-k5_TMKUA7jnnz1FPjXnGT4T10v7upyOy8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Liytj72NTuI9Pzy1"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFRkauCUUOQ0xxa-k5_TMKUA7jnnz1FPjXnGT4T10v7upyOy8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Liytj72NTuI9Pzy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 11:43:55PM +0800, Axel Lin wrote:
> 2014-03-19 16:06 GMT+08:00 Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>:

> > Just wondering: are there any SPI slave drivers that implement dummy cycles
> > this way?

> I think I found one such case:
> drivers/net/wireless/libertas/if_spi.c
> the dummy_trans has non-zero length, and both tx_buf and rx_buf are NULL.

> But that means it doesn't work with master drivers with this checking, e.g.
> all drivers using bitbang library has this checking.

I have to say that this seems rather abusive on the part of the driver,
it's going to cause implementation issues in the masters - I expect more
than just those that check aren't doing to do the right thing.

--Liytj72NTuI9Pzy1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKcELAAoJELSic+t+oim9kVcP/2Y8WrwLl3bv9GadljC4ZNaR
s5ZdQif+HAlfw8PsooQNfaXOmM1mQYKboO3iI6F5oJ+tAwF5pJ8Gm0pBvFwyLrbm
bt8PzIywz6/zRGW4+apr4nRcYg64sxQzNxBv+ewIXFjhlHVAR6yzFnqFYVemqLub
Na/n+0GQwIcawrjMSR89OvFz1M6Msk3xBlWsFBpjdXj/iQ7hMZesfxkki15pShU3
c1DC8T6qpa26Z0OMkvAcEHX9YYpt5T30g9jbb4zc7KdPIgv4bkerlF6TlqM/k/iA
kw2FJq32lv2qdzDSCinJkpb94HetJgGCrl+w2Hy//Zpq0nfKBSAk1p2dur42IwUc
q60AJBY/G5obX8zUR/0Fhd+HnwYKHmymtgLQCLd9kjR+s2KbdqAkTGuXYZECc3pX
SYNdazFZSEOQCIrxqkN1OdMfU8bQiKBQnXR59oQsDY9l46DeoqE05IGCBfo5cgt3
eTQfw7Rp2htHpj7h8w0sUtvQhtbopmvjFcP+/i0wwxndgTkQe+l5Y4WYn/7JLtz+
EBapbYGDyVJkhJlGMxlzgAWEQPphNO4rDzoFVFe2Q0Z/vsw0NsmBo7Zf0NcDOVyk
yJ2dZWxqqnt3fUxZ9ezNJcxvPqfhb5ZR4EiWux+7+KlGvut9gbVkka3aB63VQ7T4
4rvQPkw4sCJX9sR0vWbk
=RaxW
-----END PGP SIGNATURE-----

--Liytj72NTuI9Pzy1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
