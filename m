From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
Date: Tue, 17 Jul 2018 23:42:12 +0200
Message-ID: <20180717214212.GE3211@piout.net>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com>
 <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:
> On Wed, Jul 18, 2018 at 12:30 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jul 17, 2018 at 5:23 PM, Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Shouldn't it have a Fixes tag?
> 

Well, I'm not sure how far this can be backported. It also seems nobody
ever hit that while our hardware will hit it at every boot.

I'll try to find out.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
