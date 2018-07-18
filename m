From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/5] spi: dw: fix possible race condition
Date: Wed, 18 Jul 2018 13:33:39 +0300
Message-ID: <CAHp75VfvP7s-ud0XRUfESjTNRdbaZH_qKRpXbkCzKqp8j5e6kg@mail.gmail.com>
References: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
 <20180717142314.32337-2-alexandre.belloni@bootlin.com> <CAHp75Vc4SrMXznc6PSrO2Lfrc3gspu_g1QYjuFDWT9-J=C+bjw@mail.gmail.com>
 <CAHp75VfRS_gSv6x22M1TiTariUftF04sLyd84dQpxudOmT0s7w@mail.gmail.com>
 <20180717214212.GE3211@piout.net> <CAHp75VdEkQ=AC8xUBno7qp0E+cXqwq03WOtVB3sX+Z6zthDJSw@mail.gmail.com>
 <20180717221301.GF3211@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717221301.GF3211@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 18, 2018 at 1:13 AM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 18/07/2018 00:54:21+0300, Andy Shevchenko wrote:
>> On Wed, Jul 18, 2018 at 12:42 AM, Alexandre Belloni
>> <alexandre.belloni@bootlin.com> wrote:
>> > On 18/07/2018 00:30:49+0300, Andy Shevchenko wrote:

>> > Well, I'm not sure how far this can be backported. It also seems nobody
>> > ever hit that while our hardware will hit it at every boot.

>> No-one enabled CONFIG_DEBUG_SHIRQ?

> Nope, this is a real HW IRQ. I meant find out up to when it can be
> sanely backported.

I meant that before your case no-one tested with that option enabled
which will behave like you describe (IRQ gets fired as soon as being
registered).

-- 
With Best Regards,
Andy Shevchenko
