From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Tue, 2 Oct 2018 11:45:10 -0700
Message-ID: <CAD=FV=WxL8HO3qKMF_3DXXLCqOZh8FDFUyuvgDwhQGjVxUN7cQ@mail.gmail.com>
References: <20181002013142.209751-1-ryandcase@chromium.org> <20181002013142.209751-2-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Trent Piepho <tpiepho@impinj.com>, boris.brezillon@bootlin.com,
        Girish Mahadevan <girishm@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: ryandcase@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002013142.209751-2-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Mon, Oct 1, 2018 at 6:32 PM Ryan Case <ryandcase@chromium.org> wrote:
> +#include <asm/unaligned.h>

Don't need unaligned.h any more do you?


> +#define RD_FIFO_CFG            0x0028
> +#define CONTINUOUS_MODE                BIT(0)
> +
> +#define RD_FIFO_RESET          0x0030
> +#define RESET_FIFO             BIT(0)
> +
> +#define PIO_XFER_CFG           0x0018

nit: when you moved the bits next to the registers you reordered the
registers.  I would have expected 0x0018 to be above 0x0028 though.
Similar 0x0014 (below) should be above 0x0018.


> +#define CUR_MEM_ADDR           0x0048
> +#define HW_VERSION             0x004c
> +#define RD_FIFO                        0x0050
> +#define SAMPLING_CLK_CFG       0x0090
> +#define SAMPLING_CLK_STATUS    0x0094
> +
> +
> +

nit: one less blank line?


> +static int qspi_buswidth_to_iomode(struct qcom_qspi *ctrl,
> +                                  unsigned int buswidth)
> +{
> +       switch (buswidth) {
> +       case 1:
> +               return SDR_1BIT << MULTI_IO_MODE_SHFT;
> +       case 2:
> +               return SDR_2BIT << MULTI_IO_MODE_SHFT;
> +       case 4:
> +               return SDR_4BIT << MULTI_IO_MODE_SHFT;
> +       default:
> +               dev_warn_once(ctrl->dev,
> +                               "Unexpected bus width: %u\n", buswidth);
> +               return SDR_1BIT << MULTI_IO_MODE_SHFT;
> +       }

nit: now that this function is returning something that's shifted (and
so something in the format of a hardware register) it should return
u32.


> +       if (ctrl->xfer.dir == QSPI_WRITE) {
> +               if (int_status & WR_FIFO_EMPTY)
> +                       ret = pio_write(ctrl);
> +       } else if (ctrl->xfer.dir == QSPI_READ) {

I'd maybe just call this "else" not "else if".  "dir" can either be
read or write--there are no other options.


> +               if (int_status & RESP_FIFO_RDY)
> +                       ret = pio_read(ctrl);
> +       } else if (int_status & QSPI_ERR_IRQS) {

You can't have "else" here, especially since dir should either be
WRITE or READ you'll never end up here.  You should just always print
errors.


Everything else looks good and as far as I can tell Stephen's previous
feedback has been addressed.  So mostly just nits but the one bug is
that the checking for error interrupts is probably not working.

-Doug
