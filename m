From: "Wang, Haiyue" <haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Thu, 4 Jan 2018 08:11:53 +0800
Message-ID: <e45f4211-1b42-33ff-95ef-bcb6744b0815@linux.intel.com>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
 <e11e7a46-d038-4299-6781-525feda8f851@linux.intel.com>
 <CAK8P3a1Jw+oQ6Z_DG6uDFYpqboRoki+4MyXGScuQJ-__-nUE6A@mail.gmail.com>
 <a1de8f61-701e-221e-2d32-e7412b86b58e@linux.intel.com>
 <CAK8P3a08a+QhPof=pF64jRKYjrmGa=P5DnPDD4zdq2HaZ-2wyQ@mail.gmail.com>
 <e09a0c0c-9e95-01c5-d652-c9622db81118@linux.intel.com>
 <CAK8P3a2LaHfGgmMVeLvd=MeJgfAcmX=0hEwnLq5aiOsSDGKDyg@mail.gmail.com>
 <aabc847e-0524-6813-9ffe-7e689fb6a443@linux.intel.com>
 <bb890566-1a8c-a781-be1a-f5c665518884@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "Shevchenko, Andriy" <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bb890566-1a8c-a781-be1a-f5c665518884-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2018-01-04 01:08, Wang, Haiyue wrote:
