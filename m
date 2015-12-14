From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: GPIO: Add generic serializer binding
Date: Mon, 14 Dec 2015 16:36:41 -0600
Message-ID: <CAL_Jsq+kYSJQd003RhYTeVFv6xLaSCxzZK7wnF2LVs502sWu4g@mail.gmail.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com> <1449863184-29668-2-git-send-email-afd@ti.com>
 <CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com> <566EF12C.4060509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Andrew F. Davis" <afd@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <566EF12C.4060509@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 14, 2015 at 10:41 AM, Andrew F. Davis <afd@ti.com> wrote:
> On 12/11/2015 03:48 PM, Linus Walleij wrote:
>>
>> On Fri, Dec 11, 2015 at 8:46 PM, Andrew F. Davis <afd@ti.com> wrote:
>>
>>> Add binding for generic parallel-in/serial-out shift register devices
>>> used as GPIO.
>>>
>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>>
>>
>>> +Generic Parallel-in/Serial-out Shift Register GPIO Driver
>>> +
>>> +This binding describes generic parallel-in/serial-out shift register
>>> +devices that can be used for GPI (General Purpose Input). This includes
>>> +SN74165 serial-out shift registers and the SN65HVS88x series of
>>> +industrial serializers.
>>> +
>>> +Required properties:
>>> + - compatible          : Should be "pisosr-gpio".
>>
>>
>> I think it should also define compatible strings on the "vendor,device"
>> format apart from the generic compatible. Sooner or later we may need
>> to differentiate them and then that comes in handy.
>>
>
> Would it be better to wait until/if this issue arises? This driver
> targets the generic features, as these parts are very generic and
> have been produced by many companies since the 70s I'm not sure
> if privileging any of them makes much sense.
>
> What I'm worried about looks to have happened with the gpio-74x164
> driver, this is kind of the companion device to mine (74164 / 74165)
> and should work with any 74164 compatible shift register (possibly 100s
> of versions of them), but the compatible string that was added is
> "fairchild,74hc595", a relatively new device by a single manufacturer.
> The problem this has is then that boards will use this compatible string
> even if the parts are not actually the Fairchild version, just to get
> the match, when they should be using a generic string.

I agree the generic version is fine (or find who made the first part
;)). What "pisosr" is is not very obvious though. Having 74165 in the
compatible would make it somewhat more obvious it is a standard logic
part.

>>> +Optional properties:
>>> + - ngpios              : Number of GPIO lines, default is 8.
>>
>>
>> If you didn't do "pisosr-gpio" but instead "foo,sn74165", maybe you
>> don't need to have this in the device tree but instead it can be
>> determined from the compatible string?
>>
>> In that case do that.
>>
>
> These devices can be daisy-chained together, so three 8bit registers
> look exactly like one 24bit register. The only way to know this is
> from the physical wiring of the board, not from the part number.

Then you should say it must be multiple of 8 (or are there other lengths?).

Rob
