From: dkota@codeaurora.org
Subject: Re: [PATCH V4 3/4] spi: spi-geni-qcom: Add SPI driver support for
 GENI based QUP
Date: Thu, 27 Sep 2018 00:06:50 +0530
Message-ID: <12ec7543043b89eeb848a2cc87db5c47@codeaurora.org>
References: <1537294047-12093-1-git-send-email-dkota@codeaurora.org>
 <1537294047-12093-4-git-send-email-dkota@codeaurora.org>
 <153780767551.119890.9339380838620508307@swboyd.mtv.corp.google.com>
 <8866de0e7a687cea1d800d6b3dcfb60b@codeaurora.org>
 <CAD=FV=VJA_qUDp3mxej4gANpzY6TFy7bpK_VzFy=W1X31vmifQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>, dkota@codeaurora.org
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VJA_qUDp3mxej4gANpzY6TFy7bpK_VzFy=W1X31vmifQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2018-09-26 01:24, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 25, 2018 at 12:36 PM <dkota@codeaurora.org> wrote:
>> >> +       unsigned int cur_speed_hz;
>> >
>> > unsigned long for Hz? The clk framework uses that type.
>> 
>> cur_speed_hz stores the speed value requested as part of transfer (not
>> the resultant or rounded off frequency got from clk framework. It is 
>> u32
>> type, i will change cur_speed_hz to u32 type instead of unsigned long.
>> Code snippet:
>>          mas->cur_speed_hz = xfer->speed_hz;
> 
> Change it to "unsigned long" anyway to match the clock framework.  In
> theory maybe the "xfer" structure will be updated eventually.
Ok. WIll update it
> 


>> Is it possible for all three conditions above to happen in one
>> interrupt? I ask because 'ret' is overwritten and so what may have 
>> been
>> IRQ_HANDLED may become IRQ_NONE which will lead to confusion in the 
>> irq
>> layer. Maybe the handle tx/rx functions can return a bool, that gets
>> orred together each time so that we know if something handled an
>> interrupt?
>> 
> Will check it again by running fullduplex transfer and update.
Added the changes in V5 to ensure return value doesn't get overwritten.

--Dilip
