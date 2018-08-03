From: dkota@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Fri, 03 Aug 2018 17:48:35 +0530
Message-ID: <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        "Mahadevan, Girish" <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Stephen and Mark,

>>> Do you mean spi-rx-delay-us and spi-tx-delay-us properties? Those are
>>> documented but don't seem to be used. There's also the delay_usecs 
>>> part
>>> of the spi_transfer structure, which may be what you're talking 
>>> about.
>> 
>> delay_usecs is for inter-transfer delays within a message rather than
>> after the initial chip select assert (it can be used to keep chip 
>> select
>> asserted for longer after the final transfer too).  Obviously this is
>> also something that shouldn't be configured in a driver specific
>> fashion.
>> 
> 
> Hmmm ok, so you mean don't send these as controller_data, rather add 
> new
> members to the spi_device struct ?

spi_cs_clk_delay -> Adds Delay from CS line toggle to Clock line toggle
spi_inter_words_delay -> Adds inter-word delay for each transfer.

Could you please provide more information on accommodating these 
parameters in
SPI core structures like spi_device or spi_transfer? Why because these 
are very
specific to SPI GENI controller.


>> +       if (of_property_read_u32(pdev->dev.of_node, 
>> "spi-max-frequency",
>> +                               &spi->max_speed_hz)) {

> Why does this need to come from DT?

This is required to set the SPI controller max frequency.
As it is specific to the controller, so looks meaningful to specify it 
in dtsi.
Also, spi core framework will set the transfer speed to controller max 
frequency
if transfer frequency is greater than controller max frequency.
Please mention if you have a other opinion.

Code snippet from spi.c
====
2826		if (ctlr->max_speed_hz && xfer->speed_hz > ctlr->max_speed_hz)
2827			xfer->speed_hz = ctlr->max_speed_hz;
====

>> +       mas->cur_speed_hz = spi_slv->max_speed_hz;
> 
> Why can't you use clk_get_rate() instead? Or call clk_set_rate() with
> the rate you want the master clk to run at and then divide that down
> from there?
> 
> 
>> > Not sure I follow, the intention is to run the controller clock based on
>> > the slave's max frequency.
> 
>> That's good. The problem I see is that we have to specify the max
>> frequency in the controller/bus node, and also in the child/slave 
>> node.
>> It should only need to be specified in the slave node, so making the
>> cur_speed_hz equal the max_speed_hz is problematic. The current speed 
>> of
>> the master should be determined by calling clk_get_rate().
> 
> We don't require that the slaves all individually set a speed since it
> gets a bit redundant, it should be enough to just use the default the
> controller provides.  A bigger problem with this is that the driver 
> will
> never see a transfer which doesn't explicitly have a speed set as the
> core will ensure something is set, open coding this logic in every
> driver would obviously be tiresome.

clock_get_rate() will returns the rate which got set as per the
clock plan(which was the rounded up frequency). For that reason
using the cur_speed_hz.
