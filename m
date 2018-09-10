From: dkota@codeaurora.org
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Mon, 10 Sep 2018 19:54:27 +0530
Message-ID: <2c2260787f4c02702b02b8a85cd63187@codeaurora.org>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com>
 <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
 <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
 <c4982ce3fde57c86387cc906332f6d48@codeaurora.org>
 <20180910112633.GC5856@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910112633.GC5856@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2018-09-10 16:56, Mark Brown wrote:
> On Mon, Sep 10, 2018 at 09:27:09AM +0530, dkota@codeaurora.org wrote:
> 
>> > The thing is, we want it to be 100% reliable, not 99.9% reliable.  Is
>> > it somehow wrong to add the spinlock?  ...or are you noticing
>> > performance problems with the spinlock there?  It's just nice not to
>> > have to think about it.
> 
>> As I said, timeout will be handled after the calculated time as per 
>> data
>> size and speed. Enough time is given for interrupt, there is no chance 
>> of
>> interrupt occurrence during the handle_fifo_timeout(). So there is no 
>> need
>> of spinlock.
> 
> Assuming nothing goes wrong - the system isn't under unusually heavy
> load for example, there's some oversight in the code, there's no impact
> from power management causing things to run more slowly than you were
> expecting, someone uses the driver on a new bit of hardware where there
> are extra considerations or whatever else might go wrong.  Like Doug
> says unless we're in some performance critical situation where it's
> worth thinking *really* hard about how things really are actually safe
> even though they might not look it it's both easier and more
> maintainable to just write software that's obviously safe to 
> inspection.

Agree with this perspective. There wont be any performance impact with 
spinlock. I will include the spinlock in the code.
