From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Date: Thu, 27 Feb 2020 16:28:42 +0000
Message-ID: <20200227162842.GE4062@sirena.org.uk>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Cc: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Boris Brezillon <boris.brezillon-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200227171147.32cc6fcf-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 05:11:47PM +0100, Boris Brezillon wrote:
> Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org> wrote:

> > Allow spi devices to express DTR receive and transmit capabilities via
> > the properties "spi-rx-dtr" and "spi-tx-dtr".

> Is the RX/TX granularity really useful?

It's what we do for other properties, and if this is anything like the
other things adding extra wiring you can't assume that the ability to
use the feature for TX implies RX.

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X7jcACgkQJNaLcl1U
h9A5kgf/Y0DRJYdf4AUiGakcZO9I33l1RhLd5LtXAlID2YL52F81QjI/Uh6tRy8r
6otcXAH1qzNwt2nV9Rsns7oy/Em4FpAf248Syn9SZiGE5JtiAS3opEuoAxKeJ604
JNMbbAB/6AdKeIN3HrtjEb560Ht2WF9EEkrA5L45YYC6uHNf3YD1QseYg5l88d/K
0g/2qCx8TpynDd2YEKAxBjExG6u4MK2pRtJBMZSAO/Ky3foUaUxUy/jBne/8IF+8
6/YhGyxrXmJoklyW8KFJsPYNuR6pKAyl769Gy0w9KNvvs+O4cuBrVMxP+EUOwWbt
OdSZ0ur//F4vDI6KkaOrG2YCg2r7Nw==
=OoLn
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
