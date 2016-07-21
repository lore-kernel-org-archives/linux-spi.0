From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Thu, 21 Jul 2016 15:06:16 -0700
Message-ID: <583d6ec8-b367-b53a-7d9e-1d7ee06004c0@gmail.com>
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
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

Mark, would you oppose to a driver structure that looks like the
Broadcom NAND driver under drivers/mtd/nand/brcmnand/, where we have
something like this:

- the core driver only deals with individual interrupt lines which are
available in the original version of the IP block as integrated on
Set-top-box/Cable Modem chips

- the core driver allows for callbacks to perform additional interupt
work when that is required for the iProc (Northstar, Northstar Plus,
Northstar 2) and DSL SoCs where we have additional logic to
enable/disable/acknowledge interrupt lines

We came up with this design for the NAND controller driver pretty much
for the same reasons that the NAND controller originally came from the
STB/CM group and was later adopted by the iProc SoCs and integrated in a
way that made the number of layout of interrupts and control register
different...

Thanks
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
