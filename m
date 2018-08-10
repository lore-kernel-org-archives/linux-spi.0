From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based QUP
Date: Fri, 10 Aug 2018 08:40:17 -0700
Message-ID: <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <152607782792.34267.8023817955251139395@swboyd.mtv.corp.google.com>
 <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org> <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk> <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk> <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org> <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810105205.GC20971@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Aug 10, 2018 at 3:52 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 09, 2018 at 11:03:55AM -0700, Doug Anderson wrote:
>> On Fri, Aug 3, 2018 at 5:18 AM,  <dkota@codeaurora.org> wrote:
>
>> > Also, spi core framework will set the transfer speed to controller max
>> > frequency
>> > if transfer frequency is greater than controller max frequency.
>> > Please mention if you have a other opinion.
>
>> 1. It sure seems like the clock framework could be enforcing the max
>> speed here.  SPI can just ask for the speed and the clock framework
>> will pick the highest speed it can if you ask for one too high.  Isn't
>> that the whole point of the "struct freq_tbl" in the clock driver?
>
> This is more about matching the data rate between the two drivers - the
> clock framework could (and possibly should) reasonably return an error
> here, we're trying to ensure that drivers and controllers work well
> together here.

The clock framework should be able to accomplish what you want.  If
you just request the rate it will do its best to make the rate
requested.  If we want to see what clock would be set before setting
it, we could use clk_round_rate().  Then we'd have to decide if the
clock framework is giving us something close enough.  ...but then what
is "close enough" in this case?  I haven't gone and dug, but I've
always seen people only specify a max rate for SPI.  ...so as long as
the clock framework gives us something <= the clock we requested then
we should be OK, right?  If / when this becomes a problem then we
should add a min/max to "struct spi_transfer", no?

Note that there are also clk_set_rate_range(), clk_set_min_rate(), and
clk_set_max_rate() though I'm told those might be a bit quirky.


>> 2. The device tree writer already provides a max clock speed for each
>> SPI slave in the device tree.  ...shouldn't the device tree writer
>> already be taking into account the max of the SPI port when setting
>> this value?
>
> Yes.  We're overriding this because drivers can set a speed from code
> (this is especially common when devices have variable maximum speeds for
> different operations).

OK, makes sense.  You can still cap the max per SPI-slave in the
device tree if you really have to though, right?

...but maybe we don't need to argue about this anyway since IMHO we
should just use the clk framework to figure out our maximum speed.


>> 3. If you really truly need code in the SPI driver then make sure you
>> include a compatible string for the SoC and have a table in the driver
>> that's found with of_device_get_match_data().  AKA:
>
>>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";
>
> A controller driver really shouldn't need to be open coding anything.

It wouldn't be open-coding, it would be a different way of specifying
things.  In my understanding it's always a judgement call about how
much to put in a table that's matched via an SoC-specific compatible
string and how much to describe the SoC-specific behavior device tree
properties.  On the spectrum I've found it's usually best to error on
the side of having a table matched via SoC-specific compatible
strings.

For an example commit of moving _away_ from describing SoC-specific
behavior and just matching on the compatible, see commit 0fbc47d9e426
("phy: rockchip-typec: deprecate some DT properties for various
register fields.") and the associated bindings commit 6912d4f40bc7
("dt-bindings: phy-rockchip-typec: deprecate some register
properties.").


-Doug
