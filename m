From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 1/5] spi: do not fail if the CS line is not connected
Date: Fri, 17 Jun 2016 20:36:22 +0900
Message-ID: <20160617113622.GA10760@jack.zhora.eu>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
 <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
 <20160617104725.GC26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Shyti <andi.shyti@samsung.com>, Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Andi Shyti <andi@etezian.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160617104725.GC26099@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> > Some SPI connected devices do not have any CS line connected as
> > some devices are alway enabled. Indeed, until now, a common
> > workaround was to assign to num_chipselect a -1 value or 255
> > (num_chipselect is unsigned).
> > 
> > In this case do not fail and defer to the SPI device drivers the
> > responsibility to check whether the num-cs is '0'.
> 
> A SPI controller always has one chip seelct, it may not be controllable
> but it's at least logically present.

This is true, but there are cases where the CS is not connected
and this case needs to be treated separately to allow the device
to work.

This is the case of:

./drivers/spi/spi-mpc52xx-psc.c:391: master->num_chipselect = 255;
./drivers/spi/spi-oc-tiny.c:256:        master->num_chipselect = 255;

and

./drivers/spi/spi-pxa2xx-pci.c:64:              .num_chipselect = -1,
./drivers/spi/spi-bcm2835aux.c:436:     master->num_chipselect = -1;

that in my opinion make even less sense. The latter is completely
broken, as num_chipselect is an u16 variable. Because of this I
had to do the same in a driver that I will send next (and perhaps
it will be rejected).

So, IMHO, it's better to not be that strong on num_chipselect
being non zero, as there are cases where the CS _line_ is not
connected.

Andi
