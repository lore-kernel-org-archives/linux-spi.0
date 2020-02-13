From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
Date: Thu, 13 Feb 2020 18:46:25 +0000
Message-ID: <20200213184624.GK4333@sirena.org.uk>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
 <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com>
 <20200212120753.GF4028@sirena.org.uk>
 <CAHCN7x+5bACfYVX49Lib+fmNq-dEOkcyi0gXt7rtYxrGaYbH1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ah40dssYA/cDqAW1"
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
In-Reply-To: <CAHCN7x+5bACfYVX49Lib+fmNq-dEOkcyi0gXt7rtYxrGaYbH1Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ah40dssYA/cDqAW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 07:08:49AM -0600, Adam Ford wrote:

> The original author was copied on the initial commit.  I literally
> generated the patch from NXP's branch,  added my notes, and pushed
> them to the mailing lists after testing them on the  the Linux master
> branch.   I am a bit disappointed that NXP's author hasn't responded
> to any of the comments or feedback.  NXP knows their hardware and

Bear in mind that it's been the spring festival and there's been quite a
bit of delay in getting back to work in China resulting from coronavirus
stuff so hopefully it's just a delay in replying.

--Ah40dssYA/cDqAW1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FmYAACgkQJNaLcl1U
h9BIJQf/YCuS+PbvoZjpzEq+oZbCnmY0R0BkFrp7Sc1PV9zHgjKqGmQAr9RVSeSI
kfalZEPSUkUEpxgouX+I3VVvKPpQhDEhj46+y+IXYWH/Y0QA58bDv7ctWOhIBn+Q
vW7iTl/+CHsJdTptylbI5K0TiVP3D5wDGbiym/rvAjIGpe7FXzd9WUteXNKeLJMy
QmhJg6z+gAVwf/mYiyM03MRx1Gn1c5C/cMkan6s189g77et3avP4nEfKb6UyApgi
FY+BqvQCyBK7OSErmJ7H+NpqM9Rq0b7xJLknFwbfOLTpqvG8iRhGzvQyNg3uPAqt
aAm0o3dppPZAbuc4HFV4OF5n2YoGBA==
=r4u7
-----END PGP SIGNATURE-----

--Ah40dssYA/cDqAW1--
