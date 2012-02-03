From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: create an optional message queueing
	infrastructure
Date: Thu, 2 Feb 2012 21:14:29 -0700
Message-ID: <CACxGe6uHRG4474PvQuUmrVYfojyy3rxTv_YGA5TjU6T-+hcVrg@mail.gmail.com>
References: <1328187599-12982-1-git-send-email-linus.walleij@stericsson.com>
	<20120202185247.GR15343@ponder.secretlab.ca>
	<20120202224709.GF3112@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120202224709.GF3112-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 2, 2012 at 3:47 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Thu, Feb 02, 2012 at 11:52:47AM -0700, Grant Likely wrote:
>
>> This looks really good. =A0In fact, can you think of any reason why we w=
ouldn't
>> force all spi drivers to use central queueing? =A0I don't see any advant=
age
>> in leaving the old mechanism in place other than to allow driver to tran=
sition
>> from the old API.
>
> Are any of the drivers capable of running from interrupt and which
> therefore don't need to use a thread at all?

There may be.  That should be easy to handle though.  The queue
definitely looks like something that should be shared by all drivers,
and maybe that can be the first patch in the series.  I can't think of
a single reason why any spi driver wouldn't want to have queuing
handled by the core.

As for the thread, perhaps it can be made optional simply by not
populating the pump_messages hook... but even then when a new message
is enqueued there needs to be a way for the core to kick the spi bus
driver so that it wakes up and processes the messages.  If
pump_messages isn't populated, then some other hook is needed.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Try before you buy =3D See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
