From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v1] spi: spi-qcom-qspi: Fix remaining driver nits
Date: Tue, 23 Oct 2018 12:53:50 -0700
Message-ID: <CAD=FV=XN5wa_7C8X3epEx=VpcEYSgTj7fxuvVsWDGkpaEkh-3w@mail.gmail.com>
References: <20181023010707.153647-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: ryandcase@chromium.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023010707.153647-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,
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

Reviewed-by: Douglas Anderson <dianders@chromium.org>
