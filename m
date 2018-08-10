From: dkota@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Fri, 10 Aug 2018 21:59:46 +0530
Message-ID: <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
References: <24b3ef71-18c1-1704-e324-5581fd18a998@codeaurora.org>
 <152700759909.210890.13296077062705155869@swboyd.mtv.corp.google.com>
 <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: Mark Brown <broonie@kernel.org>,
        Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810161329.GF20971@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2018-08-10 21:43, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 08:40:17AM -0700, Doug Anderson wrote:
>> On Fri, Aug 10, 2018 at 3:52 AM, Mark Brown <broonie@kernel.org> 
>> wrote:
> 
>> > This is more about matching the data rate between the two drivers - the
>> > clock framework could (and possibly should) reasonably return an error
>> > here, we're trying to ensure that drivers and controllers work well
>> > together here.
> 
>> The clock framework should be able to accomplish what you want.  If
>> you just request the rate it will do its best to make the rate
>> requested.  If we want to see what clock would be set before setting
> 
> The request could be massively off the deliverable rate - 50% or more.
> 
>> is "close enough" in this case?  I haven't gone and dug, but I've
>> always seen people only specify a max rate for SPI.  ...so as long as
>> the clock framework gives us something <= the clock we requested then
>> we should be OK, right?  If / when this becomes a problem then we
>> should add a min/max to "struct spi_transfer", no?
> 
> On the other hand if I ask for my audio to be played at 44.1kHz and the
> clock framework says "yes, sure" and gives me 8kHz then the user
> experience will be poor.
> 
>> Note that there are also clk_set_rate_range(), clk_set_min_rate(), and
>> clk_set_max_rate() though I'm told those might be a bit quirky.
> 
> They're certainly not widely used at any rate.
> 
>> ...but maybe we don't need to argue about this anyway since IMHO we
>> should just use the clk framework to figure out our maximum speed.
> 
> It looks like that's true in this case.
> 
>> >> 3. If you really truly need code in the SPI driver then make sure you
>> >> include a compatible string for the SoC and have a table in the driver
>> >> that's found with of_device_get_match_data().  AKA:
> 
>> >>   compatible = "qcom,geni-spi-sdm845", "qcom,geni-spi";
> 
>> > A controller driver really shouldn't need to be open coding anything.
> 
>> It wouldn't be open-coding, it would be a different way of specifying
>> things.  In my understanding it's always a judgement call about how
> 
> If you're saying we need clock rate selection logic (which is what it
> sounds like) rather than data then that seems like a problem.

Here are my couple of cents:
SPI controller maximum frequency can be lesser than or equal to Clock 
framework's maximum
frequency, so should not rely on the Clock framework.

SPI controller maximum frequency should not be derived from the SPI 
slave maximum frequency.
Consider the case where N number of slaves connected to SPI controller 
then there will
be N number of slave maximum frequency.
Also it does not look meaningful in communicating the SPI slave maximum 
frequency
as SPI controller maximum frequency to the SPI core framework.

Hence relying on SPI slave maximum frequency for SPI controller maximum 
frequency can be eliminated.

Now the need is, how to communicate the SPI controller maximum frequency 
to SPI core framework?
Is it by DTSI entry or hardcoding in the SPI controller driver?

My stand is for providing the DTSI entry.
Why because, this keeps SPI controller driver generic across the boards 
and portable.
Also it is not against to Device tree usage because maximum frequency
is describing the property of the hardware.

Please add your points.

--Dilip
