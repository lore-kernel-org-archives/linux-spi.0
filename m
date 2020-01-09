From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] spi: spi-qcom-qspi: Use device managed memory for clk_bulk_data
Date: Wed, 8 Jan 2020 21:57:48 -0800
Message-ID: <CAD=FV=XREb0zf=BxwKF7jGO7fwtwQaO+vR1giodsW+RkHZe_XQ__25907.7137381368$1578549780$gmane$org@mail.gmail.com>
References: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
To: Matthias Kaehlcke <mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200108133948.1.I35ceb4db3ad8cfab78f7cd51494aeff4891339f5@changeid>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Wed, Jan 8, 2020 at 1:40 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Currrently the memory for the clk_bulk_data of the QSPI controller
> is allocated with spi_alloc_master(). The bulk data pointer is passed
> to devm_clk_bulk_get() which saves it in clk_bulk_devres->clks. When
> the device is removed later devm_clk_bulk_release() is called and
> uses the bulk data referenced by the pointer to release the clocks.
> For this driver this results in accessing memory that has already
> been freed, since the memory allocated with spi_alloc_master() is
> released by spi_controller_release(), which is called before the
> managed resources are released.
>
> Use device managed memory for the clock bulk data to fix the issue
> described above.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/spi/spi-qcom-qspi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

It's a little ugly, but it seems somewhat same.  Basically we're
saying that the caller of devm_clk_bulk_get() is in charge of keeping
the list of clocks readable for the devm free function.  Maybe we
should also fix devm_clk_bulk_get() to always make a copy of the
clocks so we can relax this limitation (though that's a lot of extra
copying for the uncommon case), but even if we do change that your
change would still be OK.

...so from my point of view:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
