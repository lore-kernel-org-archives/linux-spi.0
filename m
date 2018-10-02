From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Tue, 2 Oct 2018 15:40:12 -0700
Message-ID: <CAD=FV=WiMbuVmimp9dQoW0MErm=Pw-w7N-mMTOStgtuLg7Vz8A@mail.gmail.com>
References: <20181002214709.162330-1-ryandcase@chromium.org> <20181002214709.162330-2-ryandcase@chromium.org>
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
In-Reply-To: <20181002214709.162330-2-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, Oct 2, 2018 at 2:48 PM Ryan Case <ryandcase@chromium.org> wrote:
> +#define RD_FIFO_STATUS 0x002c
> +#define FIFO_EMPTY     BIT(11)
> +#define WR_CNTS_MSK    0x7f0
> +#define WR_CNTS_SHFT   4
> +#define RDY_64BYTE     BIT(3)
> +#define RDY_32BYTE     BIT(2)
> +#define RDY_16BYTE     BIT(1)
> +#define FIFO_RDY       BIT(0)
> +
> +#define RD_FIFO_CFG            0x0028
> +#define CONTINUOUS_MODE                BIT(0)

You missed the above when re-sorting.  The section for 0x0028 should
be above the section for 0x002c.

IMO there's been enough spins of this patch and it's a pretty minor
change.  Mark: maybe you'd be OK with applying the current patch and
either fixing up the sort order as you apply or letting us know to
post a followup patch?  ...or if you'd like a v7 then please yell.


> +static int __maybe_unused qcom_qspi_suspend(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = spi_master_suspend(master);
> +       if (ret)
> +               return ret;
> +
> +       ret = pm_runtime_force_suspend(dev);
> +       if (ret)
> +               spi_master_resume(master);
> +
> +       return ret;
> +}
> +
> +static int __maybe_unused qcom_qspi_resume(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = spi_master_resume(master);
> +       if (ret)
> +               pm_runtime_force_suspend(dev);
> +
> +       return ret;
> +}

As per my new understanding (now that I've been educated by Rafael)
[1] possibly the error handling here could be revamped to handle the
case where suspend() may be called again after a failed resume().  I'd
rather not block this patch based on that discussion though, so this
feels like something to address by a follow-up patch.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


[1] https://lkml.kernel.org/r/CAJZ5v0hSohUZvJcVcQzy_DdSyPVppOABk0HELsa3dpvf12LMPQ@mail.gmail.com
