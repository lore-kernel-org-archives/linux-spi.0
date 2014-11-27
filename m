From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Add new driver for STMicroelectronics' SPI
 Controller
Date: Thu, 27 Nov 2014 15:05:08 +0000
Message-ID: <20141127150508.GI4628@x1>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
 <1417088636-11994-2-git-send-email-lee.jones@linaro.org>
 <20141127125904.GV7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141127125904.GV7712-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

[...]

> > +struct spi_st {
> > +	/* SSC SPI Controller */
> > +	struct spi_bitbang	bitbang;
>=20
> Is there a good reason for using bitbang over the core transmit_one()
> interface?  The operations are basically the same but more modern and
> the functionality is more discoverable.

I don't know enough about SPI to answer that question.  I will look
into moving over to transmit_one().  Most of the design decisions in
this driver were taken back when you were probably wearing denim
jackets and supporting an afro. ;)=20


> > +	} else if (spi_st->bits_per_word =3D=3D 8 && !(t->len & 0x1)) {
> > +		/*
> > +		 * If transfer is even-length, and 8 bits-per-word, then
> > +		 * implement as half-length 16 bits-per-word transfer
> > +		 */
> > +		spi_st->bytes_per_word =3D 2;
> > +		spi_st->words_remaining =3D t->len/2;
> > +
> > +		/* Set SSC_CTL to 16 bits-per-word */
> > +		ctl =3D readl_relaxed(spi_st->base + SSC_CTL);
> > +		writel_relaxed((ctl | 0xf), spi_st->base + SSC_CTL);
> > +
> > +		readl_relaxed(spi_st->base + SSC_RBUF);
>=20
> No byte swapping issues here?

I think this implementation has been pretty heavily tested.  What
should I be looking out for?

[...]

> > +	printk("LEE: %s: %s()[%d]: Probing\n", __FILE__, __func__, __LINE=
__);
>=20
> Tsk.

School boy error!

> > +	spi_st->clk =3D of_clk_get_by_name(np, "ssc");
> > +	if (IS_ERR(spi_st->clk)) {
> > +		dev_err(&pdev->dev, "Unable to request clock\n");
> > +		ret =3D PTR_ERR(spi_st->clk);
> > +		goto free_master;
> > +	}
>=20
> Why is this of_get_clk_by_name() and not just devm_clk_get()?

Probably historical and I didn't notice.

I'll look into swapping it over.

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
