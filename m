From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
Date: Sat, 21 Dec 2019 22:07:44 +0100
Message-ID: <e26f985b-ceca-ca2c-a709-e7dc40c7fdd1@suse.de>
References: <20191212033952.5967-1-afaerber@suse.de>
 <20191221182057.GA32732@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-realtek-soc@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191221182057.GA32732@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Pavel,

[- Roc He, - chipset vendors]

Am 21.12.19 um 19:20 schrieb Pavel Machek:
>> It goes on to add a "text" attribute to the driver that enables DT-configured
>> seven-segment displays; I was expecting to find precedence in auxdisplay
>> subsystem but came up empty. So my driver currently integrates its own
>> generic (but incomplete) character-to-8-segments mapping, as well as in a
>> second step a combined-characters-to-8-segments mapping, which then gets
>> mapped to the chipset's available output lines. Doing this as sysfs
>> device
> 
> I did not investigate this in great detail; but if it is displaying
> characters, auxdisplay is probably right subsystem to handle that.

ausdisplay does not have any common API AFAICS. Most of them are 
high-level displays with some parallel interface to set text and 
metadata. Half of them hardcode the text to Linux or maybe offer a 
Kconfig option to override it; the other half implements their own 
character device file with ABI specific to that driver.

> I
> guess LEDs can still take the low-level parts...

I'd hope so, but I believe we're missing multiple things there:

1) A bulk-update API for setting multiple LEDs at once. 
.brightness_set[_blocking]() is all we have on the device side, which 
here results in two SPI commands. led_set_brightness[_sync]() is all I 
see on the API side. We'd need an API that takes an array of LEDs and 
brightness values and allows a common driver rather than individual 
devices to update the Display RAM via SPI from an internal buffer.

2) DT is currently limited to one node per LED device. We'd need 
#led-cells, with current LED nodes defaulting to zero. That way we could 
address LEDs from an external, e.g., auxdisplay driver via a two-cell 
index for these LED controllers, without needing to have DT nodes for 
each and every display segment.

3) Better LED device names. More "function" values, or a reversal of the 
label deprecation. Or an alternative API to register LEDs with manual name.

4) LED triggers controlling more than one LED. linux,default-trigger 
seems to assign one per LED, so that two heartbeats are quickly out of 
sync. Doing it from code would probably be simpler than finding a way to 
model this in DT, but I don't yet see how.

Alternatively we could expose those LED output lines as a gpiochip, 
which we can already index in DT, and consider the display GPIO-based, 
but then we're in the situation again that GregKH was telling people to 
either go screw themselves in userspace or move things into leds, which 
now you're against.

Also, if you don't allow displays in leds, then we can't have LED 
triggers for them either.

> 
> Oh, and common dimming for many LEDs is seen on other hardware, too
> (Turris routers). Not sure how to handle that, either :-(.

That part I have indeed successfully solved with a backlight device.

My current problem (WIP blocking a push) is the key input handling - not 
sure how to model both LEDs and keys as DT child nodes - do we need a 
compatible to distinguish between them? Unit addresses and reg values 
would be in different ranges, making this awkward, not to mention the 
problem of naming a compatible, given the incredible diverse chipsets.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
