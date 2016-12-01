From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [Patch V1 2/2] imx: spi: read lpspi tx/rx fifo size in probe()
Date: Thu, 1 Dec 2016 01:49:45 +0000
Message-ID: <AM4PR0401MB17809F9F60719D96B126A085F68F0@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1480302180-15550-1-git-send-email-pandy.gao@nxp.com>
 <1480302180-15550-2-git-send-email-pandy.gao@nxp.com>
 <20161130175544.rdsl3wahswxewvyb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>, Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161130175544.rdsl3wahswxewvyb-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> Sent: Thursday, December 01, =
2016 1:56 AM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>; Andy Duan
> <fugang.duan-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [Patch V1 2/2] imx: spi: read lpspi tx/rx fifo size in probe=
()
>=20
> On Mon, Nov 28, 2016 at 11:03:00AM +0800, Gao Pan wrote:
> > The lpspi tx/rx fifo size is a read only parameter resides lpspi
> > Parameter Register. It's better to read lpspi tx/rx fifo size in
> > probe().
>=20
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem.  This makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
=20
Thanks,  will pay attention to it for incremental patches.

Best  Regards
Gao Pan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
