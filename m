From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v1] spi: spi-qcom-qspi: Fix remaining driver nits
Date: Mon, 5 Nov 2018 10:29:43 -0800
Message-ID: <CAD=FV=XGwyUEN3U-SzFB_VOLJ3LMcMttugKz7skgvMaBjt3H_w@mail.gmail.com>
References: <20181023010707.153647-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: ryandcase@chromium.org, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023010707.153647-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Mark,

On Mon, Oct 22, 2018 at 6:07 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> Address remaining comments from original driver patch series
>
> * Move RD_FIFO_CFG to be ordered corretly
> * Expand spinlock comment
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
>  drivers/spi/spi-qcom-qspi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

No huge deal (obviously) but I noticed that you landed a batch of
similar patches last night but didn't land this one.  Did it fall off
your radar or is there some other reason not to land it?

Thanks!

-Doug
