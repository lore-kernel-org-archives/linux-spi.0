From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi/xilinx: Cast ioread32/iowrite32 function pointers
Date: Thu, 29 Jan 2015 23:11:47 +0100
Message-ID: <2800334.5ezTSQFkNQ@wuerfel>
References: <1422543073-21895-1-git-send-email-ricardo.ribalda@gmail.com> <CAMuHMdX5CMH0Q5S_BBjb-F-kJfzkTS+sP9H-FDe_K_gFRxK7pw@mail.gmail.com> <CAPybu_3O3Rcq1Rvxvbpc-GOSs+VbO74_u+vfH+UtXjLAQjWLQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	Mark Brown <broonie@kernel.org>,
	=?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	linux-spi <linux-spi@vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPybu_3O3Rcq1Rvxvbpc-GOSs+VbO74_u+vfH+UtXjLAQjWLQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday 29 January 2015 17:39:08 Ricardo Ribalda Delgado wrote:
> > I think the definitions in include/asm-generic/iomap.h are actually wrong,
> > as they lack a const:
> >
> >     extern unsigned int ioread8(void __iomem *);
> >     extern unsigned int ioread16(void __iomem *);
> >     extern unsigned int ioread16be(void __iomem *);
> >     extern unsigned int ioread32(void __iomem *);
> >     extern unsigned int ioread32be(void __iomem *);
> >
> > Note that the definitions in include/asm-generic/io.h do have the const:
> >
> >     static inline u8 ioread8(const volatile void __iomem *addr)
> >     static inline u16 ioread16(const volatile void __iomem *addr)
> >     static inline u32 ioread32(const volatile void __iomem *addr)
> >     static inline u16 ioread16be(const volatile void __iomem *addr)
> >     static inline u32 ioread32be(const volatile void __iomem *addr)
> 
> 
> I think you are right: ioread/iowrite is poorly implemented in many arches 
> 
> Would you mind sending the patch for asm-generic/iomap ? Or you want
> me to do it.
> 

I think we don't need the 'volatile' keyword here. The main reason
we have it on readl() is to shut up the compiler when dealing with
ancient driver code that annotates iomem pointers as volatile.

This is generally considered a (minor) driver mistake though, and
modern drivers that for some reason use ioread*() typically don't
do that (or they get a warning).

	Arnd
