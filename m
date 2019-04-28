From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 0/3] spi: SPI bus multiplexer
Date: Sun, 28 Apr 2019 22:28:16 +0000
Message-ID: <d91ab2261a1f4069bc48e090bd4ec702@svr-chch-ex1.atlnz.lc>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
 <20190412082913.GA6909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tthayer@opensource.altera.com" <tthayer@opensource.altera.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/04/19 8:29 PM, Mark Brown wrote:=0A=
> On Fri, Apr 12, 2019 at 05:02:10PM +1200, Chris Packham wrote:=0A=
> =0A=
>> Unfortunately recent changes have stopped my hacks from working. I've=0A=
>> tried adapting cs-gpios to work with my particular hardware but I came=
=0A=
>> to the realisation that the current cs-gpios support assumes a 1:1=0A=
>> mapping of gpio to SPI device whereas my hardware used the state of the=
=0A=
>> gpio selecting the device i.e. a 1:2 mapping.=0A=
> =0A=
>> This is my attempt to implement a driver to deal with this. One nice=0A=
>> property is that it is pretty much self contained. The only change to=0A=
>> the core SPI infrastructure is exposing a function I needed to lookup=0A=
>> the spi_controller instance.=0A=
> =0A=
> Why not implement the device that demuxes the GPIOs you're using for=0A=
> chip select as a GPIO controller?  Presumably it might get used for=0A=
> things other than chip selects.=0A=
> =0A=
=0A=
Hmm a gpio-gpio driver. Interesting.=0A=
=0A=
One other problem that I encounter is the interaction between cs-gpio =0A=
and SPI_MASTER_GPIO_SS. Having cs-gpio automatically sets SPI_CS_HIGH =0A=
which has the undesired side-effect that now my real chip select is =0A=
inverted. I actually wonder if this change breaks commit 8eee6b9dd30d =0A=
("spi: Add Flag to Enable Slave Select with GPIO Chip Select.") since =0A=
now there is an extra inversion on the CS enable.=0A=
