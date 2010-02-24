From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2 V2] spi/mmc_spi: SPI bus locking
	API, using mutex
Date: Wed, 24 Feb 2010 13:32:43 -0700
Message-ID: <fa686aa41002241232x6b6d92fci73ce7597c6e38b0@mail.gmail.com>
References: <20100218124425.599c4d76.eschwab@online.de>
	<20100218131057.40f9e623.eschwab@online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
To: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100218131057.40f9e623.eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hey Ernst.  Good patch, thank you.

The merge window is going to open any moment now, and this patch
hasn't had any linux-next exposure, so I'm not going to pick it up for
2.6.34.  Instead, I'll wait until after the merge window closes and
add it to my next branch so that it gets lots of exposure before the
2.6.35 merge window.  Since this is a pretty core change, I'd like to
have as much feedback and testing on it as possible before I commit to
pushing it into mainline.

Anyone who is following along and is interested, please test these two
patches and let me know if they work for you.

Ping me after Linus tags v2.6.34-rc1 to make sure I don't forget to
put it in my -next branch.

Some comments below...

On Thu, Feb 18, 2010 at 5:10 AM, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> wrote:
> I integrated your changes in V2, I hope I did not miss anything.
>
> On Wed, 17 Feb 2010 13:03:04 -0700
> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
>> > =A0extern int spi_setup(struct spi_device *spi);
>> > =A0extern int spi_async(struct spi_device *spi, struct spi_message *me=
ssage);
>> > +extern int
>> > +spi_async_locked(struct spi_device *spi, struct spi_message *message);
>>
>> Please keep return parameters and annotations on the same line as the
>> function name (makes grep results more useful). =A0You can break lines
>> between parameters.
>
> Hm, the prototype for spi_alloc_master in the same file let me assume,
> that this should be the style used in this header file. Normally, I
> wouldn't do a linebreak there, ever...

Yeah, things are inconsistent, but in this case both styles are
present in the file, and when grepping I find it more important to
have the annotations than the parameters immediately visable.

>
> Something more important:
>
> I have concerns on the use of the spin lock around the
> __spi_async() call, as Mike Frysinger already remarked.
>
> Why do we 'need' this spin lock:
> - by definition, spi_async can be called from any context
> =A0 =A0 =A0 =A0"
> =A0 =A0 =A0 =A0 * Context: any (irqs may be blocked, etc)
> =A0 =A0 =A0 =A0 *
> =A0 =A0 =A0 =A0 * This call may be used in_irq and other contexts which c=
an't sleep,
> =A0 =A0 =A0 =A0 * as well as from task contexts which can sleep.
> =A0 =A0 =A0 =A0"
> - we are not sure that spi_async isn't used reentrant (e.g. interrupt
> =A0service routine and normal context
> - __spi_async calls the master->transfer() function which is not required
> =A0to be reentrant (or is it?)

Um, I'm not sure I follow the argument.  spin locks are safe to obtain
in any context.  Mutexes are the ones that cannot be held at atomic
context.

The spin lock does more than just protect the bus_is_locked flag.  It
also prevent overlap between process and IRQ context running in the
relevant code.  Basically the spin_lock_irqsave() either defers all
IRQ processing in uniprocessor, or has other processors spin in SMP.
I think the spinlock should always be held when calling the bus
drivers ->transfer() hook.  That will also allow us to remove
driver-specific locking from the bus drivers.  Otherwise we've got an
inconsistent locking scheme which is asking for trouble down the road.

>
> But: This all is true for the original design, there seems to be no
> protection against accidental reentrant use of spi_async().

spi_async() is intended to be callable from atomic context so that IRQ
handers can trigger a new transfer without waiting around for it to
complete.  It is also totally valid for both process and IRQ contexts
to call spi_async() at the same time, which is exactly why the
spinlock should be required.

Hmmm.  Are you concerned about a code path where an spi_async() call
will call the bus driver, which will end up calling spi_async() on
itself?  I cannot think of a use case where that would be desirable.

g.


-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
