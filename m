From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi: add spi controller master
 driver for Blackfin 6xx processor
Date: Thu, 6 Jun 2013 10:59:57 +0100
Message-ID: <20130606095957.GO31367@sirena.org.uk>
References: <1370295814-28723-1-git-send-email-scott.jiang.linux@gmail.com>
	<20130603142809.GJ31367@sirena.org.uk>
	<CAHG8p1D8mXq_=3DOBsRMCyRQ9UpWOLbU4y0VYO7PzERxknO7ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0578758538070070670=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <CAHG8p1D8mXq_=3DOBsRMCyRQ9UpWOLbU4y0VYO7PzERxknO7ow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============0578758538070070670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rR/hFfhtjE1dxpg0"
Content-Disposition: inline


--rR/hFfhtjE1dxpg0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2013 at 05:36:07PM +0800, Scott Jiang wrote:
> 2013/6/3 Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>:

> >> +                     if (chip_info->control & ~bfin_ctl_reg) {
> >> +                             dev_err(&spi->dev, "do not set bits "
> >> +                                     "that the SPI framework manages\n");
> >> +                             goto error;

> > Don't split error messages over lines.

> It outputs in one line.

Yes but when I grep for "do not set bits that the SPI framework manages"
after I see it in my kernel output I won't be able to find it because
you split it over multiple lines in the source file.

> >> +static irqreturn_t bfin_spi_tx_dma_isr(int irq, void *dev_id)
> >> +{
> >> +     struct bfin_spi_master *drv_data = dev_id;
> >> +     u32 dma_stat = get_dma_curr_irqstat(drv_data->tx_dma);
> >> +
> >> +     clear_dma_irqstat(drv_data->tx_dma);
> >> +     if (dma_stat & DMA_DONE)
> >> +             drv_data->tx_num++;
> >> +     if (dma_stat & DMA_ERR)
> >> +             dev_err(&drv_data->master->dev,
> >> +                             "spi tx dma error: %d\n", dma_stat);
> >> +     bfin_write_and(&drv_data->regs->tx_control, ~SPI_TXCTL_TDR_NF);
> >> +     return IRQ_HANDLED;
> >> +}

> > This doesn't check that it got a sane state from the hardware - what
> > happens if neither DMA_DONE nor DMA_ERR is true?  I'd also expect us to
> > fail the transfer if we get an error state.

> DMA_DONE means correct, while DMA_ERR means error. Others only tell you
> current status, so when DMA_ERR I output the whole register value to check what
> error is.

That doesn't address my concern - what happens if the hardware messed up
and didn't set either bit?

> > Why free and reallocate the DMA over suspend?

> It's a boot rom bug. If it starts from spi flash, it will polute spi
> and dma status.

OK, document this then - otherwise someone will just come along and
delete the code since it's not obviously sensible.

--rR/hFfhtjE1dxpg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsF2aAAoJELSic+t+oim9IeYP/i9e7q4sR5sSFgKD17mcR5at
OoRuXH0gfzrXv3CK7mgvvm8CqJ4/GqzIP1JAtBlAsNkJr+tfTVsEYfGKW0wMTCpg
drnXSLXJhdu216Xt1Lz4HNL3KJR2BIIWv2ItV+Q0MHc2fT6t1KWHMIEl9/5YVKF+
yq3xikcrbIOTdmZTZ+9SRn4cQBzsAAG0MKQZzs4AxA03Tncf5NxtgUnVWoz+EGi6
Z/ga700ofrjtP9zgoI4aS54vYt7ugSdjGrWmbpuc7ZaonlTQ3kqYSaPUAlNcBpw0
JP3jxetSSQPdYXRSEZmmolxkDb7Lxn/gWx+0N3j4MXPmsoYzKeQ/LudyMwo9jPxr
WMBYfCspDw4X5NHunCRUA+nYMQV5ckWI5Ps197V/7LBLruBAjVjJY4vB75kZxb4H
D3/EKicF2w1KYWf5k4LwjxFEE7shIv59R2SK59zhDXas14hkuUfox6AQsstZ1/jw
T7jqxT0WITOafDgtmmfmfM0SaMi4AO7cr+0KM/mJiSmSc7hED/0OSBJU9yb7cVNq
DsWM6vTaemp5VAJpSQNTOvO4vwspzWFg0QvPSG55GwTyXkAUrkpzKx3SVflzN4iP
WUycdjGDvLbI6hMTC+lcah2TYCG9Ymi4YNTuLRXHH+IL6qwL8VQEK6dziX4EauGh
J1wZY4fxl5f0l6WcsQFL
=cUIx
-----END PGP SIGNATURE-----

--rR/hFfhtjE1dxpg0--

--===============0578758538070070670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============0578758538070070670==--
