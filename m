From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [andriy.shevchenko@linux.intel.com: Re: [PATCH] spi: dw-mmio: add
 MSCC Jaguar2 support]
Date: Wed, 29 Aug 2018 19:52:54 +0300
Message-ID: <CAHp75VeUF7ww7cNy0qHqFSp7bA65Ln3qj_U9AC0UNCX4FRrutg@mail.gmail.com>
References: <20180829150955.GB7459@smile.fi.intel.com> <20180829151501.GE27808@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        allan.nielsen@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180829151501.GE27808@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 29, 2018 at 6:16 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 29, 2018 at 06:09:55PM +0300, Andy Shevchenko wrote:
> > ----- Forwarded message from Andy Shevchenko <andriy.shevchenko@linux.intel.com> -----
> >
> > Date: Wed, 29 Aug 2018 18:08:31 +0300
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Subject: Re: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
> > User-Agent: Mutt/1.10.1 (2018-07-13)
> >
> > On Wed, Aug 29, 2018 at 02:45:48PM +0200, Alexandre Belloni wrote:
> > > Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
> > > layout than the Ocelot one. Handle that while keeping most of the code
> > > common.
> >
> > > -#define OCELOT_IF_SI_OWNER_MASK                    GENMASK(5, 4)
> >
> > > +                      0x3 << if_si_owner_offset,
> >
> > Perhaps,
> >
> > #define MSCC_IF_SI_OWNER_MASK         GENMASK(1, 0)
>
> Oops, sorry - that seems to have been eaten somewhere.  :(

Nothing to sorry about, I'm in a process on move to mutt, so, I
mispushed 'r' (Reply) instead of 'g' (Group Reply).
I just forwarded the first one.

-- 
With Best Regards,
Andy Shevchenko
