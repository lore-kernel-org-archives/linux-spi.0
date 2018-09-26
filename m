From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Wed, 26 Sep 2018 15:26:59 -0700
Message-ID: <CAD=FV=XUiL__kts+QH3AZpA61p_adc7j3Ai1_H5VcMjV_MLOgQ@mail.gmail.com>
References: <20180926205204.184898-1-ryandcase@chromium.org> <20180926205204.184898-2-ryandcase@chromium.org>
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
In-Reply-To: <20180926205204.184898-2-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Ryan,

On Wed, Sep 26, 2018 at 1:54 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such flash memory devices. The QSPI controller
> can operate in 2 or 4 wire mode but only supports SPI Mode 0. The
> controller can also operate in Single or Dual data rate modes.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v3:
> - Corrected QPSPI typo
> - Removed setup function and moved configurations to prepare_message
> - Added __maybe_unused to suspend and resume functions
>
> Changes in v2:
> - Addressed formatting feedback
> - Squashed bug fixes and features from Doug
> - Now uses transfer_one_message instead of mem_ops
> - Fixed suspend/resume
> - Added spinlocks
>
>  drivers/spi/Kconfig         |   6 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-qcom-qspi.c | 598 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 605 insertions(+)
>  create mode 100644 drivers/spi/spi-qcom-qspi.c

This looks good to me and addresses all outstanding feedback I'm aware
of from v2.  I've also tested this patch and it's working fine.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

NOTE to Mark: please be aware that there are currently _two_ SPI
drivers in flight for sdm845 since there are two totally different SPI
IP blocks in SDM845.  We need both this driver (the Quad SPI one) and
also the other driver (the GENI SPI one).  As I understand it Dilip
plans to send the next spin of the GENI SPI driver some time in the
next day or two.

-Doug
