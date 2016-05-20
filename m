From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 10/12] spi: add driver for J-Core SPI controller
Date: Fri, 20 May 2016 18:50:13 -0400
Message-ID: <20160520225013.GX21636@brightrain.aerifal.cx>
References: <cover.1463708766.git.dalias@libc.org>
 <2e287ca758002621ef8eed3db9df37678e26af5e.1463708766.git.dalias@libc.org>
 <CAMuHMdXLYeZnzh-FDKd8r7+eY0xNPmYixP3njniPvb4w5Cv7GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXLYeZnzh-FDKd8r7+eY0xNPmYixP3njniPvb4w5Cv7GQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 20, 2016 at 10:15:08AM +0200, Geert Uytterhoeven wrote:
> On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> > --- /dev/null
> > +++ b/drivers/spi/spi-jcore.c
> 
> > +static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi, struct spi_transfer *t)
> > +{
> > +       struct jcore_spi *hw = spi_master_get_devdata(master);
> > +
> > +       void *ctrl_reg = hw->base + CTRL_REG;
> > +       void *data_reg = hw->base + DATA_REG;
> > +       int timeout;
> 
> unsigned int

All of these have value ranges where the type is irrelevant, but I'm
happy to change it to whatever types you prefer.

> > +       jcore_spi_baudrate(hw, t->speed_hz);
> > +
> > +       xmit = hw->csReg | hw->speedReg | JCORE_SPI_CTRL_XMIT;
> > +       tx = t->tx_buf;
> > +       rx = t->rx_buf;
> > +       len = t->len;
> > +
> > +       for (count = 0; count < len; count++) {
> > +               timeout = JCORE_SPI_WAIT_RDY_MAX_LOOP;
> > +               do status = readl(ctrl_reg);
> > +               while ((status & JCORE_SPI_STAT_BUSY) && --timeout);
> 
> do {
>         ...
> } while (...)
> 
> > +               if (!timeout) break;
> 
> if (...)
>         ...

OK. (for this and other instances)

> > +
> > +               writel(tx ? *tx++ : 0, data_reg);
> 
> You can remove the check for tx if you set the SPI_MASTER_MUST_TX
> flag in spi_master.flags.

I don't want to do that, because the new version of the hardware
that's going to support DMA can only do unidirectional DMA, and thus
we need to be able to see if either tx or rx is null.

Rich
