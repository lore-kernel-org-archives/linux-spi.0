From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: spi_lock_bus and
	spi_unlock_bus
Date: Wed, 17 Feb 2010 06:30:51 -0700
Message-ID: <fa686aa41002170530i2ae007c2ia4f2ad185dfd2713@mail.gmail.com>
References: <20100216204450.e043eed8.eschwab@online.de>
	<20100216205720.ebe949a1.eschwab@online.de>
	<fa686aa41002161243y6e24e439yff54a28cbe295de3@mail.gmail.com>
	<552DB282258F46CE995A09EF352B1094@pces>
	<fa686aa41002162032l2a2bc065t1f53d7b79760b2dd@mail.gmail.com>
	<CA3825EF38754795BC8264175475E1F0@pces>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <mail-3FdAPXqljGQisWB6T/0fQA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA3825EF38754795BC8264175475E1F0@pces>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 17, 2010 at 12:35 AM, Ernst Schwab <mail-3FdAPXqljGQisWB6T/0fQA@public.gmane.org> wrote:
> Grant Likely wrote:
>
>> It sounds like you're very worried about making changes to the core
>> code,
>
> Maybe...
>
>> In fact, now that I've had an evening to think about it, the solution
>> is even simpler than what I said earlier. =A0It requires 3 things to be
>> added to struct spi_master.
>> - 1 Mutex
>> - 1 spin lock
>> - 1 flag.
>
>> The mutex protects spi_async, and provides sleeping "for free"
>> The spinlock protects the atomic spi_sync call.
>
> Sound viable and good, but, in Documentation/spi/spi-summary we have:
>
> "
> The basic I/O primitive is spi_async(). =A0Async requests may be
> issued in any context (irq handler, task, etc) and completion
> is reported using a callback provided with the message.
> After any detected error, the chip is deselected and processing
> of that spi_message is aborted.
> "
>
> Is this compatible with a Mutex protecting spi_async?
> It seems to me, that spi_async must queue the SPI message
> immediately and return. The queue is implemented in the SPI master driver=
. I
> suppose that's why the blackfin bus locking pioneers chose to make the
> change in the SPI master driver.

No, sorry, I made a mistake and got the functions backwards when I was
writing up my description.  What I meant to say is:

spi_sync() is protected by a mutex because it can sleep
spi_async() needs to be protected with a flag and a spinlock because
it can be called atomically and must not sleep

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
