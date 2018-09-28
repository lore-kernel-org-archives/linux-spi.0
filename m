From: Ryan Case <ryandcase@chromium.org>
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Fri, 28 Sep 2018 11:19:51 -0700
Message-ID: <CACjz--=Qj8Jd9yCvox1MGh1PFkHAzpt1L0OwPkMhtV30_jCDWA@mail.gmail.com>
References: <20180926205204.184898-1-ryandcase@chromium.org>
 <20180926205204.184898-2-ryandcase@chromium.org> <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153803059441.119890.891880266219521584@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 26, 2018 at 11:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Ryan Case (2018-09-26 13:52:04)
> > From: Girish Mahadevan <girishm@codeaurora.org>
> > +#include <asm/unaligned.h>
> > +
> > +#define AHB_MIN_HZ             9600000UL
>
> Is this used?

Nope. Do you want all currently unused defines removed or specifically this
one? I saw precedent in other drivers for defining registers/flags/values of
supported but unused functionality so I left these (big endian, DDR, ...).


> > +       speed_hz = slv->max_speed_hz;
> > +       if (xfer->speed_hz)
> > +               speed_hz = xfer->speed_hz;
> > +
> > +       ret = clk_set_rate(ctrl->clks[QSPI_CLK_CORE].clk, speed_hz * 4);
>
> Why 4? Is that related to the number of wires?

In normal operation the core clock should be running at 4x the rate of the
transfer clock regardless of number of wires used.

> > +                       put_unaligned(rd_fifo, word_buf++);
> > +               }
> > +               ctrl->xfer.rx_buf = word_buf;
> > +       }
> > +
> > +       if (bytes_to_read) {
> > +               byte_buf = ctrl->xfer.rx_buf;
>
> Does this need to move forward by words_to_read bytes so that the left
> over bytes are tacked onto the end? Or this should be an else if
> statement?

When the words block completes it updates the rx_buf location so it is already
at the correct offset for bytes.

> > +
> > +       master->max_speed_hz = 300000000;
> > +       master->num_chipselect = QSPI_NUM_CS;
> > +       master->bus_num = pdev->id;
>
> Can this come from DT aliases? I've never thought about qspi and
> "regular" spi being in the same spi bus numbering system, but I suppose
> that will happen now and we need to make sure that qspi numbers start
> after the regular ones?

I'm not sure. Can look into it.

>
> > +       master->dev.of_node = pdev->dev.of_node;
> > +       master->mode_bits = SPI_MODE_0 |
> > +                           SPI_TX_DUAL | SPI_RX_DUAL |
> > +                           SPI_TX_QUAD | SPI_RX_QUAD;
> > +       master->flags = SPI_MASTER_HALF_DUPLEX;
> > +       master->prepare_message = qcom_qspi_prepare_message;
> > +       master->transfer_one = qcom_qspi_transfer_one;
