From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
Date: Wed, 12 Feb 2020 12:07:53 +0000
Message-ID: <20200212120753.GF4028@sirena.org.uk>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
 <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
        Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2020 at 04:53:34AM -0600, Adam Ford wrote:

> My motivation is to get the flexspi on the i.MX8MM to work, and I did
> a list of the patches applied on the NXP branch to see what was
> applied on top of their 4.19 kernel and this patch series generated
> from that list.  Most of the NXP commits are one-line commits, and I
> don't know the motivation for what's happening.  NXP did it, and I
> know it works on the Flexspi driver.

Adding new compatibles and so on seems fine but the patches making
random changes without explanation like the one for octal mode I just
replied to are more worrying, do they work with older versions of the IP
or in all use cases for example?  I'd suggest cutting the initial patch
series down to the bare minimum needed to get things working and then
building on top of that if that's not already been done.

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6pgACgkQJNaLcl1U
h9CVMgf/QyhKBWAfMkP4Rp+HGO7kGTkLUcFcDDEVLppg3P994e+Hw7xkEhHlxZzR
Pk3L02ATqS7BzaqcD6YYWlUNUhq84BASOdHvlXmkHbj2zUH1YXHGToNmImnyz+ij
PvQMg+4jX2+O/lS74JysuPSmnBaKzjCow8YHCD7eOF4/vBOpUbf2mSl2j5FqiQ61
epX3f2ggXN/mHWb5lHsRFg0BeiX0FY0z6x+eKtRhkMlcWFDSi4tEAtCWQeJdln/Z
fBzuVHcuRml1QT7eUkipD/rvtj5X04qwFvOHjHdVFRTlsWT9NqAEKyvwofEAml9G
LQ/fLV2WIr5f6MFYAgsFwhj6PpLOYA==
=3v+9
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
