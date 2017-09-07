From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum ADI controller documentation
Date: Thu, 7 Sep 2017 19:03:18 +0800
Message-ID: <CAMz4kuLGTCgppki=je9pE5SidRnYWJA-nJd1=RD7qdN1ZRww3Q@mail.gmail.com>
References: <ccbb0641fa123021249c7a51cbe2dcd975c41f39.1504677110.git.baolin.wang@spreadtrum.com>
 <20170906145900.yesyfyruv5wd3wxj@sirena.co.uk> <CAMz4ku+hKaemHQdVtNEbCf0J_9CjqKouSygAaQsqf+hBzGd-mg@mail.gmail.com>
 <20170907095435.5yhybxz6oootp37h@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Baolin Wang <baolin.wang@spreadtrum.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907095435.5yhybxz6oootp37h@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 7 September 2017 at 17:54, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 07, 2017 at 11:29:05AM +0800, Baolin Wang wrote:
>> On 6 September 2017 at 22:59, Mark Brown <broonie@kernel.org> wrote:
>> > On Wed, Sep 06, 2017 at 02:10:43PM +0800, Baolin Wang wrote:
>
>> >> +- hwlocks: Reference to a phandle of a hwlock provider node.
>> >> +- hwlock-names: Reference to hwlock name strings defined in the same order
>> >> +     as the hwlocks.
>
>> > What are these hwlocks protecting, and what names are expected?
>
>> I made one explanation in above sentence, I assume it is not clear.
>> Since we have multi-subsystems will use ADI to access analog chip,
>> when one system is reading/writing data by ADI, which should be under
>> one hardware spinlock protection to prevent other systems from
>> reading/writing data by ADI at the same time, or two parallel routine
>> of setting ADI registers will get incorrect results.
>
>> The hwspinlock name should be "adi", and I will make it clear in next version.
>
> So there's other drivers that might also be accessing this IP block?

Yes. Other drivers (like regulator, RTC or charger ... ) can access
analog chip (like PMIC) by ADI controller. But the hardware spinlock
is used to synchronize between the multiple subsystems, since we only
have one ADI controller.

>
>> >> +Optional properties:
>> >> +- sprd,hw-channels: Specify the hardware channel number and mapped address
>> >> +     for hardware channel accessing.
>
>> > What do these mean and how are the numbers and how will the binding be
>> > interpreted?
>
>> I also gave one explanation in above sentence, is it not clear? I try again.
>
> It says what they are, it doesn't say for example what a hardware
> channel is or how those numbers map onto the actual hardware.

OK. I will add more documentation to explain that.

>
>> ADI controller has 50 channels including 2 software read/write
>> channels and 48 hardware channels to access analog chip. For 2
>> software read/write channels, which means we should set ADI registers
>> to access analog chip. But For hardware channels, we can just mapped
>> one analog chip address to one hardware channel, then user can access
>> analog chip by hardware channel without setting ADI registers.
>
>> For this "sprd,hw-channels" property, the first value specifies the
>> channel id, and the second value specifies the address which is mapped
>> into analog chip space.
>
> So does this driver control all the channels or are there other drivers
> (or hardware components) that control some of the other channels?

The ADI driver only controls 2 software channels (read/write), and
other hardware channels can be controlled by hardware components if we
set the hardware config.

-- 
Baolin.wang
Best Regards
