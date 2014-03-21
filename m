From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: nuc900: Fix setting multiple bits settings in
 register
Date: Fri, 21 Mar 2014 12:08:16 +0000
Message-ID: <20140321120816.GN11706@sirena.org.uk>
References: <1395379454.30136.2.camel@phoenix>
 <CAMuHMdVYHnv2PGaerL50PhK_a1E=LaEwdkhHNgyaqX=WO-FOXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m/m4ZVXjNFS7X2Jg"
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYHnv2PGaerL50PhK_a1E=LaEwdkhHNgyaqX=WO-FOXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--m/m4ZVXjNFS7X2Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2014 at 09:13:00AM +0100, Geert Uytterhoeven wrote:

> I think it's easier to read if you keep the masking and setting together,
> and remove the conditional, e.g.

>         val = __raw_readl(hw->regs + USI_CNT);
>         val = (val & ~TXNUM) | (txnum << 0x08);
>         __raw_writel(val, hw->regs + USI_CNT);

> Just my personal thoughts, too.

I agree, that seems clearer.

--m/m4ZVXjNFS7X2Jg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLCutAAoJELSic+t+oim9x9cP/ivqsy4RmmSwoS1YWELQf8Y2
B1x5wwE3uapV1QxzzPFhIxyC1fs9ZV4xkUklcXwmIhUDadWu/fMOeBYcKxGRQcM5
aSgk5ByqprZqYGEuWJjF0qlRYsGY2oNch7bKHQIOHeTDWoeibLbM27njYhCuhrtG
9+FnX+K+pMymmeqBqe5fw2gIL8iVyz38zt10VVc3CBzkE5chupzOrWWO7ZS0/Iaw
6ofWXspeg+VHuwpjTytKsIddlFKPDIVZOb4U0ZH9TtI/C+4VOidfXSolYzY3XqBZ
ThdG+q9VQ3BeY10JAk29YHhpcZpeSE9cljCHPD56X4ekFyxDtI77PVqGi0l9TmAQ
LmzGtjkL/Iu7U2J7fGEYqPOnB+qxAc60w/0LmM38ZfwMWQSmQP+IgQONL/f1sdiy
bzYntPrlj5hd7QcoS5F7HaQzS4vyxyesFaeHkBkNyZ8WfZW811iH4igwWzWJX56a
O9Zf73/E/rt4pXGx0y2VMXjhl+ujnX9kGuWhAxtHjSfzcmGuYUmp35sCH0mi7BrH
fHy0ppBmumXOV7rI4kHJo6rwUyq+5jSphSVGSFfdGm5nYN3pOgacneKrp4ebow0A
XocPpuJ7HGxkgk+zIeBcKX8AsNk3ke7+oqJQunQoVJihIT39bANscGhUBpXbohX+
FgQdfZqfHFNVzCPtAGeU
=Ewz3
-----END PGP SIGNATURE-----

--m/m4ZVXjNFS7X2Jg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
