From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Wed, 26 Aug 2015 10:13:12 +0100
Message-ID: <20150826091312.GA19411@ck-lbox>
References: <CAKor6Te-DSDxx711-EQi=fw46nNPGnQNqhj-+6upBxhOOp5XvA@mail.gmail.com>
 <20150820115845.GF30005@lahna.fi.intel.com>
 <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
 <20150821074310.GM30005@lahna.fi.intel.com>
 <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
 <20150824085140.GA5647@ck-lbox>
 <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
 <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 Daniel Mack <daniel@zonque.org>, Robert
 Jarzmik <robert.jarzmik@free.fr>, dan.carpenter@oracle.com
To: Christian Hartmann <cornogle@googlemail.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 26, 2015 at 10:58:06AM +0200, Christian Hartmann wrote:
> Hi at all,
> 
> 
> the current logs shows me, that something else is missing here.
> The spi irq is one of the issues I will try to solve today
> 
> Looking at the read_regmap() where it reads its device id,
> I do not understand why it gots only an ID of 0xffff !

I would probably focus on getting the device ID to read back
first. The interrupts aren't that important until you can talk to
the device and the interrupt setup won't have any effect on being
able to talk to the device.

> 
> I have (silly or not), added a case for 0xffff in the next switch
> statements but anyway this seems not okay.
> I do not know what else (other than the wrong or missing spi irq,
> which is currently only -1)

Yeah adding a case for 0xffff probably won't help much as this
likely means that the device isn't responding at all when you are
talking to it, so you can't really do anything meaningful when
you get past reading the ID register anyway.

Basically to be able to talk to the device you need the following
things:

 1) The supplies need to be applied.
 2) The device needs to be out of reset.
 3) The device needs to have the LDO enabled.
 4) The chip select needs to be active.

It seems very likely that 1) is already taken care of, so I
probalby won't spend too much time worrying about that. It looks
like we are getting a valid GPIO for the reset (2) and LDOENA (3),
so it feels like those are probably ok. I guess this leaves the
SPI config as the next place to investigate, are there other
devices on the SPI that you can talk to that might at least
verify the SPI is working? Also might be worth trying to look at
how the chip selects are done perhaps that is not happening for
some reason?

Thanks,
Charles
