From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Thu, 9 Aug 2018 11:03:55 -0700
Message-ID: <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org> <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Aug 3, 2018 at 5:18 AM,  <dkota@codeaurora.org> wrote:
>>> +       if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
>>> +                               &spi->max_speed_hz)) {
>
>
>> Why does this need to come from DT?
>
>
> This is required to set the SPI controller max frequency.
> As it is specific to the controller, so looks meaningful to specify it in
> dtsi.
> Also, spi core framework will set the transfer speed to controller max
> frequency
> if transfer frequency is greater than controller max frequency.
> Please mention if you have a other opinion.

Here are my thoughts:

1. It sure seems like the clock framework could be enforcing the max
speed here.  SPI can just ask for the speed and the clock framework
will pick the highest speed it can if you ask for one too high.  Isn't
that the whole point of the "struct freq_tbl" in the clock driver?


2. The device tree writer already provides a max clock speed for each
SPI slave in the device tree.  ...shouldn't the device tree writer
already be taking into account the max of the SPI port when setting
this value?


3. If you really truly need code in the SPI driver then make sure you
include a compatible string for the SoC and have a table in the driver
that's found with of_device_get_match_data().  AKA:

  compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";

...as per #1 and #2 I don't think this is useful


-Doug
