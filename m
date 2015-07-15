From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
Date: Wed, 15 Jul 2015 17:01:46 +0100
Message-ID: <20150715160146.GS11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dp+ZBeMqOVN1dGc7"
Cc: Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	"computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"marex-ynQEQJNshbs@public.gmane.org" <marex-ynQEQJNshbs@public.gmane.org>,
	"shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org" <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	"ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org" <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ranjit Abhimanyu Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7CFCFE83B8145347A1D424EC939F1C3CA7E53D-4lKfpRxZ5enZMOc0yg5rMog+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Dp+ZBeMqOVN1dGc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2015 at 02:12:54PM +0000, Ranjit Abhimanyu Waghmode wrote:

> > > What is stacked mode?
> > > ---------------------
> > > ZynqMP GQSPI controller supports stacked mode with following
> > functionalities:
> > > 1) The Generic Quad-SPI controller also supports two SPI flash memories
> > >    in a shared bus arrangement to reduce IO pin count.
> > > 2) Separate chip select lines
> > > 3) Shared I/O lines
> > > 4) This mode is targeted for increasing the flash memory and no performance
> > >    improvement when compared with single.

> > This is just a normal SPI controller from a SPI point of view.

> How can we really represent the stacked mode in current configuration?

In the same way as any other controller with two chip selects...  there
are quite a few other drivers that provide examples of this, you should
look for one that has hardware control similar to yours.

--Dp+ZBeMqOVN1dGc7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpoPqAAoJECTWi3JdVIfQmhcIAIN0uV/a25EOydSwYSr0zH4t
fVlPiwRtgwKXMV3HANEhQwRRKYuyxNGJcxs6Ne4YIgP+GV6AC26tFB2CEZSl6vA6
BtAvfTq+F1EB3a+zMM1ckuaaGYd3zd0YaAS03a4Kc1Fd2dldrUQJXoeYQPF5tBT3
Jcb1Dep0n71fiyY2ncV8qf3to6H2kJc9qroinlHFC8gfkdi/cw55TALJsS8mo4pT
uRUw0eOC0Dbvg7HVCQj+Vxm0MnWuKHvUS+gaXD2ZGUwdiWiiCgrwpNXW013+5SBY
sgGSMTvauG05NvIKjWok1nyWjFrX+3nDuMynZsTkBVak7+K4qThdZV7PREsL5UA=
=UAZc
-----END PGP SIGNATURE-----

--Dp+ZBeMqOVN1dGc7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
