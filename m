From: dkota@codeaurora.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Tue, 14 Aug 2018 14:30:02 +0530
Message-ID: <b32c205955e0f42182b16e90f539a919@codeaurora.org>
References: <20180522173000.GG24776@sirena.org.uk>
 <8968e04c-a200-ef06-5c33-94e399f7b9fe@codeaurora.org>
 <20180524162940.GA4828@sirena.org.uk>
 <28d8ab5fdeb34e52eba7ca771a17bc06@codeaurora.org>
 <61f2e1fb394bfe47ace42352f2e1b3a6@codeaurora.org>
 <CAD=FV=X-fGukBpSOYCO=rv94_3gorL=9qmttsvZk21=m6mwUgA@mail.gmail.com>
 <20180810105205.GC20971@sirena.org.uk>
 <CAD=FV=XXyL5q1quxUtBohn2GrcadbY9hr6sdw+4qShQnYTgVwA@mail.gmail.com>
 <20180810161329.GF20971@sirena.org.uk>
 <c1bc416ba407b5a3cc098e78a529752e@codeaurora.org>
 <20180810164636.GI20971@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Mahadevan, Girish" <girishm@codeaurora.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810164636.GI20971@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2018-08-10 22:16, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 09:59:46PM +0530, dkota@codeaurora.org wrote:
> 
>> Now the need is, how to communicate the SPI controller maximum 
>> frequency to
>> SPI core framework?
>> Is it by DTSI entry or hardcoding in the SPI controller driver?
> 
> If you've got a limit that exists in the IP the hard code it in the
> driver.
> 
>> My stand is for providing the DTSI entry.
>> Why because, this keeps SPI controller driver generic across the 
>> boards and
>> portable.
>> Also it is not against to Device tree usage because maximum frequency
>> is describing the property of the hardware.
> 
> If the limit the controller has is not coming from the clock tree then
> presumably it's a physical limitation of the silicon and isn't going to
> vary per board.  If the limit is coming from the board then it should 
> be
> specified per slave since different slaves may have different
> requirements on different boards.

Agree with you guys, will hard code the controller maximum frequency in 
the driver.
I will address this change in the next patchset.


Could you all please comment on the other points too:

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
parameters in SPI core structures like spi_device or spi_transfer? Why 
because these are very
specific to Qualcomm SPI GENI controller.

If we define them in spi core framework structures, SPI Slave driver 
will program and expect it in the SPI transfers.

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

clock_get_rate() will returns the rate which got set as per the clock 
plan(which was the rounded up frequency) which can be less than or equal 
to the requested frequency. For that reason using the cur_speed_hz to 
store the requested frequency and skip clock configuration for the 
consecutive transfers with same frequency.


--Dilip
