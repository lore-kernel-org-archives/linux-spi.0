From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Thu, 9 Aug 2018 12:37:52 -0700
Message-ID: <CAD=FV=V4miw3i+8EPZPpgWGaVJhHbb2OBVTz6_iP-pMVhZoBOQ@mail.gmail.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org> <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <1533839042.2283.305.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: "dkota@codeaurora.org" <dkota@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "kramasub@codeaurora.org" <kramasub@codeaurora.org>,
        "girishm@codeaurora.org" <girishm@codeaurora.org>
To: Trent Piepho <tpiepho@impinj.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533839042.2283.305.camel@impinj.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Thu, Aug 9, 2018 at 11:24 AM, Trent Piepho <tpiepho@impinj.com> wrote:
> On Thu, 2018-08-09 at 11:03 -0700, Doug Anderson wrote:
>> On Fri, Aug 3, 2018 at 5:18 AM,  <dkota@codeaurora.org> wrote:
>> > > > +       if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
>> > > > +                               &spi->max_speed_hz)) {
>> >
>> >
>> > > Why does this need to come from DT?
>> >
>> >
>> > This is required to set the SPI controller max frequency.
>> > As it is specific to the controller, so looks meaningful to specify it in
>> > dtsi.
>> > Also, spi core framework will set the transfer speed to controller max
>> > frequency
>> > if transfer frequency is greater than controller max frequency.
>> > Please mention if you have a other opinion.
>>
>> Here are my thoughts:
>>
>> 1. It sure seems like the clock framework could be enforcing the max
>> speed here.  SPI can just ask for the speed and the clock framework
>> will pick the highest speed it can if you ask for one too high.  Isn't
>> that the whole point of the "struct freq_tbl" in the clock driver?
>>
>>
>> 2. The device tree writer already provides a max clock speed for each
>> SPI slave in the device tree.  ...shouldn't the device tree writer
>> already be taking into account the max of the SPI port when setting
>> this value?
>
> No, the way it works is the actual speed is the lesser of the master's
> max and the slave device's max.
>
> But usually the master's max is determined by:
>
> 1. The input clock the SPI master device, as provided by the clock
> framework.  Usually the max SPI clock will be this clock /2 or
> something like that.
>
> 2. The master has some maximum clock as part of its specifications, in
> which case the driver basically hard codes it.  Maybe it is different
> based on model and the driver has a table.
>
> The device tree isn't really meant to be a way to remove all data from
> the device driver just because it can be, or shift work from the driver
> author to the device tree author.
>
> So, one shouldn't specify the master max in the DT if the driver could
> figure it out.
>
> Sometimes you see a field in the DT and I think the thought process
> that put it there was, "I don't understand how to set this register,
> I'll just stick in the device tree and then it's Someone Else's Problem
> to find the correct value."
>
> The max speed that some board can talk to a SPI slave might be from the
> specs of the slave device or maybe it's due to the traces on the board
> itself that is the limiting factor.  In the latter case the convention
> is to consider this part of the slave's max speed and put into the DT
> in the slave's DT node max speed property.
>
> So the same spi eeprom chip might have have a max in the DT of 20 MHz
> on one board, copied out of the eeprom's datasheet.  But on another
> board it has a max of 10 MHz because on that board's layout it only
> works up to 10.

I think we're in agreement but perhaps there's a miscommunication here?

I'm saying that we _shouldn't_ put the max-speed of the master in the
device tree.  The max speed for the IP block ought to be in code
either in the clock driver or in the SPI driver based on the
compatible string.

...as one argument _against_ putting a max-speed for the master in the
device tree I'm saying that we can already specify a max-speed of each
slave in the device tree.  The max speed of the slave should take into
account whatever factors are specific to this board including trace
lengths, noise, etc.  If we somehow did need to get a max speed in the
device tree it seems like we could just adjust the max speed for the
slave to be something lower.  In other words if you know a board has
an sdm845 on it and you know that the SPI clock on sdm845 can't go
over 50 MHz then it would make no sense to suggest that we should run
the SPI clock for a device at 100 MHz.


-Doug
