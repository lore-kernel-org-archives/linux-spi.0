From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V5 3/3] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
Date: Mon, 8 Oct 2018 16:52:36 -0700
Message-ID: <CAD=FV=XnYucy4JmgATrB89RYHTbzRC_GaouaRjHAocD4-H0ncg@mail.gmail.com>
References: <1538574265-30235-1-git-send-email-alokc@codeaurora.org>
 <1538574265-30235-4-git-send-email-alokc@codeaurora.org> <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: alokc@codeaurora.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153904219713.119890.7463642233895152532@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Mon, Oct 8, 2018 at 4:43 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > +       mas->irq = platform_get_irq(pdev, 0);
> > +       if (mas->irq < 0) {
> > +               ret = mas->irq;
> > +               dev_err(&pdev->dev, "Err getting IRQ %d\n", ret);
> > +               goto spi_geni_probe_runtime_disable;
> > +       }
>
> Nitpick: If you got the irq earlier before allocating anything then nothing has
> to be put on failure path.

I think this might have been in response to previous feedback from you
suggesting that we should get the irq as late as possible.  Ah, here
ya go:

https://lkml.kernel.org/r/153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com

> Can you request this irq as late as possible in the probe function? I
> worry there may be some pending irq line set and then this will cause an
> interrupt storm with IRQ_NONE returned because the device is runtime
> suspended.

I'd rather handle the failure path then get the IRQ too early.

-Doug