>
>
>
> On 2018-01-04 00:43, Wang, Haiyue wrote:
>> On 2018-01-03 23:17, Arnd Bergmann wrote:
>>> On Wed, Jan 3, 2018 at 3:21 AM, Wang, Haiyue
>>> <haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>  wrote:
>>>> On 2018-01-03 00:23, Arnd Bergmann wrote:
>>>>> On Tue, Jan 2, 2018 at 4:36 PM, Wang, Haiyue<haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>  wrote:
>>>>>> On 2018-01-02 23:13, Arnd Bergmann wrote:
>>>>>>>> On 2017-12-31 07:10, Arnd Bergmann wrote:
>>>>>>> On the slave side, it seems that aspeed have implemented the
>>>>>>> virtual wires partially in hardware and require a driver like the one
>>>>>>> you wrote to reply to some of the wires being accessed by the host,
>>>>>>> but again it seems plausible that this could be implemented in another
>>>>>>> BMC using a generic SPI slave and a transaction layer written
>>>>>>> entirely in software.
>>>>>> Yes, you are right, Aspeed have implemented the virtual wires partially.
>>>>>> Tthat's why I named it
>>>>>> as aspeed-espi-slave driver.
>>>>> Maybe the name should be more specific and refer to only virtual-wire
>>>>> rather than espi-slave?
>>>> We changed Aspeed's reference code about virtual-wire to production code,
>>>> which meets the upstream code style. If other people used new features in eSPI
>>>> slave, they can add into this place one by one, which is proved to work. This is
>>>> a eSPI slave start point for Aspeed, not just virtual wires.
>>> I fear this could tie the application-level protocol too closely to the aspeed
>>> hardware driver. More on that below.
>>
>> Looks like yes, for eSPI is new thing, not sure other BMC chip 
>> company how to design the eSPI slave.
>>
>>>>>> You can image bellowing work path:
>>>>>>
>>>>>>    KCS    Mailbox  Snoop (Port 80)  UART ....
>>>>>>      ^        ^                 ^                          ^
>>>>>>      |         |                |                           |
>>>>>>      |         |                |                           |
>>>>>>       \        |                /                          /
>>>>>>                { LPC IP }            <-------------------- { eSPI IP to
>>>>>> decode
>>>>>> the mmio address }
>>>>> This is all handled by the drivers/misc/aspeed-lpc-snoop.c driver, right?
>>>> This driver just handle port 80. And later may have kcs-bmc.c upstream from
>>>> openbmc
>>>> project:https://github.com/openbmc/docs/blob/master/kernel-development.md
>>> Ok.
>>>
>>>>>> And in our first generation eSPI x86 server, we  just use the eSPI new
>>>>>> function to decode the VW to boot the PCH (eSPI master).
>>>>>>
>>>>>> Other functions such as GPIO SMBus, we didn't use it. So for making
>>>>>> things clean, we just keep the basic code, which is verified and tested
>>>>>> well.
>>>>> For the upstream submission, having the code verified and tested
>>>>> is secondary, it most of all must be maintainable in the future ;-)
>>>>>
>>>>> Your current driver is very simple, which is good: it shouldn't try to be
>>>>> overly generic and do things we won't ever need, but I want to be
>>>>> sure that I understand the bigger picture well enough and ensure
>>>>> that the code is generic enough to do the things we know we will
>>>>> need.
>>>> Sure, people should easily add new features into this file. They just need
>>>> add other interrupt
>>>> handling here. Currently, we handle the basic interrupt bits.
>>> Can you list what other interrupts there are in this hardware block,
>>> and what they relate to? You already said that the MMIO/PIO support
>>> is a separate hardware block that is shared with the LPC slave,
>>> and I guess there is no block for a flash protocol, so is this
>>> VW and SMBUS combined, or does it do more than those two?
>>
>> Such as:
>> Flash Channel Tx Error
>>   OOB Channel Tx Error
>>   Flash Channel Tx Abort
>>   OOB Channel Tx Abort
>>   Peripheral Channel Non-Posted Tx Abort
>>   Peripheral Channel Posted Tx Abort
>>   Virtual Wire GPIO Event
>>   ...
>>
>>>>> I see that your documentation only refers to the generic principle of
>>>>> eSPI, while the driver deals mostly with the aspeed specifics. If we
>>>>> get a generic virtual-wire implementation based on the spi-slave
>>>>> framework, the documentation would be the same, and part
>>>>> of the driver would also be the same. OTOH, if one were to use
>>>>> the SMBUS over eSPI, the high-level interaction with the vw
>>>>> would have to be different, and at that point, we'd probably want
>>>>> an abstraction that can deal with both the aspeed hardware and
>>>>> a simple spi-slave based implementation.
>>>>>
>>>>> Superficially, the virtual wires closely resemble GPIOs both on
>>>>> the host and the slave side, so I wonder if your driver could be
>>>>> rewritten into a gpiochip driver that implements the slave side of
>>>>> the eSPI VW on ast2500: make it export a set of GPIO lines,
>>>>> I suppose you'd need 64 GPIOs to cover all possible
>>>>> bits in ESPI_SYS_ISR and ESPI_SYS1_ISR, plus an irqchip
>>>>> to handle the virtual events (ESPI_SYSEVT_HOST_RST_WARN
>>>>> etc). That would let you separate the simple logic (ack after
>>>>> warn, boot-done after boot, ...) into one driver or even
>>>>> user space, and keep the low-level driver specific to ast2500
>>>>> but otherwise independent of the host side. Do you think that
>>>>> makes sense?
>>>> Currently, these virtual wires side-band signals between PCH and BMC
>>>> (AST2500) needs to be
>>>> handled in time. So we did it in ISR by reading and writing registers. When
>>>> this driver is loaded,
>>>> then it can handle just in kernel mode, no need a user application. And the
>>>> real GPIO pin signal
>>>> if transferred by ePSI VW, Aspeed will map these VW values to the GPIO
>>>> contorller, so that the
>>>> original GPIO driver still work.
>>> I meant it can be done either in user space or kernel. Doing the
>>> update of the VW can easily be done on top of a GPIO abstraction
>>> when you register an interrupt handler for each VW that is is an
>>> event source, and then sets the registers through gpiolib. On the
>>> hardware side, the interaction is the same, just with a few cycles
>>> added for the separation between the application layer driver
>>> and the hardware specific driver.
>>
>> In practice, we load this driver as soon as possible, so that the 
>> eSPI master can make PMC in PCH
>> to exit G3 state, which is said in the patch commit patch. So that 
>> other drivers such as KCS, Snoop
>> can work in time for powering on the host. Simple should be better 
>> for embedded system ? ;-)
>>
>
> And if we design the VW as gpio, looks like that the developers need 
> to design their own application
> to handle the VWs. This makes things worse in my understanding. They 
> have to look into the eSPI
> spec in detail, and in fact, this VW handing is not easily to 
> understand. For they are about Intel's PCH
> power side-band signal handling. ;-)
>
>>>          Arnd
>>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
