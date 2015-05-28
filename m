From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] spi: Add support for Zynq Ultrascale+ MPSoC
 GQSPI controller
Date: Thu, 28 May 2015 16:03:56 +0100
Message-ID: <20150528150356.GA21577@sirena.org.uk>
References: <1432106871-27232-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1432106871-27232-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150522115854.GG21391@sirena.org.uk>
 <CAFcVECJRqebzAjU+rfAtUQFG=7-KoE1GiXet5XJB-4D3i0or6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bU64ygGtHgdLJp+F"
Cc: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFcVECJRqebzAjU+rfAtUQFG=7-KoE1GiXet5XJB-4D3i0or6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bU64ygGtHgdLJp+F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2015 at 08:43:54PM +0530, Harini Katakam wrote:
> On Fri, May 22, 2015 at 5:28 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Wed, May 20, 2015 at 12:57:51PM +0530, Ranjit Waghmode wrote:

> > Why is there a default case here?  That's going to men we try to handle
> > any random chip select that gets passed in as pointing to this lower
> > device which doesn't seem right.  The fact that this is trying to handle
> > mirroring of the chip select to two devices is also raising alarm bells
> > here...

> This SPI controller has two CS lines and two data bus.
> Two devices can be connected to these and either the upper or the
> lower or both (Explained below) can be selected.

> When two flash devices are used, one of the HW configurations in
> which they can be connected is called "parallel" mode where they

I know what wiring chip selects in parallel is but that's not the
question - the question is about the handling of the default case.

> >> +static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
> >> +{

> >> +     if (is_high) {
> >> +             /* Manually start the generic FIFO command */
> >> +             zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
> >> +                             zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> >> +                             GQSPI_CFG_START_GEN_FIFO_MASK);

> > No, this is broken - setting the chip select should set the chip select,
> > it shouldn't have any impact on transfers.  Transfers should be started
> > in the transfer operations.

> This is the only way to assert the CS. It doesn't start transferring any data.

OK, then you can't implement a separate set_cs() operation and shouldn't
be trying to do so.  This will break in multiple ways when the framework
tries to use the operations separately.  You probably need to implement
a single flat transfer() operation.

--bU64ygGtHgdLJp+F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZy5bAAoJECTWi3JdVIfQHssH/iyjeBwoPxxRDn9j42CeGb2w
XywOInE1XlKDRMgzztEBRvHbpPOl3m9+Yvdh3QIoESGcDjMHvkYBqXO9uhpEtfNL
rOBOL+tXlY384F7Tx4pdhstNIwm7yXqx2RM0Pg7ObA0mg1ecfbJ2rG2xd90N7cn3
QVcsmhDSGSeFLA9wLLsVG7PZ4MaaqkOAcHr+ixjrSwFuicPCTspFgovdkxxb0saE
WG6l0cVd1D7nancABt+0PmVtIv0+iG4fa/HuTQZmbK5flbpzJreCuB3gu2sYwZq5
++ddRQ9DGjL2GOyrRnEkb5YrP/B/X3AxntLI4o7le1NIUHsWnbTh9FIOqiachwE=
=jNn9
-----END PGP SIGNATURE-----

--bU64ygGtHgdLJp+F--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
