From: dkota@codeaurora.org
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Mon, 10 Sep 2018 09:27:09 +0530
Message-ID: <c4982ce3fde57c86387cc906332f6d48@codeaurora.org>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com>
 <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
 <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
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
To: Doug Anderson <dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=VzYYyive--RzN=_OCQnFT-wgHwbUy1Vao2-8GADxHDLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


>> I see there is no need of taking the spinlock as timeout will be 
>> handled
>> after the calculated time as per data size and speed.
>> There is 99.9% less chances of interrupt during the timeout handler.
>>> 
>>> 
>>> 
>>> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201081
> 
> The thing is, we want it to be 100% reliable, not 99.9% reliable.  Is
> it somehow wrong to add the spinlock?  ...or are you noticing
> performance problems with the spinlock there?  It's just nice not to
> have to think about it.

As I said, timeout will be handled after the calculated time as per data 
size and speed. Enough time is given for interrupt, there is no chance 
of interrupt occurrence during the handle_fifo_timeout(). So there is no 
need of spinlock.
