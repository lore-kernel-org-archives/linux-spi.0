From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [Patch V1 2/2] spi: fsl-lpspi: add VLLS mode support
Date: Tue, 17 Jan 2017 07:03:28 +0000
Message-ID: <AM4PR0401MB22737664A5030928464226C7F67C0@AM4PR0401MB2273.eurprd04.prod.outlook.com>
References: <1483522697-6691-1-git-send-email-pandy.gao@nxp.com>
 <1483522697-6691-2-git-send-email-pandy.gao@nxp.com>
 <20170109193350.aufenjuhtge5e3lu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109193350.aufenjuhtge5e3lu-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>   Sent: Tuesday, January 10, =
2017 3:34 AM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [Patch V1 2/2] spi: fsl-lpspi: add VLLS mode support
>=20
> On Wed, Jan 04, 2017 at 05:38:17PM +0800, Gao Pan wrote:
> > When system enters VLLS mode, module power is turned off. As a
> result,
> > all registers are reset to HW default value. After exiting VLLS mode,
> > registers are still in default mode. As a result, the pinctrl settings
> > are incorrect, which will affect the module function.
> >
> > The patch recovers the pinctrl setting when exit VLLS mode.
>=20
> Why is this a change here and not in the pinctrl driver?  It sounds like
> it's the pinctrl driver that's forgetting the settings and should be
> restoring them on resume but perhaps I'm missing something here.
=20
If the pinctrl driver restores the setting on resume, then all device node
should be scanned,  which is irregular.=20

Even though the pinctrl driver can handle all the child node of iomuxc,
it's still difficult for the pinctrl driver to know which device node is di=
sabled
and which device node is okay. Moreover, there may be some pin conflicts
among the child node of iomuxc.

So it's better to do the restore in spi driver other than the pinctrl drive=
r.

Best  Regards
Gao  Pan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
