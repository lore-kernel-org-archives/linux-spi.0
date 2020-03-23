From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
Date: Mon, 23 Mar 2020 09:32:39 -0700
Message-ID: <CAD=FV=WcnAtA2WRoC-+R2yKC1OCsDOEDMXu5jKveOARhw4gmOg@mail.gmail.com>
References: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
 <20200323110756.GD26299@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: kbuild@lists.01.org, kbuild-all@lists.01.org,
        Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200323110756.GD26299@kadam>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Mon, Mar 23, 2020 at 4:08 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> 561de45f72bd5f Girish Mahadevan 2018-10-03  327                 ret = get_spi_clk_cfg(xfer->speed_hz, mas, &idx, &div);
> 561de45f72bd5f Girish Mahadevan 2018-10-03  328                 if (ret) {
> 561de45f72bd5f Girish Mahadevan 2018-10-03  329                         dev_err(mas->dev, "Err setting clks:%d\n", ret);
> 561de45f72bd5f Girish Mahadevan 2018-10-03  330                         return;
>
> Needs to drop the lock before returning.

Oops, thanks for catching.  I will wait before spinning a v3 until
there is some clarity about whether folks want to do something more
like Stephen suggested or whether I should continue with my strategy.
At the moment I'm still in favor of keeping w/ my strategy and seeing
if I can reduce the amount of time with interrupts disabled in
setup_fifo_xfer(), maybe just grabbing the lock around the start of
the transfer to keep the state machine in sync with the kickoff...

-Doug
