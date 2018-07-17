From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 3/5] spi: dw-mmio: add MSCC Ocelot support
Date: Wed, 18 Jul 2018 00:34:37 +0300
Message-ID: <CAHp75Vcvqqv4kHHDE2wbtVFFa3a5FLqg8meDeOa59-qaDFGFTw@mail.gmail.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com> <20180717142314.32337-4-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717142314.32337-4-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Because the SPI controller deasserts the chip select when the TX fifo is
> empty (which may happen in the middle of a transfer), the CS should be
> handled by linux. Unfortunately, some or all of the first four chip
> selects are not muxable as GPIOs, depending on the SoC.
>
> There is a way to bitbang those pins by using the SPI boot controller so
> use it to set the chip selects.
>
> At init time, it is also necessary to give control of the SPI interface to
> the Designware IP.

> +       ret = dw_spi_mscc_init(pdev, dwsmmio);
> +       if (ret)
> +               goto out;

> +       { .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},

Looks like you were thinking about something like

init_func = device_get_match_data(...);
if (init_func) {
 ret = init_func();
 if (ret)
   return ret;
}

?

-- 
With Best Regards,
Andy Shevchenko
