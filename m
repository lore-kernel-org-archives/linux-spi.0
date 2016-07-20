From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Wed, 20 Jul 2016 12:41:11 -0700
Message-ID: <578FD3D7.9030402@gmail.com>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
 <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk> <5786B401.2050306@gmail.com>
 <20160713223638.GI9976@sirena.org.uk> <578EA695.1030909@gmail.com>
 <20160720112547.GE6509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160720112547.GE6509-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/20/2016 04:25 AM, Mark Brown wrote:
> On Tue, Jul 19, 2016 at 03:15:49PM -0700, Florian Fainelli wrote:
>> On 07/13/2016 03:36 PM, Mark Brown wrote:
> 
>>> If it was unconditionally in the perhipheral it'd be fairly normal and
>>> standard but it's not, it's a completely separate and optional register
>>> block with a bunch of separate code in a driver which already has above
>>> average complexity even for the bits that belong in it.
> 
>> It is not separate nor optional, the fact that the register range seems
>> discontiguous is just an integration choice here, but it contains bits
>> that are relevant exclusively to the SPI controller.
> 
> Some versions of the block have it, some versions of the block don't
> have it.  That suggests that it's optional.  It is a completely separate
> register map, that suggests that it is an external block.

OK, so maybe we should have given so more information about this is
structured. The block originated from the group in which Kamal and I
work, and original version of the IP is what the brcm,spi-brcmstb looks
like:

- one block which is MSPI + BSPI capable, and is typically used for a
SPI flash as the primary boot medium and storage of the device

- another one which is just MSPI capable, separate register range

- one separate level 2 interrupt controller for the MSPI + BSPI capable
instance for which we have a driver already under
drivers/irqchip/irq-brcmstb-l2.c which is a fairly generic piece of HW
providing de-multiplexed L2 interrupts for MSPI_DONE, MSPI_HALTED,
SPI_LR_* and only those relevant interrupts

- MSPI_DONE + MSPI_HALTED L2 interrupts wired to another L2 interrupt
controller (not dedicated to just MSPI, shared with other L2 interrupts)
for the second MSPI only instance, but also backed by the same HW block
layout and thefore driver

That's for STB SoCs (BCM7xxx), which is a relatively simple and easy to
support HW design.

Another group, in which Dhanajay works later integrated this SPI
controller on the Norsthstar class of SoCs and did the following:

- added a dedicated IDM IO_CONTROL register block for SPI only (there
are one dedicated per functional block, like NAND, USB etc.) which has a
clock enable bit, some other HW-block top-level integration signals for
test modes etc, but also added interrupt enable/disable bits, this is
consistent across all Norsthar* chips, in the Device Tree binding this
is described as the "intr_regs" resource

- grouped the MSPI + BSPI together, one after the other, and appended at
the end of the MSPI block 7 32-bits words, for the 7 interrupt status
bits which all can be read/written to for MSPI_DONE, MSPI_HALTED,
SPI_LR_* interrupts, this is also consistent across all Norsthar* chips.
In the DT binding, this is described as the "intr_status_regs" resource

Note that the layout of the IDM block and the MSPI+BSPI block are
identical between Northstar, Northstar Plus and Northstar 2, so we got
that going, which is nice.

Where they started to somehow diverge is here:

- Norsthar and Northstar Plus both allocated dedicated L1 interrupts
from the top-level ARM GIC interrupt controller for each of the 7
Level-2 interrupts the SPI block cares about: MSPI_DONE, MSPI_HALTED
etc. so we can requests these interrupts individually

- but Northstar 2 only has one single L1 interrupt for all of these 7
interrupts, so we need to into the interrupt status registers for each
of these 7 interrupts bits, and that is done by looking at the 7 32-bits
words after the MSPI block (the "intr_status_regs") resource

So with the exception of the separate L1 vs. multiple L1 interrupt
sources for the MSPI+BMSPI, everything is fairly consistent, and this is
why the driver needs to touch several blocks.

> 
>> It is not exclusively an interrupt controller, there are other bits in
>> there are do not functionally belong into an interrupt controller driver
>> per-se, things like a clock enable, arbiter control and a random bit to
>> control MSPI flush behavior.
> 
>> Oh, and please don't tell me regmap is the solution here if we need to
>> control both the interrupt-related bits and the other bits within this
>> register.
> 
> That does sound system controllerish if those bits do need to be
> managed.  Are we sure future designs won't just integrate this into the
> main system controller?

No of course we cannot be 100% sure, HW design teams do whatever the
heck they want unles you give them feedback, but so far they have been
very consistent in how they integrated SPI on 3 different generations of
SoCs, and since the SW people there are hunting them down based on
consistency, we should be confident.

> 
>> Considering that this block aggregates interrupt enable bits, but not
>> just, there is no reason for this block to change over time, and clearly
>> this won't be handled via a generic interrupt controller driver either.
> 
> There must be *some* logic behind the way the hardware has been
> structured, and right now the code just isn't making any of this
> apparent which makes it look like it needs refactoring.

Hopefully what I just described here helps seeing what is common, and
what is specific to a given SoC, I don't mind us updating the binding to
reflec that information provided that this helps.

Now, as to whether it makes sense to model the IDM enable/disable
(intr_regs resource) and the 7 32-bits interrupt status/acknowledge
words at the end of the MSPI+BSPI block (intr_status_regs resource) as
an interrupt controller makes sense or not, it is kind of hard to say,
because really the IDM IO_CONTROL aggregates more than just interrupt
enable/disable bits here, but the overall ownership of this IDM
IO_CONTROL is clear and it belongs to the SPI function of the system.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
