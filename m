From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: Slow spi_sync() on pxa2xx_spi
Date: Thu, 16 Jun 2011 11:59:34 +0200
Message-ID: <20110616095934.GC10075@excalibur.local>
References: <20110616082112.GA10075@excalibur.local>
	<BANLkTikuo_fHbw9FFMtorpg15vOnXMK-+g@mail.gmail.com>
	<20110616091931.GB10075@excalibur.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, Eric Miao <eric.y.miao@gmail.com>,
	linux-arm-kernel@lists.infradead.org
To: Stefan Schmidt <stefan@datenfreihafen.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110616091931.GB10075@excalibur.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hello.

On Thu, 2011-06-16 at 11:19, Stefan Schmidt wrote:
> 
> On Thu, 2011-06-16 at 16:34, Eric Miao wrote:
> > 
> > What is the SPI frequency?
> 
> I tried various settings in .max_speed_hz from the original 6.6 MHt to
> 10 MHz and 13MHz as maximum of the controller. Did also not change
> anything for me.
> 
> That reminds me that after defining DEBUG in pxa2xx_spi it did always
> report 13MHz to me. Need to have a look at it.

Either the debug statement or the setting is indeed wrong.

[    0.696759] spi spi1.0: 13000000 Hz actual, PIO
[    0.715760] spi spi3.0: 13000000 Hz actual, PIO

Which comes from this part of the driver (with #define DEBUG set):

        /* NOTE:  PXA25x_SSP _could_ use external clocking ... */
        if (!pxa25x_ssp_comp(drv_data))
                dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
                        clk_get_rate(ssp->clk)
                                / (1 + ((chip->cr0 & SSCR0_SCR(0xfff)) >> 8)),
                        chip->enable_dma ? "DMA" : "PIO");
        else
                dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
                        clk_get_rate(ssp->clk) / 2
                                / (1 + ((chip->cr0 & SSCR0_SCR(0x0ff)) >> 8)),
                        chip->enable_dma ? "DMA" : "PIO");

But the board file has this:

static struct spi_board_info spi_board_info[] __initdata = {
        {
                .modalias = "lis3l02dq",
                .max_speed_hz = 8000000,/* 8MHz max spi frequency at 3V */
                .bus_num = 1,
                .chip_select = 0,
                .controller_data = &staccel_chip_info,
                .irq = IRQ_GPIO(96),
        }, {
                .modalias = "cc2420",
//              .max_speed_hz = 6500000,
                .max_speed_hz = 10000000, /* 10MHz */
                .bus_num = 3,
                .chip_select = 0,
                .controller_data = &cc2420_info,
                .platform_data = &cc2420_pdata,

        },
};

Its neither 8MHz for spi1.0 nor 10MHz for spi3.0.

Adding some debug info shows me that the driver gets the data fine form the
platform data:
[    0.695770] spi spi1.0: chip->speed_hz: 8000000, spi->max_speed_hz: 8000000
[    0.695872] spi spi1.0: 13000000 Hz actual, PIO
[    0.714824] spi spi3.0: chip->speed_hz: 10000000, spi->max_speed_hz: 10000000
[    0.714929] spi spi3.0: 13000000 Hz actual, PIO

Thats directly above the chip->cr0 and chip->cr1 calculations. Is this just the
initial seeting and it gets overwritten before a transfer or is the speed
calculation wrong?

regards
Stefan Schmidt
