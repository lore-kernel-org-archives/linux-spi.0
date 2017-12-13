From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Wed, 13 Dec 2017 09:38:06 +0000
Message-ID: <20171213093806.GA6416@sirena.org.uk>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
 <20171212075815.8683-1-andi.shyti@samsung.com>
 <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
 <20171212130313.GC1072@brancaleone.zhora.eu>
 <CAJKOXPc8o2_bMbXjwPopOtsoML0NqOzzHnYXCL9oU9VkU2cQYA@mail.gmail.com>
 <CAOFm3uHobATjskAKG83QoSQjXgzv1RQFv0vrgt_QgnZoxNQ2-w@mail.gmail.com>
 <CAJKOXPeZi=TWqoCo9x-Wa372ey8D=r8-Lf3CvJ95dgaMAF1kxQ@mail.gmail.com>
 <CAOFm3uEAzEgN-PgSOccbwO3aWfABsHywUmm8eXasR8CXy=NPJQ@mail.gmail.com>
 <CAJKOXPeCBPdCi2NnpBWimb4Py_zDZrsSK9o1cCswKM+XNeyqxQ@mail.gmail.com>
 <20171213014854.GG20051@gangnam.samsung>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Philippe Ombredanne <pombredanne-od1rfyK75/E@public.gmane.org>,
        Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171213014854.GG20051-8vUhnHFVuGn35fTxX1Dczw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 10:48:54AM +0900, Andi Shyti wrote:

> > > +//
> > > +// Copyright (c) 2009 Samsung Electronics Co., Ltd.
> > > +//      Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> it just looks ugly to me to have something like

>   // SPDX...

>   /*
>    * Copyright (c)...
>    *      Jasw...
>    */

> I would make everything of the '//' style (I've also seen that
> this is the trend also in other subsystems), but honestly I don't
> really care. If you're strong on not moving entirely in '//' style

Yes, my preference is to avoid a mixture like you've got there.

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlow9PsACgkQJNaLcl1U
h9CYIwf/bEb287R0G3M+8JKpYhdWpf8kQIgcrfPoPSIq6MzrX75jSr+kgi1VwIz9
ACb8n6NNGbF4a4zVCpjmgGRvm9Yh8AQrZXolC4XpJkeqX+l9k1xHYFFxOeu2cn7M
Hg1a6D8+zpcKlQip3UMlvGrg6pCHNqCwLOQBxhOHKRuUxdEmefrFyvBuJP7g92Ou
U9Lb+loG0GIvIF7/CuceTXqYouddqQywHJqmsvamMDKyB3QPvZGbgxu4nnsKWgIu
LdVtEW659hnLC7N3/D2EUoRH+rBDu0Urhu8iKWmqLj0zLWoTCXJWHL9GuA70G/lN
QFIEZnWLqTJf1kSsYRCOyQ6CJIANKA==
=pOsu
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
