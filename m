From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 0/5] Add support for the Armada 3700 SPI controller
Date: Wed, 30 Nov 2016 15:30:35 +0100
Message-ID: <87bmwxm450.fsf@free-electrons.com>
References: <20161130094351.2748-1-romain.perier@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
        Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
To: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161130094351.2748-1-romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> (Romain
        Perier's message of "Wed, 30 Nov 2016 10:43:46 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Romain,
 
 On mer., nov. 30 2016, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> The Marvell Armada 3700 SoC includes an SPI controller. This controller
> supports up to 4 SPI slave devices, with dedicated chip selects, CPIO or
> FIFO mode with DMA or CPU transfers and different SPI transfer modes
> (Standard single, Dual or Quad).
>
> This set of patches adds a basic support for the CPIO mode, then it
> enables the FIFO mode (CPU-side only, DMA not supported yet). It also
> adds the required definitions of the spi nodes to the devicetree.
>

I tested the series on the Rev 1.1 and the Rev 2.0 Armada 3720 Db board
and it works on both of them: I managed at leat to read the spi
dataflash.

So for the series you can add my

Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,

Gregory



> Romain Perier (5):
>   spi: Add basic support for Armada 3700 SPI Controller
>   spi: armada-3700: Add support for the FIFO mode
>   dt-bindings: spi: Add documentation for the Armada 3700 SPI Controller
>   arm64: dts: marvell: Add definition of SPI controller for Armada 3700
>   arm64: dts: marvell: Enable spi0 on the board Armada-3720-db
>
>  .../devicetree/bindings/spi/spi-armada-3700.txt    |   25 +
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   30 +
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   13 +
>  drivers/spi/Kconfig                                |    7 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-armada-3700.c                      | 1040 ++++++++++++++++++++
>  6 files changed, 1116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt
>  create mode 100644 drivers/spi/spi-armada-3700.c
>
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
