From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 10/13] spi: sunxi: merge sun4i and sun6i
 SPI driver
Date: Tue, 14 Jun 2016 06:34:45 +0200
Message-ID: <CAOMqctQD=o6YBk-QRiqbE9Cj+ZAH1nAM33rW6ZHefV8dU3aucQ@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com> <ad0ec30ef6b01f58e1b3b92da06e6cbd5c947354.1465490774.git.hramrach@gmail.com>
 <CAGRGNgVONS+i=57D52VeW8J6SvfmX=iG+3VpxNS8=kJOV+WSLw@mail.gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timo Sigurdsson <public_timo.s-fWgRPtSzPNU3WX+qO2AYSQ@public.gmane.org>, Jonathan Liu <net147-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	devicet
To: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCQMLUOX54MBBDMT725AKGQEDQ7XJYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGRGNgVONS+i=57D52VeW8J6SvfmX=iG+3VpxNS8=kJOV+WSLw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hello,

On 14 June 2016 at 01:43, Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Michal,
>
> On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> The drivers are very similar and share multiple flaws which needed
>> separate fixes for both drivers.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/spi/Kconfig     |   8 +-
>>  drivers/spi/Makefile    |   1 -
>>  drivers/spi/spi-sun4i.c | 156 +++++++++++--
>>  drivers/spi/spi-sun6i.c | 598 ------------------------------------------------
>>  4 files changed, 143 insertions(+), 620 deletions(-)
>>  delete mode 100644 drivers/spi/spi-sun6i.c
>>
>> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
>> index 0b8e6c6..c76f8e4 100644
>> --- a/drivers/spi/spi-sun4i.c
>> +++ b/drivers/spi/spi-sun4i.c
>> @@ -279,9 +321,14 @@ static int sunxi_spi_transfer_one(struct spi_master *master,
>>         reg = sunxi_spi_read(sspi, SUNXI_TFR_CTL_REG);
>>
>>         /* Reset FIFOs */
>> -       sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>> -                       reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>> -                       sspi_bits(sspi, SUNXI_CTL_TF_RST));
>> +       if (sspi->type == SPI_SUN4I)
>> +               sunxi_spi_write(sspi, SUNXI_TFR_CTL_REG,
>> +                               reg | sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>> +       else
>> +               sunxi_spi_write(sspi, SUNXI_FIFO_CTL_REG,
>> +                               sspi_bits(sspi, SUNXI_CTL_RF_RST) |
>> +                               sspi_bits(sspi, SUNXI_CTL_TF_RST));
>
> If we're already doing different stuff for each generation of the IP,
> why not just use the register offsets and bit definitions directly?

Because having (*sspi->regmap)[SUNXI_FIFO_CTL_REG] all over the place
makes my eyes bleed and you cannot use the check that you are
accessing a register that actually exists.

>> @@ -491,10 +558,37 @@ static int sunxi_spi_probe(struct platform_device *pdev)
>>         }
>>
>>         sspi->master = master;
>> -       sspi->fifo_depth = SUN4I_FIFO_DEPTH;
>> -       sspi->type = SPI_SUN4I;
>> -       sspi->regmap = &sun4i_regmap;
>> -       sspi->bitmap = &sun4i_bitmap;
>> +       if (of_device_is_compatible(pdev->dev.of_node, SUN4I_COMPATIBLE)) {
>> +               sspi->fifo_depth = SUN4I_FIFO_DEPTH;
>> +               sspi->type = SPI_SUN4I;
>> +               sspi->regmap = &sun4i_regmap;
>> +               sspi->bitmap = &sun4i_bitmap;
>> +       } else if (of_device_is_compatible(pdev->dev.of_node,
>> +                                          SUN6I_COMPATIBLE)) {
>> +               sspi->fifo_depth = SUN6I_FIFO_DEPTH;
>> +               sspi->type = SPI_SUN6I;
>> +               sspi->regmap = &sun6i_regmap;
>> +               sspi->bitmap = &sun6i_bitmap;
>
> Can you store data in the match table instead of doing this?

That might be nicer. Will look into this.

Thanks

Michal
