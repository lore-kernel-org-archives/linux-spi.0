From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] spi: mt7621: Move SPI driver out of staging
Date: Fri, 22 Mar 2019 15:02:54 +0100
Message-ID: <2e3a6928-b086-920c-be6f-9f508af4dc5f@denx.de>
References: <20190314115212.2396-1-sr@denx.de>
 <20190321142550.GG5684@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: devel@driverdev.osuosl.org, Rob Herring <robh@kernel.org>,
 Sankalp Negi <sankalpnegi2310@gmail.com>, John Crispin <john@phrozen.org>,
 linux-spi@vger.kernel.org, Armando Miraglia <arma2ff0@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neil@brown.name>
To: Mark Brown <broonie@kernel.org>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190321142550.GG5684@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

On 21.03.19 15:25, Mark Brown wrote:
> On Thu, Mar 14, 2019 at 12:52:12PM +0100, Stefan Roese wrote:
> 
> This looks pretty good, a few trivial issues below but nothing major I
> think.
> 
>> +config SPI_MT7621
>> +	tristate "MediaTek MT7621 SPI Controller"
>> +	depends on RALINK
>> +	help
>> +	  This selects a driver for the MediaTek MT7621 SPI Controller.
>> +
> 
> I'm not seeing any build time dependency on this, please add an ||
> COMPILE_TEST to help with build testing.

Okay, will add in v2.
  
>> @@ -0,0 +1,422 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * spi-mt7621.c -- MediaTek MT7621 SPI controller driver
>> + *
> 
> Please make the entire comment a C++ one to

Will change in v2.
  
>> + * Some parts are based on spi-orion.c:
>> + *   Author: Shadi Ammouri <shadi@marvell.com>
>> + *   Copyright (C) 2007-2008 Marvell Ltd.
> 
> That driver dates from 2008 AFAICT, and had some changes after then?

The spi-orion driver? I didn't check. That's what in the header of
this driver since quite some time. And I didn't want to change any
copyright notices.

BTW: spi-orion still has the same copyright message.
  
>> +static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
>> +{
>> +	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
>> +	int cs = spi->chip_select;
>> +	u32 polar = 0;
>> +
>> +	mt7621_spi_reset(rs);
>> +	if (enable)
>> +		polar = BIT(cs);
>> +	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
>> +}
> 
> Will doing a reset mess up the rate configuration and stuff that's done
> in _prepare(), or is _reset() perhaps not an entirely accurate name?

You are correct. The function name is not really matching its
implementation. Will change in v2.
  
>> +	list_for_each_entry(t, &m->transfers, transfer_list)
>> +		if (t->speed_hz < speed)
>> +			speed = t->speed_hz;
> 
> This should be in the core if it's needed, it's going to be the same for
> all drivers.

I'm not sure here, other drivers might set the speed individually for
each "spi_transfer" entry. In this driver its set only once: before
beginning to transfer all entries. So should I really move this into
the core and set all speed_hz values to the minimum one of the list?
  
>> +	master->setup = mt7621_spi_setup;
>> +	master->transfer_one_message = mt7621_spi_transfer_one_message;
>> +	master->bits_per_word_mask = SPI_BPW_MASK(8);
>> +	master->dev.of_node = pdev->dev.of_node;
>> +	master->num_chipselect = 2;
> 
> The driver should set SPI_CONTROLLER_HALF_DUPLEX in flags.

Will update in v2.
  
>> +	clk_disable(rs->clk);
> 
> This needs to be clk_disable_unprepare() to ensure the clock is
> unprepared as well as disabled.

Okay, will change in v2.
  
>> +	spi_unregister_master(master);
> 
> Just use devm_spi_register_controller()?  The _master() name is legacy
> and devm_ would make life easier.

Yes, will change in v2.

Thanks for the review.

Thanks,
Stefan
