From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/2] spi: support inter-word delay requirement for devices
Date: Mon, 28 Jan 2019 12:51:02 +0100
Message-ID: <94c7514c-de1f-ff70-d2b7-6394f9747942@norrbonn.se>
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-2-jonas@norrbonn.se>
 <CAMz4ku+sqzK19994BpdSfaDjNdXW_-gnCutr_fYQiv5ynxOq2g@mail.gmail.com>
 <f34151c8-28a3-3d53-a27e-b5ff512d9c94@norrbonn.se>
 <20190125174713.GA6939@sirena.org.uk> <20190125175031.GA25898@sirena.org.uk>
 <84d6c40f-62bb-fd00-0dcb-d2f390b136c1@norrbonn.se>
 <CAMuHMdUyt=DDMwDZA-TB0Yac13NJQCo2LxzvqnRzvn6LZ5F98w@mail.gmail.com>
 <ed62564f-d36b-1492-8e65-60166c0aa4a6@norrbonn.se>
 <CAMuHMdXQONq1UFuFHwny_xfAtxY7sOv2K3yi2i9T22OovMqFhw@mail.gmail.com>
 <20190128114757.GA11699@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128114757.GA11699@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 28/01/2019 12:47, Mark Brown wrote:
> On Mon, Jan 28, 2019 at 08:41:05AM +0100, Geert Uytterhoeven wrote:
>> On Sat, Jan 26, 2019 at 4:40 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> 
>>> spi-3wire: again, only set by MAXIM DS-1302 which always needs this
>>> setting; driver could set this
> 
>> For DS1302, this is probable true.
>> Some devices may support both 4-wire or 3-wire mode?
> 
> IIRC yes.

Just for the record, the datasheet says it's exclusively 3-wire.  But 
it's not important...

/Jonas

> 
>>> Yeah, that one make sense.  But if the DT is only overriding the maximum
>>> device frequency that the driver should otherwise be setting, why is
>>> spi-max-frequency a _required_ property?
> 
>> That's a good question. Legacy?
> 
> It's a documentation error.
> 
