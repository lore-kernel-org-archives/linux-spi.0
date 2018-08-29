From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Tue, 28 Aug 2018 19:25:35 -0500
Message-ID: <20180829002535.GA4224@bogus>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: swboyd@chromium.org, broonie@kernel.org, mka@chromium.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 24, 2018 at 04:12:15PM +0530, Dilip Kota wrote:
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
> Summerizing all the comments below:
> 
> 	MAKEFILE: Arrange SPI-GENI driver in alphabetical order
> 	Kconfig: Mark SPI_GENI driver dependent on QCOM_GENI_SE
> 	Enable SPI core auto runtime pm, and remove runtime pm calls.
> 	Remove spi_geni_unprepare_message(), spi_geni_unprepare_transfer_hardware()
> 	Remove likely/unlikely keywords.
> 	Remove get_spi_master() and use dev_get_drvdata()
> 	Move request_irq to probe()
> 	Mark bus number assignment to -1 as SPI core framework will assign dynamically
> 	Use devm_spi_register_master()
> 	Include platform_device.h instead of of_platform.h
> 	Removing macros which are used only once:
> 	        #define SPI_NUM_CHIPSELECT     4
> 	        #define SPI_XFER_TIMEOUT_MS    250
> 	Place Register field definitions next to respective Register definitions.
> 	Replace int and u32 declerations to unsigned int.
> 	Remove Hex numbers in debug prints.
> 	Declare mode as u16 in spi_setup_word_len()
> 	Remove the labels: setup_fifo_params_exit: exit_prepare_transfer_hardware:
> 	Declaring struct spi_master as spi everywhere in the file.
> 	Calling spi_finalize_current_transfer() for end of transfer.
> 	Hard code the SPI controller max frequency instead of reading from DTSI node.
> 	Spinlock not required, removed it.
> 	Removed unrequired error prints.
> 	Fix KASAN error in geni_spi_isr().
> 	Remove spi-geni-qcom.h
> 	Remove inter words delay and CS to Clock toggle delay logic in the driver, as of now no clients are using it.
> 	Will submit this logic in the next patchset.	
> 	Use major, minor and step macros to read from hardware version register.
> 
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   2 -

Please split to a separate patch and explain why you are removing 
spi-max-frequency?

>  drivers/spi/Kconfig                                |  12 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-geni-qcom.c                        | 678 +++++++++++++++++++++
>  4 files changed, 691 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/spi/spi-geni-qcom.c
