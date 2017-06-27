From: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RFC PATCH v3 2/6] dt-bindings: spi/core: add wakeup-source optional
 property
Date: Tue, 27 Jun 2017 10:04:07 +0800
Message-ID: <5951BD17.305@rock-chips.com>
References: <1498039313-24220-1-git-send-email-jeffy.chen@rock-chips.com> <1498039313-24220-3-git-send-email-jeffy.chen@rock-chips.com> <20170626160011.qi3bliz5jt6d5wgb@rob-hp-laptop> <20170626164016.GA4965@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170626164016.GA4965@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On 06/27/2017 12:40 AM, Dmitry Torokhov wrote:
> On Mon, Jun 26, 2017 at 11:00:11AM -0500, Rob Herring wrote:
>> On Wed, Jun 21, 2017 at 06:01:49PM +0800, Jeffy Chen wrote:
>>> Update document devicetree bindings to support "wakeup-source" property.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>> ---
>>>
>>> Changes in v3: None
>>>
>>>   Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>> index 1f6e86f..0fa1ccf 100644
>>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>>> @@ -77,6 +77,7 @@ All slave nodes can contain the following optional properties:
>>>   		    Defaults to 1 if not present.
>>>   - spi-rx-delay-us - Microsecond delay after a read transfer.
>>>   - spi-tx-delay-us - Microsecond delay after a write transfer.
>>> +- wakeup-source   - Device can be used as a wakeup source.
>>
>> wakeup-source is valid for any device with an interrupts property
>> already, so I don't think this is necessary.
i saw http://lkml.iu.edu/hypermail/linux/kernel/1510.2/04553.html add a 
Documentation/devicetree/bindings/power/wakeup-source.txt for this, but 
that serial didn't remove all wakeup-source property from other 
bindings, but standardize them, for example:
71a0151 Documentation: devicetree: fix reference to legacy wakeup properties

+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -24,6 +24,7 @@ Optional subnode-properties:
         - debounce-interval: Debouncing interval time in milliseconds.
           If not specified defaults to 5.
         - wakeup-source: Boolean, button can wake-up the system.
+                        (Legacy property supported: "gpio-key,wakeup")

>
> Do you mean it is not necessary on SPI level or not necessary at all? Or
> you disagree with wording? Because we do need a way to say that on given
> platform the device is supposed to be configured as a wakeup source.
>
> Thanks.
>

Hi guys,

Mark Brown suggested to put wakeup-source support in some common place 
instead of sub drivers, should we do that?

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
