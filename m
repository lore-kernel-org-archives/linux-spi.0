From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Thu, 28 Jul 2016 17:34:50 -0700
Message-ID: <e3a069ad-ca2b-7c12-bde1-5566f5fe24d3@gmail.com>
References: <20160622160726.GQ28202@sirena.org.uk>
 <CAKekbevYN3CLvqQs3stUXDFEMREMOJ0g4+w7Zsno1kV-ieYEiw@mail.gmail.com>
 <20160701160753.GX6247@sirena.org.uk>
 <CAC=U0a3WN9TGw7zwwP3qFf5MUsRteUcVLytFgjnP4zScZS0xXA@mail.gmail.com>
 <20160713111053.GG9976@sirena.org.uk> <5786B401.2050306@gmail.com>
 <20160713223638.GI9976@sirena.org.uk> <578EA695.1030909@gmail.com>
 <20160720112547.GE6509@sirena.org.uk> <578FD3D7.9030402@gmail.com>
 <20160728182803.GI11806@sirena.org.uk>
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
In-Reply-To: <20160728182803.GI11806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/28/2016 11:28 AM, Mark Brown wrote:
> On Wed, Jul 20, 2016 at 12:41:11PM -0700, Florian Fainelli wrote:
> 
>> Now, as to whether it makes sense to model the IDM enable/disable
>> (intr_regs resource) and the 7 32-bits interrupt status/acknowledge
>> words at the end of the MSPI+BSPI block (intr_status_regs resource) as
>> an interrupt controller makes sense or not, it is kind of hard to say,
>> because really the IDM IO_CONTROL aggregates more than just interrupt
>> enable/disable bits here, but the overall ownership of this IDM
>> IO_CONTROL is clear and it belongs to the SPI function of the system.
> 
> TBH if that's all it's doing then I'm surprised it's not simple to
> handle it with irq_setup_generic_chip() - have you looked at that at
> all?

The generic IRQ chip model assumes that the mask/unmask/ack logic will
operate against the same register base address, which won't be the case
for the NS/NSP/NS2 platforms where the mask/unmask is in one register
set (coined IDM), and the ack is in another one (actually 7 * 32-bits
words).

You would need to write a custom irq_chip implementation to suppor that
which is not a great fit because it is not dealing with just pure
interrupt enable/disable bits, but manages a 32-bits word of register
space which has other controls, and another set of 32-bits words which
functionally belongs in the SPI controller for interrupt statuses.

In that case, my personal preference is to abstract that within a
SoC-specific glue layer, ala brcmnand, where the SoC that needs this
glue has full control and clear ownership of this 32-bits word of
register space. This keeps the SoC-specific logic clean and separate,
reasonably well abstracted, while making the core SPI driver deal with
the ideal situation and not knowing how the SoC glues things together.

So yes, we actually did put some thought into this.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
