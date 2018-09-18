From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
Date: Tue, 18 Sep 2018 13:12:04 -0700
Message-ID: <CAD=FV=UJo0yL-MiQyJrS85p-RFs3TqWdagVpjCdtZfEkgYCYbg@mail.gmail.com>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org> <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, Sep 18, 2018 at 11:09 AM Dilip Kota <dkota@codeaurora.org> wrote:
>
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
> Addressing all the reviewer commets given in Patchset1.
> Summerizing the chages below:
>
>         Move prepare_transfer_hardware to probe
>         Fix the unbind failure
>         Add Spinlock
>         Use readl/writel() instead of _relaxed()
>         Remove __func__ in dev_err
>         Declare register variables as u32
>         Don't initialize variables and then overwrite them
>         Remove unused step
>         Remove IRQ entry in geni struct
>         Remove extra paranthesis
>         Reframe probe errors
>         Change the tx_fifo_width naming in handle_rx and handle_tx
>         Declare spi_geni_master as 'mas' in complete driver.
>         Correcting the punctuation in the comments.
>         Adding comments in the code while setting Tx WaterMark Register.
>         get_spi_clk_cfg() fixes
>         Rewrite the geni_spi_handle_tx() and geni_spi_handle_rx()
>
> Regarding the suspend/resume and loopback failures, i am working to update in next patch series
> drivers/spi/Kconfig               |  12 +
>  drivers/spi/Makefile              |   1 +
>  drivers/spi/spi-geni-qcom.c       | 653 ++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi-geni-qcom.h |  14 +
>  4 files changed, 680 insertions(+)

I've confirmed that all the feedback I'm aware of from previous
versions of this patch has now been addressed, except as noted above:

* suspend callback still looks a little wonky.
* loopback doesn't actually work

IMO it would be OK to land this patch and address the suspend callback
/ loopback issues in later patches, but obviously that's for Mark to
decide.

NOTE: for this patch to land it must be based on a tree that includes
the patch ("soc: qcom: geni: Make version macros simpler") [1] in
order to compile.  It would also be nice if it was also based upon the
patches ("soc: qcom: geni: Don't ignore clk_round_rate() errors in
geni_se_clk_tbl_get()") [2] and ("soc: qcom: geni:
geni_se_clk_freq_match() should always accept multiples") [3].  Those
aren't needed for things to compile but are technically needed for
correctness.  +Andy Gross has said he'll put that the above 3 patches
in his tree in a way that it would be easy to pull in

Mark: it would be super if you had a chance to take a look at this
patch now and see what you think.

[1] https://lkml.kernel.org/r/20180518224750.232742-1-swboyd@chromium.org
[2] https://lkml.kernel.org/r/20180906224906.93752-1-dianders@chromium.org
[3] https://lkml.kernel.org/r/20180906224906.93752-2-dianders@chromium.org

With all that said, I'm happy adding:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
