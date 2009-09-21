From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/2] spi: new SPI bus lock/unlock functions
Date: Mon, 21 Sep 2009 09:36:25 -0400
Message-ID: <8bd0f97a0909210636h655ba305sfef099b0f20a8176@mail.gmail.com>
References: <1253224997-7422-1-git-send-email-vapier@gentoo.org>
	<20090918142911.2d0c4408.akpm@linux-foundation.org> <1253514780.3925.36.camel@adam-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	cooloney@kernel.org
To: Li Yi <yi.li@analog.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756192AbZIUODm@vger.kernel.org>
In-Reply-To: <1253514780.3925.36.camel@adam-desktop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 21, 2009 at 02:33, Li Yi wrote:
> On Fri, 2009-09-18 at 14:29 -0700, Andrew Morton wrote:
>> On Thu, 17 Sep 2009 18:03:16 -0400
>> Mike Frysinger <vapier@gentoo.org> wrote:
>>
>> > From: Yi Li <yi.li@analog.com>
>> >
>> > For some MMC cards over SPI bus, it needs to lock the SPI bus for =
its own
>> > use. =C2=A0The SPI transfer must not be interrupted by other SPI d=
evices that
>> > share the SPI bus with SPI MMC card.
>> >
>> > This patch introduces 2 APIs for SPI bus locking operation.
>> >
>> > Signed-off-by: Yi Li <yi.li@analog.com>
>> > Signed-off-by: Bryan Wu <cooloney@kernel.org>
>> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> > ---
>> > Andrew: we've posted these in the past with no response. =C2=A0cou=
ld you pick
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 them up please ?
>> >
>> > =C2=A0drivers/spi/spi.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 48 +++++++++=
++++++++++++++++++++++++++++++++++++++
>> > =C2=A0include/linux/spi/spi.h | =C2=A0 =C2=A07 ++++++
>> > =C2=A02 files changed, 55 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> > index 70845cc..b82b8ad 100644
>> > --- a/drivers/spi/spi.c
>> > +++ b/drivers/spi/spi.c
>> > @@ -653,6 +653,54 @@ static void spi_complete(void *arg)
>> > =C2=A0}
>> >
>> > =C2=A0/**
>> > + * spi_lock_bus - lock SPI bus for exclusive access
>> > + * @spi: device which want to lock the bus
>> > + * Context: any
>> > + *
>> > + * Once the caller owns exclusive access to the SPI bus,
>> > + * only messages for this device will be transferred.
>> > + * Messages for other devices are queued but not transferred unti=
l
>> > + * the bus owner unlock the bus.
>> > + *
>> > + * The caller may call spi_lock_bus() before spi_sync() or spi_as=
ync().
>> > + * So this call may be used in irq and other contexts which can't=
 sleep,
>> > + * as well as from task contexts which can sleep.
>>
>> Hence spi_lock_bus() basically has to use a spinning lock?
>>
>> So code which has called spi_lock_bus() cannot sleep until it calls
>> spi_unlock_bus()?
>>
>> That's worth mentioning in the description.
>>
> Code called spi_lock_bus() _can_ sleep. This is mentioned in the
> comments.

should add might_sleep() to the common spi_lock_bus() function then.
-mike
