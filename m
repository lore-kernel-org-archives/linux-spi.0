From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Date: Wed, 26 Feb 2020 11:36:10 +0000
Message-ID: <20200226113610.GD4136@sirena.org.uk>
References: <20200215065826.739102-1-gch981213@gmail.com>
 <20200218125557.GD4232@sirena.org.uk>
 <CAJsYDVL03KJv7eewGekBPCfpbOuTX0tJ6qZaydvJnBDzZ5vEwg@mail.gmail.com>
 <20200225173137.GA31830@bogus>
 <CAJsYDVKqcd-ytLLf5zKqs8DfjPAa5ELCX53OiPDAi-tDnLd=Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJsYDVKqcd-ytLLf5zKqs8DfjPAa5ELCX53OiPDAi-tDnLd=Eg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 09:31:33AM +0800, Chuanhong Guo wrote:
> On Wed, Feb 26, 2020 at 1:31 AM Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > You should should really only need 'spi-max-frequency' if the max freq
> > is less than the minimum of the host and device max freq.

> But current spi framework forces that a "spi-max-frequency" property
> is present. [0]
> Should we patch spi framework then?

That's one option, yes.  As far as I can tell the bindings have always
required an explicit frequency specified in the bindings but I've no
idea why.

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WWCkACgkQJNaLcl1U
h9CC6gf+JGnksoKyOcf+87xz30r83FSXTXHP5TSv0S1iEPWe7PYG3vPRv0NdFdq2
95nsCYkfFdyrl8ayy/LjsXvZMbZPUv2oDhJGdq11H7EX3/DrKCTcChXdkzpD64NG
dlKWpB6xvJ6Ka/g9VowGe+WcTwrhQBQByb45Z0EkTZxQ+YScJHQkJy8HZXQKf85E
IAW7t7mcHtmmIXmJB7yHHE3exT6cOcDurwuz6QOJ+w3YwNYNO2HcR5ZS0T1IjPe4
WgWVxid2OxLorFCxu8dUxxsq29uDD49lP/kfbyVYkND761fTbk2idLN94r6vvCyx
6PNQ3DIDylR48WUdePXdGADNjXBUog==
=d0oJ
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
