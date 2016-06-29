From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/6] spi: Document DT bindings for SPI controllers in
 slave mode
Date: Wed, 29 Jun 2016 11:30:32 +0200
Message-ID: <CAMuHMdV2PO8oTtWbUCNNohoAXP8Z=uNKPASWwkutZpEytydDew@mail.gmail.com>
References: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
 <1466602929-4191-2-git-send-email-geert+renesas@glider.be> <20160624170649.GA22305@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	linux-spi <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160624170649.GA22305@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On Fri, Jun 24, 2016 at 7:06 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jun 22, 2016 at 03:42:04PM +0200, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-bus.txt | 31 ++++++++++++++---------
>>  1 file changed, 19 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index 17822860cb98c34d..bcd024e0bb9e0009 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -1,17 +1,23 @@
>>  SPI (Serial Peripheral Interface) busses
>>
>> -SPI busses can be described with a node for the SPI master device
>> -and a set of child nodes for each SPI slave on the bus.  For this
>> -discussion, it is assumed that the system's SPI controller is in
>> -SPI master mode.  This binding does not describe SPI controllers
>> -in slave mode.
>> +SPI busses can be described with a node for the SPI controller device
>> +and a set of child nodes for each SPI slave on the bus.  The system's SPI
>> +controller may be described for use in SPI master mode or in SPI slave mode,
>> +but not for both at the same time.
>>
>> -The SPI master node requires the following properties:
>> +The SPI controller node requires the following properties:
>> +- compatible      - name of SPI bus controller following generic names
>> +             recommended practice.
>> +
>> +In master mode, the SPI controller node requires the following additional
>> +properties:
>>  - #address-cells  - number of cells required to define a chip select
>>               address on the SPI bus.
>>  - #size-cells     - should be zero.
>> -- compatible      - name of SPI bus controller following generic names
>> -             recommended practice.
>> +
>> +In slave node, the SPI controller node requires the presence of a child node
>> +named "slave", further following the practices for SPI slave nodes below.
>> +
>
> I wouldn't create a child node. Just add a property for slave mode and
> put the timing mode properties in controller node.

Originally I wanted to just add a "slave" property, too.
However, not having a child node means you cannot bind a driver for an SPI
slave handler from DT, as the existing compatible property is meant for the SPI
slave controller. That's why I went with the child naming rule instead.

Not being able to bind a driver from DT could be a good thing, as this could
be considered software configuration, not hardware description.

E.g. i2c slave requires binding slave handlers manually, by creating a new
device on the bus, using the existing mechanism for adding new devices to an
i2c bus, cfr. Documentation/i2c/slave-interface:

        echo slave-24c02 0x1064 > /sys/bus/i2c/devices/i2c-1/new_device

Alternatively, we could always create an spidev interface for SPI slave
controllers, but that precludes (or makes it more difficult) binding another
driver if that is available.

This could definitely use some more discussion or feedback... Thoughts?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
