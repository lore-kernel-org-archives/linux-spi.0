From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Tue, 2 Jan 2018 17:23:04 +0100
Message-ID: <CAK8P3a08a+QhPof=pF64jRKYjrmGa=P5DnPDD4zdq2HaZ-2wyQ@mail.gmail.com>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
 <e11e7a46-d038-4299-6781-525feda8f851@linux.intel.com> <CAK8P3a1Jw+oQ6Z_DG6uDFYpqboRoki+4MyXGScuQJ-__-nUE6A@mail.gmail.com>
 <a1de8f61-701e-221e-2d32-e7412b86b58e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Wang, Haiyue" <haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <a1de8f61-701e-221e-2d32-e7412b86b58e-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jan 2, 2018 at 4:36 PM, Wang, Haiyue
<haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On 2018-01-02 23:13, Arnd Bergmann wrote:
>>> On 2017-12-31 07:10, Arnd Bergmann wrote:
>>>> It also seems rather inflexible to have a single driver that is
>>>> responsible both
>>>> for the transport (eSPI register level interface for ASPEED) and the
>>>> high-level
>>>> protocol (talking to an Intel PCH), since either half of the work could
>>>> be
>>>> done elsewhere, using either a different eSPI slave implementation, or
>>>> a different
>>>> host architecture)
>>>
>>> Yes, eSPI has the architecture such as transaction layer, link Layer;
>>> all of it is about the **silicon**
>>> design. That's why I put the driver under /misc directory, not /spi
>>> directory.
>>
>> I don't see any requirement in the eSPI spec for the upper layers to
>> be implemented in hardware. Obviously an x86 host such as Intel's
>> PCH would implement the host interface using PIO,  and MMIO
>> accesses that are compatible with ISA and LPC, as this is the motivation
>> behind the specification, but an ARM server that wants to use eSPI
>> based peripherals could choose to implement it just as well using
>> a traditional SPI master hardware, some GPIOs (reset and alert)
>> and a (driver independent) software implementation of the transaction
>> and link layers.
>>
>> On the slave side, it seems that aspeed have implemented the
>> virtual wires partially in hardware and require a driver like the one
>> you wrote to reply to some of the wires being accessed by the host,
>> but again it seems plausible that this could be implemented in another
>> BMC using a generic SPI slave and a transaction layer written
>> entirely in software.
>
> Yes, you are right, Aspeed have implemented the virtual wires partially.
> Tthat's why I named it
> as aspeed-espi-slave driver.

Maybe the name should be more specific and refer to only virtual-wire
rather than espi-slave?

>> Your driver does not handle the other channels (smbus, mmio, spinor)
>> at the moment at all, can you provide some information how they
>> are implemented in the ast2500? Are those handled completely
>> in hardware (I assume this is the case for spinor at least), or do they
>> require help from a driver, either this one or a separate one?
>
> I can't send the AST2500 datasheet to you directly, but you can contact
> Aspeed firstly.
> https://www.aspeedtech.com/products.php?fPath=20&rId=440
>
> These functions are handled in hardware, the original SDK just provides some
> ioctl API for user
> application to access them. The mmio function such as KCS / Port 80, these
> controllers will get
> data from eSPI IP in silicon, but their drivers do not need to be changed,
> run the same as LPC
> mode.
>
> You can image bellowing work path:
>
>  KCS    Mailbox  Snoop (Port 80)  UART ....
>    ^        ^                 ^                          ^
>    |         |                |                           |
>    |         |                |                           |
>     \        |                /                          /
>              { LPC IP }            <-------------------- { eSPI IP to decode
> the mmio address }

This is all handled by the drivers/misc/aspeed-lpc-snoop.c driver, right?

> And in our first generation eSPI x86 server, we  just use the eSPI new
> function to decode the VW to boot the PCH (eSPI master).
>
> Other functions such as GPIO SMBus, we didn't use it. So for making
> things clean, we just keep the basic code, which is verified and tested
> well.

For the upstream submission, having the code verified and tested
is secondary, it most of all must be maintainable in the future ;-)

Your current driver is very simple, which is good: it shouldn't try to be
overly generic and do things we won't ever need, but I want to be
sure that I understand the bigger picture well enough and ensure
that the code is generic enough to do the things we know we will
need.

I see that your documentation only refers to the generic principle of
eSPI, while the driver deals mostly with the aspeed specifics. If we
get a generic virtual-wire implementation based on the spi-slave
framework, the documentation would be the same, and part
of the driver would also be the same. OTOH, if one were to use
the SMBUS over eSPI, the high-level interaction with the vw
would have to be different, and at that point, we'd probably want
an abstraction that can deal with both the aspeed hardware and
a simple spi-slave based implementation.

Superficially, the virtual wires closely resemble GPIOs both on
the host and the slave side, so I wonder if your driver could be
rewritten into a gpiochip driver that implements the slave side of
the eSPI VW on ast2500: make it export a set of GPIO lines,
I suppose you'd need 64 GPIOs to cover all possible
bits in ESPI_SYS_ISR and ESPI_SYS1_ISR, plus an irqchip
to handle the virtual events (ESPI_SYSEVT_HOST_RST_WARN
etc). That would let you separate the simple logic (ack after
warn, boot-done after boot, ...) into one driver or even
user space, and keep the low-level driver specific to ast2500
but otherwise independent of the host side. Do you think that
makes sense?

      Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
