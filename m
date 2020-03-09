From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/6] Add interconnect support to UART, I2C, SPI and QSPI
Date: Mon, 9 Mar 2020 10:59:54 -0700
Message-ID: <20200309175954.GX24720@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1581946205-27189-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Akash,

do you plan to re-spin this series in the near future?

Thanks

Matthias

On Mon, Feb 17, 2020 at 06:59:59PM +0530, Akash Asthana wrote:
> dt-binding patch for UART, I2C and SPI.
>  - https://patchwork.kernel.org/patch/11385965/ [Convert QUP bindings
> 	to YAML and add ICC, pin swap doc]
> 
> dt-binding patch for QSPI.
>  - https://patchwork.kernel.org/cover/11386003/ [Convert QSPI binding
> 	to YAML and add interconnect doc]
> 
> Akash Asthana (6):
>   soc: qcom: geni: Support for ICC voting
>   tty: serial: qcom_geni_serial: Add interconnect support
>   i2c: i2c-qcom-geni: Add interconnect support
>   spi: spi-geni-qcom: Add interconnect support
>   spi: spi-qcom-qspi: Add interconnect support
>   arm64: dts: sc7180: Add interconnect for QUP and QSPI
> 
>  arch/arm64/boot/dts/qcom/sc7180.dtsi  | 199 ++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-qcom-geni.c    |  84 +++++++++++++-
>  drivers/spi/spi-geni-qcom.c           |  65 ++++++++++-
>  drivers/spi/spi-qcom-qspi.c           |  38 ++++++-
>  drivers/tty/serial/qcom_geni_serial.c |  84 ++++++++++++--
>  include/linux/qcom-geni-se.h          |  31 ++++++
>  6 files changed, 481 insertions(+), 20 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
