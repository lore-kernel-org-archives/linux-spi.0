From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Applied "spi: dw: explicitly free IRQ handler in
 dw_spi_remove_host()" to the spi tree
Date: Fri, 23 Oct 2015 19:25:33 +0300
Message-ID: <1445617533.22669.64.camel@linux.intel.com>
References: <E1ZpP0f-0000MP-5w@finisterre>
	 <1445586058.22669.55.camel@linux.intel.com>
	 <20151023161810.GH29919@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023161810.GH29919-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, 2015-10-24 at 01:18 +0900, Mark Brown wrote:
> On Fri, Oct 23, 2015 at 10:40:58AM +0300, Andy Shevchenko wrote:
> > On Fri, 2015-10-23 at 08:11 +0900, Mark Brown wrote:
> > > The patch
>=20
> > > =C2=A0=C2=A0=C2=A0spi: dw: explicitly free IRQ handler in dw_spi_=
remove_host()
>=20
> > This one seems incomplete.
>=20
> > Yes, we already have a fix=C2=A002f20387e1bc in your tree.
>=20
> This *appears* to be the same commit you are following up on (please
> always include human readable descriptions)

This commit (9f89566) is a redundancy made by mistake.

>=20
> > This makes free_irq() call duplicate.

Currently in your for-next branch

void dw_spi_remove_host(struct dw_spi *dws)
{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dw_spi_debugfs_remove(d=
ws);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_irq(dws->irq, dws-=
>master);
^^^ (1)


=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dws->dma_ops && dws=
->dma_ops->dma_exit)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dws->dma_ops->dma_exit(dws);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi_shutdown_chip(dws);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_irq(dws->irq, dws-=
>master);
^^^ (2)
}
EXPORT_SYMBOL_GPL(dw_spi_remove_host);

> >  Please, remove it from your tree
> > or do the revert.
>=20
> Are you saying that you have realised that your patch is broken since
> sending it?=C2=A0=C2=A0I've dropped this commit...

No, the commit=C2=A002f20387e1bc is rightful and should be present in t=
he
tree.

P.S. Commit IDs as they appear in your for-next branch of SPI tree.

--=20
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
