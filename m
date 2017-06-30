From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v3 2/6] dt-bindings: spi/core: add wakeup-source
 optional property
Date: Fri, 30 Jun 2017 09:44:27 -0500
Message-ID: <CAL_JsqJCvtCx-s3usVaPvz0bH8EZOGyykG2CTG6_mmNR7cHp_w@mail.gmail.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com>
 <1498039313-24220-3-git-send-email-jeffy.chen@rock-chips.com>
 <20170626160011.qi3bliz5jt6d5wgb@rob-hp-laptop> <20170626164016.GA4965@dtor-ws>
 <5951BD17.305@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: jeffy <jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5951BD17.305@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 26, 2017 at 9:04 PM, jeffy <jeffy.chen@rock-chips.com> wrote:
> Hi Rob,
>
> On 06/27/2017 12:40 AM, Dmitry Torokhov wrote:
>>
>> On Mon, Jun 26, 2017 at 11:00:11AM -0500, Rob Herring wrote:
>>>
>>> On Wed, Jun 21, 2017 at 06:01:49PM +0800, Jeffy Chen wrote:
>>>>
>>>> Update document devicetree bindings to support "wakeup-source" property.
>>>>
>>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>> ---
>>>>
>>>> Changes in v3: None
>>>>
>>>>   Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> index 1f6e86f..0fa1ccf 100644
>>>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>>> @@ -77,6 +77,7 @@ All slave nodes can contain the following optional
>>>> properties:
>>>>                     Defaults to 1 if not present.
>>>>   - spi-rx-delay-us - Microsecond delay after a read transfer.
>>>>   - spi-tx-delay-us - Microsecond delay after a write transfer.
>>>> +- wakeup-source   - Device can be used as a wakeup source.
>>>
>>>
>>> wakeup-source is valid for any device with an interrupts property
>>> already, so I don't think this is necessary.
>
> i saw http://lkml.iu.edu/hypermail/linux/kernel/1510.2/04553.html add a
> Documentation/devicetree/bindings/power/wakeup-source.txt for this, but that
> serial didn't remove all wakeup-source property from other bindings, but
> standardize them, for example:
> 71a0151 Documentation: devicetree: fix reference to legacy wakeup properties
>
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -24,6 +24,7 @@ Optional subnode-properties:
>         - debounce-interval: Debouncing interval time in milliseconds.
>           If not specified defaults to 5.
>         - wakeup-source: Boolean, button can wake-up the system.
> +                        (Legacy property supported: "gpio-key,wakeup")
>
>>
>> Do you mean it is not necessary on SPI level or not necessary at all? Or
>> you disagree with wording? Because we do need a way to say that on given
>> platform the device is supposed to be configured as a wakeup source.
>>
>> Thanks.
>>
>
> Hi guys,
>
> Mark Brown suggested to put wakeup-source support in some common place
> instead of sub drivers, should we do that?

As you point out, it is already documented in a common place. In SPI
makes no sense. Are you going to document in I2C, simple-bus, USB,
etc. as well?

wakeup-source is really a property of the system (the upstream
interrupt controller in particular), so it doesn't really need to be
documented per device.

Rob
