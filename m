From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [bug report] spi: imx: add lpspi bus driver
Date: Thu, 24 Nov 2016 01:36:36 +0000
Message-ID: <AM4PR0401MB1780CF80424B9054E7708C7EF6B60@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <20161123225719.GA16302@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161123225719.GA16302@mwanda>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Dan Carpenter <mailto:dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>  Sent: Thursday, Nove=
mber 24, 2016 6:57 AM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [bug report] spi: imx: add lpspi bus driver
>=20
> Hello Gao Pan,
>=20
> The patch 5314987de5e5: "spi: imx: add lpspi bus driver" from Nov 22,
> 2016, leads to the following static checker warning:
>=20
> 	drivers/spi/spi-fsl-lpspi.c:220 fsl_lpspi_set_cmd()
> 	warn: potential shift truncation.  '0x11 << 30'
>=20
> drivers/spi/spi-fsl-lpspi.c
>    213  static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
>    214                                bool is_first_xfer)
>    215  {
>    216          u32 temp =3D 0;
>    217
>    218          temp |=3D fsl_lpspi->config.bpw - 1;
>    219          temp |=3D fsl_lpspi->config.prescale << 27;
>    220          temp |=3D (fsl_lpspi->config.mode & 0x11) << 30;
>=20
> Are you sure you didn't intend to write:
>=20
> 		temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
>=20
> The current code doesn't make sense at any rate.

Yes, you are right. Will submit a patch to fix this bug. Thanks!

Best  Regards
Gao Pan

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
