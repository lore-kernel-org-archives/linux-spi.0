From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 7 Nov 2016 19:53:42 +0100
Message-ID: <4bdba358-db18-48f1-3286-a7a7f4c30215@denx.de>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk>
 <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
 <2255968d-b97c-2b9c-4e4d-7f3717a748e3@denx.de>
 <01d1a97b-2f43-49a6-51fb-e223ef4dce9b@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Joel Holdsworth <joel@airwebreathe.org.uk>,
        atull@opensource.altera.com, moritz.fischer@ettus.com,
        geert@linux-m68k.org, robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        clifford@clifford.at
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01d1a97b-2f43-49a6-51fb-e223ef4dce9b@airwebreathe.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/07/2016 07:49 PM, Joel Holdsworth wrote:
> Hi Marek,

Hi,

> Thanks again for your comments.
> 
> 
> On 07/11/16 11:01, Marek Vasut wrote:
>> On 11/07/2016 03:49 AM, Joel Holdsworth wrote:
>>> The Lattice iCE40 is a family of FPGAs with a minimalistic architecture
>>> and very regular structure, designed for low-cost, high-volume consumer
>>> and system applications.
>>
>> [...]
>>
>>> +static int ice40_fpga_ops_write_init(struct fpga_manager *mgr, u32
>>> flags,
>>> +                     const char *buf, size_t count)
>>> +{
>>> +    struct ice40_fpga_priv *priv = mgr->priv;
>>> +    struct spi_device *dev = priv->dev;
>>> +    struct spi_message message;
>>> +    struct spi_transfer assert_cs_then_reset_delay = {.cs_change = 1,
>>> +        .delay_usecs = ICE40_SPI_FPGAMGR_RESET_DELAY};
>>
>> Should be this way for the sake of readability, fix globally:
>>
>>     struct spi_transfer assert_cs_then_reset_delay = {
>>         .cs_change    = 1,
>>         .delay_usecs    = ICE40_SPI_FPGAMGR_RESET_DELAY
>>     };
> 
> Sure ok. Personally, I prefer it to be concise, but I'm happy to accept
> the norms.

I prefer it to be readable :)

>> Also I believe this could be const.
> 
> It doesn't work const - I tried it. spi_message_add_tail() expects it to
> be non-const. Looking at 'struct spi_transfer' it appears there is
> various bits of state used to perform the transfer, as well as the
> pointer to the next item in the single-linked list.

Ah, right.

>>
>>> +    struct spi_transfer housekeeping_delay_then_release_cs = {
>>> +        .delay_usecs = ICE40_SPI_FPGAMGR_HOUSEKEEPING_DELAY};
>>
>> Don't we have some less hacky way of toggling the nCS ? Is this even nCS
>> or is this some control pin of the FPGA ? Maybe it should be treated
>> like a regular GPIO instead ?
> 
> I've been round this loop before also. drivers/spi/spi.c has a static
> function 'static void spi_set_cs(struct spi_device *dev, bool enable)'.
> It manipulates the CS line of devices where CS is built into the SPI
> master, and manipulates the GPIO on other devices.
> 
> I don't know why it's non-public - I tried to get an answer from the SPI
> folks, but didn't get one. I guess they don't want to encourage drivers
> to manually manipulate the CS line - because SPI transfers are usually
> meant to be interruptible by higher priority transfers to other devices
> at any time. The only reason it's legit for me to manually manipulate CS
> is because I first lock the bus.
> 
> Previously I had a copy of spi_set_cs copy-pasted into my driver, but in
> the end I decided to replace that with the zero-length transfers because
> there's a danger that if the original spi_set_cs() gets rewritten some
> time, my copy-paste code would leave around some nasty legacy.
> 
> On the whole, I don't think the zero-length transfers are too
> egregiously bad, and all the alternatives seem worse to me.

So why not turn the CS line into GPIO and just toggle the GPIO?

>>> +    const u8 padding[ICE40_SPI_FPGAMGR_NUM_ACTIVATION_BYTES] = {0,};
>>
>> The comma is not needed.
> 
> True. I'll make that change.
> 
> 
>>> +    /* Check board setup data. */
>>> +    if (spi->max_speed_hz > 25000000) {
>>> +        dev_err(dev, "Speed is too high\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (spi->max_speed_hz < 1000000) {
>>> +        dev_err(dev, "Speed is too low\n");
>>> +        return -EINVAL;
>>> +    }
>>
>> Do you have some explanation for this limitation ?
>>
> 
> Not really no.
> 
> The 'DS1040 - iCE40 LP/HX Family Data Sheet' page 3-18 claims f_max for
> Slave SPI Writing is >=1MHz && <=25MHz.
> 
> The exact reason I don't know.

OK

> Are they running a PLL off the clock? What if the clock is really
> jittery - it seems to work fine when I've tested it with bit-banged SPI
> on the RPi; just as well as with hardware SPI.
> 
> Or is it something to do with some pre-commit on-chip firmware storage?
> e.g. to check the CRC. Does the storage buffer have some time limitation
> before it gets committed to the FPGA core?
> 
> I'm not sure, so I decided to just reflect the datasheet instructions
> back to the user.

Sounds good, thanks.

-- 
Best regards,
Marek Vasut
