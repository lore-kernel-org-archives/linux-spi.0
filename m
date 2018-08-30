From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Wed, 29 Aug 2018 19:30:59 -0500
Message-ID: <CAL_JsqL+prmJDKfXGdcB6mQBzA93PjfTqnpk3_07fmOt4=fx7w@mail.gmail.com>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <20180829002535.GA4224@bogus> <d751bc90ab1cfce84d6f419400790566@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d751bc90ab1cfce84d6f419400790566@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 29, 2018 at 6:19 AM <dkota@codeaurora.org> wrote:
>
> On 2018-08-29 05:55, Rob Herring wrote:
> > On Fri, Aug 24, 2018 at 04:12:15PM +0530, Dilip Kota wrote:
> >> From: Girish Mahadevan <girishm@codeaurora.org>
> >>
> >> This driver supports GENI based SPI Controller in the Qualcomm SOCs.
> >> The
> >> Qualcomm Generic Interface (GENI) is a programmable module supporting
> >> a
> >> wide range of serial interfaces including SPI. This driver supports
> >> SPI
> >> operations using FIFO mode of transfer.
> >>
> >> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> >> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> >> ---
> >> Addressing all the reviewer commets given in Patchset1.
> >> Summerizing all the comments below:
> >>
> >>      MAKEFILE: Arrange SPI-GENI driver in alphabetical order
> >>      Kconfig: Mark SPI_GENI driver dependent on QCOM_GENI_SE
> >>      Enable SPI core auto runtime pm, and remove runtime pm calls.
> >>      Remove spi_geni_unprepare_message(),
> >> spi_geni_unprepare_transfer_hardware()
> >>      Remove likely/unlikely keywords.
> >>      Remove get_spi_master() and use dev_get_drvdata()
> >>      Move request_irq to probe()
> >>      Mark bus number assignment to -1 as SPI core framework will assign
> >> dynamically
> >>      Use devm_spi_register_master()
> >>      Include platform_device.h instead of of_platform.h
> >>      Removing macros which are used only once:
> >>              #define SPI_NUM_CHIPSELECT     4
> >>              #define SPI_XFER_TIMEOUT_MS    250
> >>      Place Register field definitions next to respective Register
> >> definitions.
> >>      Replace int and u32 declerations to unsigned int.
> >>      Remove Hex numbers in debug prints.
> >>      Declare mode as u16 in spi_setup_word_len()
> >>      Remove the labels: setup_fifo_params_exit:
> >> exit_prepare_transfer_hardware:
> >>      Declaring struct spi_master as spi everywhere in the file.
> >>      Calling spi_finalize_current_transfer() for end of transfer.
> >>      Hard code the SPI controller max frequency instead of reading from
> >> DTSI node.
> >>      Spinlock not required, removed it.
> >>      Removed unrequired error prints.
> >>      Fix KASAN error in geni_spi_isr().
> >>      Remove spi-geni-qcom.h
> >>      Remove inter words delay and CS to Clock toggle delay logic in the
> >> driver, as of now no clients are using it.
> >>      Will submit this logic in the next patchset.
> >>      Use major, minor and step macros to read from hardware version
> >> register.
> >>
> >>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   2 -
> >
> > Please split to a separate patch and explain why you are removing
> > spi-max-frequency?
>
> Hi Rob Herring,
>
> In this patch, added changes for Driver not to read the SPI controller
> Maximum frequency from the device tree. Accordingly I removed it in the
> device tree documentation file. As both the files need to updated so did
> in the same patch.

Just because the Linux driver doesn't use it isn't a reason. What if
there is another OS driver for it? The binding is the h/w description,
not what the driver uses currently.

> Could you please let me know the reason for making a separate patch.

- Step 1 of Documentation/devicetree/bindings/submitting-patches.txt says so
- I only review the binding generally, so my ack or reviewed by only
applies to it.
- It makes the commit history of the DT only tree[1] more logical.

 Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
