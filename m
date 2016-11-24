From: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [Patch V3 2/2] spi: imx: add lpspi bus driver
Date: Thu, 24 Nov 2016 01:41:08 +0000
Message-ID: <AM4PR0401MB178070BEAF1DD6D2EA104A0FF6B60@AM4PR0401MB1780.eurprd04.prod.outlook.com>
References: <1479822737-8170-1-git-send-email-pandy.gao@nxp.com>
 <1479822737-8170-2-git-send-email-pandy.gao@nxp.com>
 <20161122191308.uuuiea54oi65jbu4@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Frank Li <frank.li-3arQi8VN3Tc@public.gmane.org>, Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161122191308.uuuiea54oi65jbu4-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 From: Mark Brown <mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>  Sent: Wednesday, November 23=
, 2016 3:13 AM
> To: Pandy Gao <pandy.gao-3arQi8VN3Tc@public.gmane.org>
> Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Frank Li
> <frank.li-3arQi8VN3Tc@public.gmane.org>; Andy Duan <fugang.duan-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [Patch V3 2/2] spi: imx: add lpspi bus driver
>=20
> On Tue, Nov 22, 2016 at 09:52:17PM +0800, Gao Pan wrote:
> > This patch adds lpspi driver to support new i.MX products which use
> > lpspi instead of ecspi.
>=20
> I'll apply this but there's some small issues, can you please fix them up
> with incremental patches:
>
> > +static int fsl_lpspi_prepare_message(struct spi_master *master,
> > +				     struct spi_message *msg)
> > +{
> > +	struct fsl_lpspi_data *fsl_lpspi =3D
> spi_master_get_devdata(master);
> > +
> > +	return clk_prepare_enable(fsl_lpspi->clk);
> > +}
>=20
> Rather than doing this per message it's a bit better to do it in
> prepare_transfer_hardware(), that way if there's a sequence of messages
> queued one after another we don't turn the clock on and off all the time.
> In practice it's likely to make a negligable difference to performance bu=
t
> it's just better practice.
>=20
> > +static int fsl_lpspi_txfifo_empty(struct fsl_lpspi_data *fsl_lpspi) {
> > +	u32 txcnt;
> > +	unsigned long orig_jiffies =3D jiffies;
> > +
> > +	do {
> > +		txcnt =3D readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
> > +
> > +		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500)))
> {
> > +			dev_dbg(fsl_lpspi->dev, "txfifo empty
> timeout\n");
> > +			return -ETIMEDOUT;
> > +		}
> > +		schedule();
>=20
> Call cond_resched() instead, it has the effect you're looking for in a mo=
re
> modern way.
=20
Thanks, will submit  incremental patches to fix them up.

Best Regards
Gao Pan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
