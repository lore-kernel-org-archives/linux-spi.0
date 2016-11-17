From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [Patch V2 1/2] spi: imx: add lpspi bus driver
Date: Thu, 17 Nov 2016 09:55:41 +0000
Message-ID: <AM4PR0401MB1780CDE562EEA1CE202E9572F6B10@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1479216831-8709-1-git-send-email-pandy.gao@nxp.com>
 <20161116173228.cqtt5j5eczgg26gn@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>, Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161116173228.cqtt5j5eczgg26gn-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> Sent: Thursday, November 17, 2=
016 1:32 AM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Frank Li <frank.li-vgrsnd+bvIE@public.gmane.org=
m>;
> Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [Patch V2 1/2] spi: imx: add lpspi bus driver
>=20
> On Tue, Nov 15, 2016 at 09:33:50PM +0800, Gao Pan wrote:
>=20
> > +static int
> > +fsl_lpspi_prepare_message(struct spi_master *master, struct
> > +spi_message *msg) {
> > +	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
> > +
> > +	return clk_enable(fsl_lpspi->clk);
> > +}
>=20
> Why are we not also unpreparing the clock when the driver is idle?
=20
I use clk_enable()  rather than  clk_prepare_enable() here to avoid potenti=
al sleeping in runtime cause by clk_prepare().  clk is prepare in fsl_lpspi=
_probe() and unprepared in fsl_lpspi_remove().

> > +static void fsl_lpspi_copy_to_buf(struct spi_message *m,
> > +					struct fsl_lpspi_data *fsl_lpspi) {
> > +	struct spi_transfer *t;
> > +	u8 *buf =3D fsl_lpspi->local_buf;
> > +
> > +	list_for_each_entry(t, &m->transfers, transfer_list) {
> > +		if (t->tx_buf)
> > +			memcpy(buf, t->tx_buf, t->len);
> > +		else
> > +			memset(buf, 0, t->len);
> > +		buf +=3D t->len;
> > +	}
> > +}
>=20
> Why are we doing this linearization into a single buffer?
=20
For a spi  transfer transmitted by lpspi,  the clk for the last bit is inco=
mplete.  The last rising edge never comes unless  we manually de-assert SS.=
 =20
In case that a spi message contains multiple transfers, SS should be de-ass=
erted for each transfer.

However, for spi device such as m25p80, SS should keep asserted during a wh=
ole message.  So we need do this linearization here.

Thanks!

> > +static int fsl_lpspi_check_message(struct spi_message *m) {
>=20
> If there's any checks in here that aren't done by the core then extend th=
e core
> to support them (or drop them).

Due to the limitation of lpspi IP,  all transfers in a message should have =
same " speed_hz" & " bits_per_word".=20
fsl_lpspi_check_message() is used to check the coherence of separate transf=
ers.

This  limitation may not be applicable for other spi.  Do you still think t=
he check should be extend to core?

> > +static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
> > +					struct spi_message *m)
> > +{
>=20
> Why are we doing transfer_one_msg() and not transfer_one()?

transfer_one() is used for separate spi transfer, which is not applicable t=
o lpspi.=20
Because lpspi need to intergrate all message transfers  into one  transfer.=
=20
=20
>=20
> > +	m->actual_length =3D ret ? 0 : trans.len;
>=20
> Please write normal if statements, people should be able to read the code=
.

Thanks, will change it in next version.  =20

> > +out:
> > +	if (m->status =3D=3D -EINPROGRESS)
> > +		m->status =3D ret;
>=20
> Why not for other errors?

Should be "m->status =3D ret" regardless of errors types. Thanks, will chan=
ge it in next version.

Best  Regards
Gao Pan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
