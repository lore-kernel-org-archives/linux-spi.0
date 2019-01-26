From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Date: Sat, 26 Jan 2019 16:40:06 +0100
Message-ID: <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk> <20190125175031.GA25898@sirena.org.uk>
 <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
 <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On 26/01/2019 11:25, Geert Uytterhoeven wrote:
> Hi Jonas,
> 
> On Sat, Jan 26, 2019 at 8:53 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>> On 25/01/2019 18:50, Mark Brown wrote:
>>> On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
>>>> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
>>>>> Having this as device property rather than a transfer property allows this
>>>>> to be configured one time in setup() rather than having to fiddle with the
>>>>> configuration register for every transfer.
>>>
>>>> That doesn't mean that the coniguration should be done in DT though, and
>>>> given that this presumably is a property of the device there seems to be
>>>> no reason why we'd have it in DT - if every instance of the device is
>>>> going to need to set the property we should just figure it out from the
>>>> compatble string instead.
>>>
>>> To be clear here: the suggestion is to add a parameter the slave device
>>> can set in spi_device which sets the default word_delay similarly to how
>>> max_speed_hz works.
>>
>> I'm confused... isn't that exactly what this patch does?  It adds a
>> field word_delay to spi_device in the same manner as max_speed_hz.
>>
>> I also added the ability to set it via DT, which I can break out into a
>> separate patch if that's an issue.  Or is the problem that it's set via
>> DT, at all?  Documentation/devicetree/bindings/spi-bus.txt documents 10
>> other slave-node properties related to transfer characteristics;
>> word_delay is just another such characteristic.
>>
>> But again, I'm having trouble parsing your response  Is the patch wrong,
>> should be broken up, or you just misunderstood it?
> 
> IIUIC, Mark means that it may be a non-configurable property of the slave
> device, and thus should be handled (fixed setting) in the SPI slave driver.

OK, so given that the "compatible" property identifies the hardware and 
there is no other _hardware_ configuration detail that affects the 
required inter-word delay, then setting the property in the device tree 
is not allowed as the driver has enough info to set it properly.  Fair 
enough!

> 
> Compare this to CPHA/CPOL, which are properties of the SPI slave device,
> but which may be configurable. E.g. many SPI FLASHes support multiple
> configurations. See e.g. commit 9c5becce21af35e5 ("ARM: shmobile: koelsch:
> Fix QSPI mode of SPI-Flash into mode3").

There is nothing about the hardware referenced in that patch that 
enforces either mode.  Why does the driver get to defer to DT here?

Looking at Documentation/devicetree/bindings/spi/spi-bus.txt:

spi-lsb-first:  used only by MAXIM DS-1302 which is always LSB first; 
driver should set this

spi-3wire: again, only set by MAXIM DS-1302 which always needs this 
setting; driver could set this

spi-tx-delay-us:
spi-rx-delay-us:  only parsed by RMI4 driver... no DTS files in kernel 
set these.  I hardly see how these are "hardware" settings rather than 
message settings, but the driver can set these in any case.

Anyway, the point is, looking at the current documentation, it's pretty 
difficult to understand whether devicetree is restricted to describing 
hardware or is also for configuring drivers...

> 
> Again, max_speed_hz is something different: while both the SPI master and
> slave may support high speeds, board wiring (capacitance/inductance) may
> need to force a slower speed than supported by the devices, so it makes
> sense to make that configurable from DT.

Yeah, that one make sense.  But if the DT is only overriding the maximum 
device frequency that the driver should otherwise be setting, why is 
spi-max-frequency a _required_ property?

Thanks for taking the time to provide the additional explanation.  I had 
to ruminate on it for a bit, but I think it's starting to sink in now!

/Jonas

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
