From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Additional SPI-master parameters per SPI-Device in device-tree
Date: Tue, 4 Aug 2015 10:54:43 +0100
Message-ID: <20150804095443.GH20873@sirena.org.uk>
References: <55C05E18.600@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Kgh2FNDOY+603hGA"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C05E18.600-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Kgh2FNDOY+603hGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 04, 2015 at 08:39:20AM +0200, Martin Sperl wrote:

> How could we implement additional per spi-device parameters that
> are interesting to the spi-master.

Define parameters for the slave and read them from the slave device
node at some appropriate point.  Please send patches for review, your
sketches look fine without context but when written as a proper patch
other issues may become obvious.  Given that setup() gets called
repeatedly a one time call may be more sensible.

> Examples for the spi-bcm2835 master for example could be:
> * set minimum transfer size for dma to something else but the default
>    (of 96 bytes - setting for something high would disable it)
> * change polling transfer limits (i.e disable it)

Why would these things be configured in the device tree in the first
place?  They don't look like things that should be device tree
properties, they look like something the kernel should figure out at
runtime - the system tuning may change as the kernel evolves or
depending on userspace needs.

--Kgh2FNDOY+603hGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwIviAAoJECTWi3JdVIfQVRMH/RdW9CSf1Ianf7q9bYGRL4y7
NNYsGMSAzs1BKLL/1+XrPNk8ifHF2Pyk4xL2u/4UdTBpESn5yvA4l2nsnCdar+8o
Oi3O5W64MapsSHAojCKu2VEcvCuTcxkDZhl9RUTx4Y4l17qPPL7W6DEkMutNMDwV
sS9j044DetqrP4LSVFIPCZCZmgiDbUrg/8gZudharGQu8639KMrRvpe/Zi5HGum5
O3F1/d5qvpZv2mpEn/s9h0cIrem81Pm6o5XwiSoqfRgMKGrkVbyo7FEbnGgpJLbe
594/kBCfuPDryjPrlspMcfg/5+/diikrvFHEiXMNIppYR8A6Mcf3oVtiJ1SB9pI=
=WWcu
-----END PGP SIGNATURE-----

--Kgh2FNDOY+603hGA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
