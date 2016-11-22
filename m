From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [Patch V2 1/2] spi: imx: add lpspi bus driver
Date: Tue, 22 Nov 2016 13:39:24 +0000
Message-ID: <AM4PR0401MB1780C8905FA43D2F392A7CE3F6B40@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1479216831-8709-1-git-send-email-pandy.gao@nxp.com>
 <20161116173228.cqtt5j5eczgg26gn@sirena.org.uk>
 <AM4PR0401MB1780CDE562EEA1CE202E9572F6B10@AM4PR0401MB1780.eurprd04.prod.outlook.com>
 <20161121172415.vtx7gahbzfgxconf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>, Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161121172415.vtx7gahbzfgxconf-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> Sent: Tuesday, November 22, 2=
016 1:24 AM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Frank Li
> <frank.li-3arQi8VN3Tc@public.gmane.org>; Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [Patch V2 1/2] spi: imx: add lpspi bus driver
>=20
> On Thu, Nov 17, 2016 at 09:55:41AM +0000, Pandy Gao wrote:
>=20
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages
> much easier to read and reply to.

Thanks for the advice.=20

> > From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> Sent: Thursday,
> November
> > 17, 2016 1:32 AM
>=20
> > > Why are we not also unpreparing the clock when the driver is idle?
>=20
> > I use clk_enable()  rather than  clk_prepare_enable() here to avoid
> > potential sleeping in runtime cause by clk_prepare().  clk is prepare
> > in fsl_lpspi_probe() and unprepared in fsl_lpspi_remove().
>=20
> It's absolutely fine to sleep in runtime PM and in the SPI hardware
> prepare and unprepare.

Thanks,  will change it in next version.=20

> > > Why are we doing this linearization into a single buffer?
>=20
> > For a spi  transfer transmitted by lpspi,  the clk for the last bit is
> > incomplete.  The last rising edge never comes unless  we manually
> > de-assert SS.  In case that a spi message contains multiple transfers,
> > SS should be de-asserted for each transfer.
>=20
> > However, for spi device such as m25p80, SS should keep asserted
> during
> > a whole message.  So we need do this linearization here.
>=20
> And the hardware can't do any kind of scatter/gather?  There's two
> things here - one is the combining everything into one hardware
> operation which isn't that uncommon a limitation (though obviously it's
> disappointing) and the other is the fact that in order to do this everyth=
ing
> gets copied into and out of this one buffer which obviously adds quite a
> bit of overhead.

Thanks,  you are right. It's really not a good solution. Will change it in =
next
version.

Best  Regards
Gao Pan=20


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
