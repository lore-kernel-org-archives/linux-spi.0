From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] spi: driver for the Synopsys
	DesignWare SPI controller
Date: Thu, 4 Jun 2009 10:30:23 +0200
Message-ID: <63386a3d0906040130h322028d3ocbd3e31719bac8c9@mail.gmail.com>
References: <1244087418-10889-1-git-send-email-baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1244087418-10889-1-git-send-email-baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2009/6/4 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:

> +static int __devexit designware_spi_remove(struct platform_device *dev)
> +{
> + =A0 =A0 =A0 struct designware_spi *dwspi;
> + =A0 =A0 =A0 struct spi_master *master;
> +
> + =A0 =A0 =A0 master =3D platform_get_drvdata(dev);
> + =A0 =A0 =A0 dwspi =3D spi_master_get_devdata(master);
> +
> + =A0 =A0 =A0 free_irq(dwspi->irq, dwspi);
> + =A0 =A0 =A0 iounmap(dwspi->regs);

release_mem_region()?

> + =A0 =A0 =A0 destroy_workqueue(dwspi->workqueue);
> + =A0 =A0 =A0 tasklet_kill(&dwspi->pump_transfers);
> + =A0 =A0 =A0 platform_set_drvdata(dev, 0);
> + =A0 =A0 =A0 spi_master_put(master);
> +
> + =A0 =A0 =A0 return 0;
> +}


Then it's good :-)

Linus

---------------------------------------------------------------------------=
---
OpenSolaris 2009.06 is a cutting edge operating system for enterprises =

looking to deploy the next generation of Solaris that includes the latest =

innovations from Sun and the OpenSource community. Download a copy and =

enjoy capabilities such as Networking, Storage and Virtualization. =

Go to: http://p.sf.net/sfu/opensolaris-get
