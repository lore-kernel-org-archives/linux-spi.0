From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC v2 3/7] spi: core: Add support for registering SPI
 slave controllers
Date: Thu, 15 Dec 2016 17:46:29 +0000
Message-ID: <20161215174629.x7zzbgvjhe4q7cpt@sirena.org.uk>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
 <1473713446-30366-4-git-send-email-geert+renesas@glider.be>
 <CAMuHMdWhuqSg+qUnDUqad-SBJOY5rOuRGuG7oUfTXiQA_rUtoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tevkpkhsj4t2dyso"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWhuqSg+qUnDUqad-SBJOY5rOuRGuG7oUfTXiQA_rUtoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--tevkpkhsj4t2dyso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 18, 2016 at 11:04:18AM +0200, Geert Uytterhoeven wrote:

> This is caused by moving the setup of master->dev.class.
> To fix this, I can
>   1) Introduce a separate spi_alloc_slave() function, which sets up
>      spi_slave_class instead of spi_master class,

This seems more idiomatic.

--tevkpkhsj4t2dyso
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhS1vQACgkQJNaLcl1U
h9BhrAf+J9/Y3iKtbQh+owYF7HlBgzBwUi6OgtYENNkhBl6Pi5XWkmlK3JhpyE7y
8IpbuFuKOBFOFKl0BWEsoKt2wm2KmWeqY08ydM97ffpl4MBJ+qDFjyjqutfOkMb2
0zhwcb2m1dq3svBzpiE/PVK9ORdfXkhbgSD/0wxbALpfH1bXPRSlG53VliZkhA1L
S6RYaMXhKP672FOYUJeG18YuHP3/LY/HQ9MqI17YKwF+m+XTQbymtBVIrkh0NKx6
19SBls44g9zFsZyYyruSMvCIdHx6sOiTZ4r/jpwdKXsw6dhHdY3eT+dIsEogwX7z
tsn9He/CyzvMw00CjDrRQ6I0kZBtMg==
=60zH
-----END PGP SIGNATURE-----

--tevkpkhsj4t2dyso--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
