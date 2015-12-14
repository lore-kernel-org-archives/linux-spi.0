From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: GPIO: Add generic serializer binding
Date: Mon, 14 Dec 2015 10:41:16 -0600
Message-ID: <566EF12C.4060509@ti.com>
References: <1449863184-29668-1-git-send-email-afd@ti.com>
 <1449863184-29668-2-git-send-email-afd@ti.com>
 <CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexandre Courbot <gnurou@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaV_dxzWUQcJ8pwPUDQNJ8qLhCvLvE9tBYFcTTGMoumWQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/11/2015 03:48 PM, Linus Walleij wrote:
> On Fri, Dec 11, 2015 at 8:46 PM, Andrew F. Davis <afd@ti.com> wrote:
>
>> Add binding for generic parallel-in/serial-out shift register devices
>> used as GPIO.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>
>> +Generic Parallel-in/Serial-out Shift Register GPIO Driver
>> +
>> +This binding describes generic parallel-in/serial-out shift register
>> +devices that can be used for GPI (General Purpose Input). This includes
>> +SN74165 serial-out shift registers and the SN65HVS88x series of
>> +industrial serializers.
>> +
>> +Required properties:
>> + - compatible          : Should be "pisosr-gpio".
>
> I think it should also define compatible strings on the "vendor,device"
> format apart from the generic compatible. Sooner or later we may need
> to differentiate them and then that comes in handy.
>

Would it be better to wait until/if this issue arises? This driver
targets the generic features, as these parts are very generic and
have been produced by many companies since the 70s I'm not sure
if privileging any of them makes much sense.

What I'm worried about looks to have happened with the gpio-74x164
driver, this is kind of the companion device to mine (74164 / 74165)
and should work with any 74164 compatible shift register (possibly 100s
of versions of them), but the compatible string that was added is
"fairchild,74hc595", a relatively new device by a single manufacturer.
The problem this has is then that boards will use this compatible string
even if the parts are not actually the Fairchild version, just to get
the match, when they should be using a generic string.

>> + - gpio-controller     : Marks the device node as a GPIO controller.
>> + - #gpio-cells         : Should be two. For consumer use see gpio.txt.
>> +
>> +Optional properties:
>> + - ngpios              : Number of GPIO lines, default is 8.
>
> If you didn't do "pisosr-gpio" but instead "foo,sn74165", maybe you
> don't need to have this in the device tree but instead it can be
> determined from the compatible string?
>
> In that case do that.
>

These devices can be daisy-chained together, so three 8bit registers
look exactly like one 24bit register. The only way to know this is
from the physical wiring of the board, not from the part number.

Thanks,
Andrew

>> + - load-gpios          : GPIO pin specifier attached to load enable, this
>> +                         pin is pulsed before reading from the device to
>> +                         load input pin values into the the device.
>
> OK seems necessary.
>
> Yours,
> Linus Walleij
>
