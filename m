From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V4 4/4] spi: spi-geni-qcom: Plugin API to assert and
 de-assert Chipselect
Date: Tue, 18 Sep 2018 13:12:17 -0700
Message-ID: <CAD=FV=VP5xKY8GSwcsb3WBinb+wn75AL8Z2Z=fWau_KAx7iztQ@mail.gmail.com>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org> <1537294047-12093-5-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537294047-12093-5-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Tue, Sep 18, 2018 at 11:09 AM Dilip Kota <dkota@codeaurora.org> wrote:
>
> Plugin set cs API to the SPI framework so that
> framework can do chipselect assert de-assert
> during  SPI transfers.
>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 65 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 46 insertions(+), 19 deletions(-)

As I mentioned in out-of-band I don't see a huge reason why this can't
be squashed into patch #3.  Logically patch #3 has a bug where it
can't handle setting the chip select without a non-zero transfer and
that bug isn't fixed until patch #4.  ...but if folks really feel like
it should be a separate patch then I won't object too loudly since the
end result is the same.

...so feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>


-Doug
