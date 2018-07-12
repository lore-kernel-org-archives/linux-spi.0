From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI controller
Date: Thu, 12 Jul 2018 13:16:16 -0700
Message-ID: <CAD=FV=W0NUFw1u5Zb2dXrpBp75C2AFXzrVtCSF_fXFnRXbET_Q@mail.gmail.com>
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
>  create mode 100644 drivers/spi/spi-qcom-qspi.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 97e1fa9..bc71cd3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -571,6 +571,13 @@ config SPI_QCOM_GENI
>           This driver can also be built as a module.  If so, the module
>           will be called spi-geni-qcom.
>
> +config SPI_QCOM_QSPI
> +       tristate "QTI QPSPI controller"
> +       depends on ARCH_QCOM
> +       help
> +         QSPI(Quad SPI) driver for Qualcomm QSPI controller.
> +
>  config SPI_QUP
>         tristate "Qualcomm SPI controller with QUP interface"
>         depends on ARCH_QCOM || (ARM && COMPILE_TEST)

I tried to apply your patch and `patch` complained that it was
malformed.  In fact it is.  The numbers above say that there should be
13 lines in the section above but you only have 12.  Did you manually
munge the patch after generating it?  Please be more careful.


-Doug
