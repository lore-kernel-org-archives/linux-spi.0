From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 10/12] spi: add driver for J-Core SPI controller
Date: Fri, 20 May 2016 10:15:08 +0200
Message-ID: <CAMuHMdXLYeZnzh-FDKd8r7+eY0xNPmYixP3njniPvb4w5Cv7GQ@mail.gmail.com>
References: <cover.1463708766.git.dalias@libc.org>
	<2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
To: Rich Felker <dalias@libc.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> --- /dev/null
> +++ b/drivers/spi/spi-jcore.c

> +static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi, struct spi_transfer *t)
> +{
> +       struct jcore_spi *hw = spi_master_get_devdata(master);
> +
> +       void *ctrl_reg = hw->base + CTRL_REG;
> +       void *data_reg = hw->base + DATA_REG;
> +       int timeout;

unsigned int

> +       int xmit;

u32

> +       int status;

u32

> +
> +       /* data buffers */
> +       const unsigned char *tx;
> +       unsigned char *rx;
> +       int len;

unsigned int

> +       int count;

unsigned int

> +
> +       jcore_spi_baudrate(hw, t->speed_hz);
> +
> +       xmit = hw->csReg | hw->speedReg | JCORE_SPI_CTRL_XMIT;
> +       tx = t->tx_buf;
> +       rx = t->rx_buf;
> +       len = t->len;
> +
> +       for (count = 0; count < len; count++) {
> +               timeout = JCORE_SPI_WAIT_RDY_MAX_LOOP;
> +               do status = readl(ctrl_reg);
> +               while ((status & JCORE_SPI_STAT_BUSY) && --timeout);

do {
        ...
} while (...)

> +               if (!timeout) break;

if (...)
        ...

> +
> +               writel(tx ? *tx++ : 0, data_reg);

You can remove the check for tx if you set the SPI_MASTER_MUST_TX
flag in spi_master.flags.

> +               writel(xmit, ctrl_reg);
> +
> +               timeout = JCORE_SPI_WAIT_RDY_MAX_LOOP;
> +               do status = readl(ctrl_reg);
> +               while ((status & JCORE_SPI_STAT_BUSY) && --timeout);

do {
        ...
} while (...)

> +               if (!timeout) break;


if (...)
        ...

> +
> +               if (rx) *rx++ = readl(data_reg);


if (...)
        ...

> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
