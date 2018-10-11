From: Talel Shenhar <talel@amazon.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Date: Thu, 11 Oct 2018 10:39:22 +0300
Message-ID: <3ad7fac8-2f13-690b-9e4b-c6b2373756b0@amazon.com>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <1539210111.1944.31.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "barakw@amazon.com" <barakw@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, <jonnyc@amazon.com>
To: Trent Piepho <tpiepho@impinj.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539210111.1944.31.camel@impinj.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/11/2018 01:21 AM, Trent Piepho wrote:
> On Wed, 2018-10-10 at 10:08 +0300, Talel Shenhar wrote:
>> The dw spi controller has an auto-deselect of Chip-Select, in case there is
>> no data inside the Tx FIFO. While working on platforms with Alpine chips,
>> auto-deselect mode causes an issue for some spi devices that can't handle
>> the Chip-Select deselect in the middle of a transaction. It is a normal
>> behavior for a Tx FIFO to be empty in the middle of a transaction, due to
>>
> So that's the problem!  I, like everyone else I suspect, switched to
> using GPIO chip selects with this driver because of this.  I narrowed
> it down to a CS de-assert when the bus switched from TX to RX, which of
> course makes a SPI register read fail on most devices.  The TX FIFO
> would empty at this point, so that would explain it.
>
> Did the designers of this IP ever read a SPI device datasheet???
>
> Got to agree with Mark Brown, why would anyone ever want to NOT have it
> work properly?  The previous behavior is not "alternate correct", it's
> Broken.
This patch allow the Amazon changed hw to work in a correct way.
Unfortunately, the original hw doesn't support auto-deselect disable.
auto-deselect disable is a hw fixup Amazon hw engineers added on top
of the original dw IP.
The fix was to disable the auto-deselect and to allow sw
to manually control the chip-select.
This patch enables the above described Amazon hw fixup and
adds manual control over chip-select.
