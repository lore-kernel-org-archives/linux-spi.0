From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] spi: xilinx: Use standard num-cs binding
Date: Fri, 27 Mar 2015 11:55:49 +0100
Message-ID: <2a81c738-f7e2-4387-b04c-05c9892ba8e4@BN1AFFO11FD026.protection.gbl>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
 <20150308190012.GV28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	=?windows-1252?Q?S=F6?= =?windows-1252?Q?ren_Brinkmann?=
	<soren.brinkmann@xilinx.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150308190012.GV28806@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 03/08/2015 08:00 PM, Mark Brown wrote:
> On Fri, Jan 16, 2015 at 01:55:14PM +0100, Michal Simek wrote:
>> Use standard num-cs binding property and setup
>> "xlnx,num-ss-bits" as deprecated.
> 
> Why?  These properties mean different things - num-cs is a bit confused
> and is the total number of available chip selects for the system (which
> could include GPIOs) while num-ss-bits is the size of the bitfield
> (which could include things not actually mapped out properly/successfully 
> or something if the hardware designers were feeling particularly inspired).

I was checking meaning of num-ss-bits and meaning is Number of slaves (taking
explanation from Vivado 2014.4) Range 1-32.
http://www.xilinx.com/support/documentation/ip_documentation/axi_spi/v1_02_a/axi_spi_ds742.pdf
Table 1 - page 4

Checking through the hw design every pin is connected to device to do chip select.
That's why I think that num-cs (based on spi-bus.txt) is the right property.

Of course hw guys can use decoder from these bits and we could use binding
as is used in cadence spi (is-decoded-cs)

> I'm not convinced num-cs ever made any sense.

Does it mean that num-cs property used by 11 SPI drivers is just incorrect?

Based on Documentation/devicetree/bindings/spi/spi-bus.txt it is the part of binding
- num-cs : total number of chipselects

Please let me know what you think.

Thanks,
Michal
