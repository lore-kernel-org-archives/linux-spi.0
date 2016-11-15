From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [Patch v1 1/2] spi: imx: add lpspi bus driver
Date: Tue, 15 Nov 2016 13:29:12 +0000
Message-ID: <AM4PR0401MB1780AD8496E30FF58EF3898CF6BF0@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1479100967-1894-1-git-send-email-pandy.gao@nxp.com>
 <20161114120942.uzswqewdyh3xgfse@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>, Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161114120942.uzswqewdyh3xgfse-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>  Sent: Monday, November 14, 2=
016 8:10 PM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>; Andy Duan
> <fugang.duan-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [Patch v1 1/2] spi: imx: add lpspi bus driver
>=20
> On Mon, Nov 14, 2016 at 01:22:46PM +0800, Gao Pan wrote:
>=20
> > +config SPI_FSL_LPSPI
> > +	tristate "Freescale i.MX LPSPI controller"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	select SPI_BITBANG
>=20
> Don't use SPI_BITBANG for anything that isn't actually bitbanging (which =
this
> clearly isn't).  Use the normal SPI interfaces, all the queue handling th=
at people
> used to abuse SPI_BITBANG for is now in the core.
=20
Thanks,  will change it in next version.=20
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
