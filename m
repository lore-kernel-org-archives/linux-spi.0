From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Date: Sat, 26 Jan 2019 08:52:29 +0100
Message-ID: <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk> <20190125175031.GA25898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125175031.GA25898@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 25/01/2019 18:50, Mark Brown wrote:
> On Fri, Jan 25, 2019 at 05:47:13PM +0000, Mark Brown wrote:
>> On Fri, Jan 25, 2019 at 01:06:45PM +0100, Jonas Bonn wrote:
> 
>>> Having this as device property rather than a transfer property allows this
>>> to be configured one time in setup() rather than having to fiddle with the
>>> configuration register for every transfer.
> 
>> That doesn't mean that the coniguration should be done in DT though, and
>> given that this presumably is a property of the device there seems to be
>> no reason why we'd have it in DT - if every instance of the device is
>> going to need to set the property we should just figure it out from the
>> compatble string instead.
> 
> To be clear here: the suggestion is to add a parameter the slave device
> can set in spi_device which sets the default word_delay similarly to how
> max_speed_hz works.
> 

I'm confused... isn't that exactly what this patch does?  It adds a 
field word_delay to spi_device in the same manner as max_speed_hz.

I also added the ability to set it via DT, which I can break out into a 
separate patch if that's an issue.  Or is the problem that it's set via 
DT, at all?  Documentation/devicetree/bindings/spi-bus.txt documents 10 
other slave-node properties related to transfer characteristics; 
word_delay is just another such characteristic.

But again, I'm having trouble parsing your response  Is the patch wrong, 
should be broken up, or you just misunderstood it?

Thanks,
/Jonas
