From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
Date: Tue, 25 Sep 2018 12:54:35 -0700
Message-ID: <CAD=FV=VJA_qUDp3mxej4gANpzY6TFy7bpK_VzFy=W1X31vmifQ@mail.gmail.com>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-4-git-send-email-dkota@codeaurora.org> <153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com>
 <8866de0e7a687cea1d800d6b3dcfb60b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8866de0e7a687cea1d800d6b3dcfb60b@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, Sep 25, 2018 at 12:36 PM <dkota@codeaurora.org> wrote:
> >> +       unsigned int cur_speed_hz;
> >
> > unsigned long for Hz? The clk framework uses that type.
>
> cur_speed_hz stores the speed value requested as part of transfer (not
> the resultant or rounded off frequency got from clk framework. It is u32
> type, i will change cur_speed_hz to u32 type instead of unsigned long.
> Code snippet:
>          mas->cur_speed_hz = xfer->speed_hz;

Change it to "unsigned long" anyway to match the clock framework.  In
theory maybe the "xfer" structure will be updated eventually.


-Doug
