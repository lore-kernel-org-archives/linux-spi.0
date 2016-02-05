From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Analog Devices AXI SPI Engine controller
 support
Date: Fri, 5 Feb 2016 15:30:01 +0100
Message-ID: <56B4B1E9.7080804@metafoo.de>
References: <1454602410-14049-1-git-send-email-lars@metafoo.de>
 <1454602410-14049-2-git-send-email-lars@metafoo.de>
 <CAHp75VcQ1WrHVxk=6xNrjhsep=2YhcMLiXAPChXeB+fG3MX2fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcQ1WrHVxk=6xNrjhsep=2YhcMLiXAPChXeB+fG3MX2fQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

Thanks for review.

On 02/05/2016 03:04 PM, Andy Shevchenko wrote:
[...]
>> +++ b/drivers/spi/spi-axi-spi-engine.c
>> @@ -0,0 +1,591 @@
> 
>> +static unsigned int spi_engine_get_clk_div(struct spi_engine *spi_engine,
>> +       struct spi_device *spi, struct spi_transfer *xfer)
>> +{
>> +       unsigned int clk_div;
>> +
>> +       clk_div = DIV_ROUND_UP(clk_get_rate(spi_engine->ref_clk),
>> +               xfer->speed_hz * 2);
> 
>> +       if (clk_div > 255)
>> +               clk_div = 255;
>> +       else if (clk_div > 0)
>> +               clk_div -= 1;
> 
> 255 is okay, 254 is not, 253- is okay. Why 254 is so special?

I don't see that. The condition is > 255, so everything greater or equal
than 256 gets mapped to 255. Everything else to x - 1, so 255 to 254, 254 to
253.

> 
>> +
>> +       return clk_div;
>> +}
> 
> 
>> +static int spi_engine_compile_message(struct spi_engine *spi_engine,
>> +       struct spi_message *msg, bool dry, struct spi_engine_program *p)
>> +{
>> +       struct spi_device *spi = msg->spi;
>> +       struct spi_transfer *xfer;
>> +       int clk_div, new_clk_div;
>> +       bool cs_change = true;
>> +
>> +       clk_div = -1;
>> +
>> +       spi_engine_program_add_cmd(p, dry,
>> +               SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
>> +                       spi_engine_get_config(spi)));
>> +
>> +       list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>> +               new_clk_div = spi_engine_get_clk_div(spi_engine, spi, xfer);
> 
>> +               if (new_clk_div != clk_div) {
>> +                       clk_div = new_clk_div;
>> +                       spi_engine_program_add_cmd(p, dry,
>> +                               SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CLK_DIV,
>> +                                       clk_div));
>> +               }
> 
> Shouldn't be speed programmed per transfer?

Speed is programmed if it is not the same as the previous transfer. For the
first transfer in the message it always gets programmed.

> 
>> +
>> +               if (cs_change)
>> +                       spi_engine_gen_cs(p, dry, spi, true);
>> +
>> +               spi_engine_gen_xfer(p, dry, xfer);
>> +               spi_engine_gen_sleep(p, dry, spi_engine, clk_div,
>> +                       xfer->delay_usecs);
>> +
>> +               cs_change = xfer->cs_change;
>> +               if (list_is_last(&xfer->transfer_list, &msg->transfers))
>> +                       cs_change = !cs_change;
>> +
>> +               if (cs_change)
>> +                       spi_engine_gen_cs(p, dry, spi, false);
>> +       }
>> +
>> +       return 0;
>> +}
[...]
>> +static bool spi_engine_write_tx_fifo(struct spi_engine *spi_engine)
>> +{
>> +       void __iomem *addr = spi_engine->base + SPI_ENGINE_REG_SDO_DATA_FIFO;
>> +       unsigned int n, m, i;
>> +       const uint8_t *buf;
>> +
>> +       n = readl_relaxed(spi_engine->base + SPI_ENGINE_REG_SDO_FIFO_ROOM);
>> +       while (n && spi_engine->tx_length) {
>> +               m = min(n, spi_engine->tx_length);
>> +               buf = spi_engine->tx_buf;
> 
>> +               for (i = 0; i < m; i++)
>> +                       writel_relaxed(buf[i], addr);
> 
> writesl() ?

Hm, maybe. Does it really have the same semantics?

> 
>> +               spi_engine->tx_buf += m;
>> +               spi_engine->tx_length -= m;
>> +               n -= m;
>> +               if (spi_engine->tx_length == 0)
>> +                       spi_engine_tx_next(spi_engine);
>> +       }
>> +
>> +       return spi_engine->tx_length != 0;
>> +}
>> +
[...]
>> +static int spi_engine_transfer_one_message(struct spi_master *master,
>> +       struct spi_message *msg)
> 
> And you are not using transfer_one() because of..?

transfer_one() does flow control in software. Execution is passed back to
software after each transfer and it also takes care of handling the chip
select assertion/deassertion as well as the delays. It's useful for hardware
which does not support hardware flow control. In this case the hardware
supports flow control including chip-select logic as well as delays. Making
use of this generates far less context switches per message and also has
predictable timings between transfers within a message.

[...]
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
