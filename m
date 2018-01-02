From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Tue, 2 Jan 2018 16:13:43 +0100
Message-ID: <CAK8P3a1Jw+oQ6Z_DG6uDFYpqboRoki+4MyXGScuQJ-__-nUE6A@mail.gmail.com>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
 <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com> <e11e7a46-d038-4299-6781-525feda8f851@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Joel Stanley <joel@jms.id.au>, gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e11e7a46-d038-4299-6781-525feda8f851@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On 2017-12-31 07:10, Arnd Bergmann wrote:
> > On Fri, Dec 29, 2017 at 2:53 AM, Haiyue Wang
> > <haiyue.wang@linux.intel.com> wrote:
> >> When PCH works under eSPI mode, the PMC (Power Management Controller) in
> >> PCH is waiting for SUS_ACK from BMC after it alerts SUS_WARN. It is in
> >> dead loop if no SUS_ACK assert. This is the basic requirement for the BMC
> >> works as eSPI slave.
> >>
> >> Also for the host power on / off actions, from BMC side, the following VW
> >> (Virtual Wire) messages are done in firmware:
> >> 1. SLAVE_BOOT_LOAD_DONE / SLAVE_BOOT_LOAD_STATUS
> >> 2. SUS_ACK
> >> 3. OOB_RESET_ACK
> >> 4. HOST_RESET_ACK
> > I have not looked at the driver contents yet, but I'm adding the SPI
> > maintainer and
> > mailing list to Cc here for further discussion. Can you clarify how
> > the eSPI slave
> > mode relates to SPI slaves that we already support? I was under the impression
> > that the difference between SPI and eSPI is mainly on the master side, but that
> > any SPI slave can also act as an eSPI slave. Would this driver fit into the SPI
> > slave framework, possibly with some extensions to the generic abstraction?
> In simple word, the eSPI uses the SPI interface pin definition, but it
> will replace Low Pin Count (LPC)
> interface. From its name, sure, it will confuse you! ;-)

I know what eSPI is meant for, and understand the basic idea of the
protocol, but I'm not familiar with the Apeed slave hardware
implementation.

> > It also seems rather inflexible to have a single driver that is responsible both
> > for the transport (eSPI register level interface for ASPEED) and the high-level
> > protocol (talking to an Intel PCH), since either half of the work could be
> > done elsewhere, using either a different eSPI slave implementation, or
> > a different
> > host architecture)
> Yes, eSPI has the architecture such as transaction layer, link Layer;
> all of it is about the **silicon**
> design. That's why I put the driver under /misc directory, not /spi
> directory.

I don't see any requirement in the eSPI spec for the upper layers to
be implemented in hardware. Obviously an x86 host such as Intel's
PCH would implement the host interface using PIO,  and MMIO
accesses that are compatible with ISA and LPC, as this is the motivation
behind the specification, but an ARM server that wants to use eSPI
based peripherals could choose to implement it just as well using
a traditional SPI master hardware, some GPIOs (reset and alert)
and a (driver independent) software implementation of the transaction
and link layers.

On the slave side, it seems that aspeed have implemented the
virtual wires partially in hardware and require a driver like the one
you wrote to reply to some of the wires being accessed by the host,
but again it seems plausible that this could be implemented in another
BMC using a generic SPI slave and a transaction layer written
entirely in software.

Your driver does not handle the other channels (smbus, mmio, spinor)
at the moment at all, can you provide some information how they
are implemented in the ast2500? Are those handled completely
in hardware (I assume this is the case for spinor at least), or do they
require help from a driver, either this one or a separate one?

       Arnd
