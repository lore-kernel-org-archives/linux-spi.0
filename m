From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Mon, 16 Jul 2018 16:50:45 -0700
Message-ID: <CAD=FV=U-9Xs2pTezM1Ny_5uSGJ7MpSCWZmsSwsW2wq44dtH=Gw@mail.gmail.com>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org> <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        boris.brezillon@bootlin.com
To: Girish Mahadevan <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Thu, Jul 5, 2018 at 2:46 PM, Girish Mahadevan <girishm@codeaurora.org> wrote:
> New driver for Qualcomm QuadSPI(QSPI) controller that is used to
> communicate with slaves such flash memory devices. The QSPI controller
> can operate in 2 or 4 wire mode but only supports SPI Mode 0 and SPI
> Mode 3. The controller can also operate in Single or Dual data rate modes.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> ---
>  drivers/spi/Kconfig         |   7 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-qcom-qspi.c | 728 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 736 insertions(+)

I spent a few days poking at this driver and trying to see if I could
get it to do anything other than crash and corrupt memory.  I finally
was able to do so.  I've posted my diffs at:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/6670275e22b5901a1c4c11982cdafd10c2820771%5E%21/#F0

...if it's helpful I'm happy to post a full patch here too (just let
me know), but I'd just expect my patch to get squashed into the next
version and it can be reviewed then.

With my patch applied my testing on sdm845 on a device that can only
support dual SPI seems to work pretty well.  NOTE: as I reply to this,
I realized that I hadn't gone back and tried to address Mark and
Boris's comments.  Some of them are handled because I found the same
problem that they did, but before re-posting you should definitely
handle them.


-Doug
