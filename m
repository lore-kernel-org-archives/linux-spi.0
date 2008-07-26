From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 4/4] powerpc/mpc5200: Add
	mpc5200-spi (non-PSC) device driver
Date: Sat, 26 Jul 2008 01:20:06 -0400
Message-ID: <fa686aa40807252220x5b224e91ucca467ff6eecc0ae@mail.gmail.com>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073326.8485.99210.stgit@trillian.secretlab.ca>
	<1217009954.13539.23.camel@localhost.localdomain>
	<fa686aa40807251945t26a1656ep7a57ca71faa096c4@mail.gmail.com>
	<1217047659.3970.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: "Daniel Walker" <dwalker-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1217047659.3970.14.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jul 26, 2008 at 12:47 AM, Daniel Walker <dwalker-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> wrote:
> On Fri, 2008-07-25 at 22:45 -0400, Grant Likely wrote:
>> On Fri, Jul 25, 2008 at 2:19 PM, Daniel Walker <dwalker-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> wrote:
>> > On Fri, 2008-07-25 at 03:33 -0400, Grant Likely wrote:
>> >
>> >> +     if (status && (irq != NO_IRQ))
>> >> +             dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
>> >> +                     status);
>> >> +
>> >> +     /* Check if there is another transfer waiting */
>> >> +     if (list_empty(&ms->queue))
>> >> +             return FSM_STOP;
>> >
>> > I don't think doing list_empty outside the critical section is totally
>> > safe.. You might want to move it down inside the spin_lock() section.
>>
>> This should be fine.  This is the only place where items are dequeued,
>> and it will only ever be called from the ISR or the work queue.  The
>> work queue and IRQ will never be active at the same time (I'll add a
>> comment to the fact).  It also looks like list_empty is perfectly safe
>> to call without the protection of a spin lock (but somebody correct me
>> if I'm out to lunch).  It doesn't dereference any of the pointers in
>> the list_head structure.
>
> The list_empty wouldn't crash, but the result isn't necessarily
> accurate.

It doesn't need to be accurate because the spinlock is obtained before
actually trying to dequeue anything.  Even if it held the spinlock
there would still be uncertainty depending on which routine ran first.
 If this function ran first, then it's going to stop the state machine
regardless and the enqueue function will have to kick it off again
anyway.

But, I've taken a look at the code, and you're right, the spin lock
does need to be held while running the state machine because I do have
a case where the IRQ and workqueue could get executed at the same
time.  I'll fix it up.

>
>> >
>> >> +     /* Get the next message */
>> >> +     spin_lock(&ms->lock);
>> >
>> > The part that's a little confusing here is that the interrupt can
>> > actually activate the workqueue .. So I'm wondering if maybe you could
>> > have this interrupt driven any workqueue driven at the same time? If you
>> > could then you would need the above to be
>> > spin_lock_irq/spin_lock_irqsave ..
>>
>> Ditto here, since the irq and workqueue are not enabled at the same
>> time there is no worry about collision.
>
> Why are you waking up the work queue from inside the irq handler? You
> might also want to break out the handling from inside the irq handler
> and call that from the workqueue, instead of re-calling the irq handler
> function from the workqueue.. It's a little confusing from a context
> perspective.

Sure, I can rework that.  The irq handler would then just simply be a
straight call into the state machine runner.  I just dropped the
additional 4 lines of code for conciseness, but I can change it around
for clarity... actually, with the spin lock stuff above I need to do
this rework.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
