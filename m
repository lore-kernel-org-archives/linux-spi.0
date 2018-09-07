From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Date: Fri, 7 Sep 2018 09:19:03 -0700
Message-ID: <CAD=FV=U8rzZcZUixo=zD1C9y0VBBfFfM6jAB9+9uerkfTMrRiQ@mail.gmail.com>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
 <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com> <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
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
To: Dilip Kota <dkota@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2493fc3fa3f6e5d2bcdde27cee1c33df@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

On Fri, Sep 7, 2018 at 3:00 AM,  <dkota@codeaurora.org> wrote:
>> In v2, I said:
>>
>>> I'm not sure where to comment about this, so adding it to the end:
>>>
>>> Between v1 and v2 you totally removed all the locking.  Presumably
>>> this is because you didn't want to hold the lock in
>>> handle_fifo_timeout() while waiting for the completion.  IMO taking
>>> the lock out was the wrong thing to do.  You should keep it, but just
>>> drop the lock before wait_for_completion_timeout() and add it back
>>> afterwards.  Specifically you _don't_ want the IRQ and timeout code
>>> stomping on each other.
>>
>>
>> ...but still no spinlock?
>
> I see there is no need of taking the spinlock as timeout will be handled
> after the calculated time as per data size and speed.
> There is 99.9% less chances of interrupt during the timeout handler.
>>
>>
>>
>> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201081

The thing is, we want it to be 100% reliable, not 99.9% reliable.  Is
it somehow wrong to add the spinlock?  ...or are you noticing
performance problems with the spinlock there?  It's just nice not to
have to think about it.

-Doug
