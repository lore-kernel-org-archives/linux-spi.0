From: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 4/4] powerpc/mpc5200: Add
	mpc5200-spi (non-PSC) device driver
Date: Fri, 25 Jul 2008 22:45:54 -0400
Message-ID: <fa686aa40807251945t26a1656ep7a57ca71faa096c4@mail.gmail.com>
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073326.8485.99210.stgit@trillian.secretlab.ca>
	<1217009954.13539.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
To: "Daniel Walker" <dwalker-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1217009954.13539.23.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

On Fri, Jul 25, 2008 at 2:19 PM, Daniel Walker <dwalker-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org> wrote:
> On Fri, 2008-07-25 at 03:33 -0400, Grant Likely wrote:
>
>> +     if (status && (irq != NO_IRQ))
>> +             dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
>> +                     status);
>> +
>> +     /* Check if there is another transfer waiting */
>> +     if (list_empty(&ms->queue))
>> +             return FSM_STOP;
>
> I don't think doing list_empty outside the critical section is totally
> safe.. You might want to move it down inside the spin_lock() section.

This should be fine.  This is the only place where items are dequeued,
and it will only ever be called from the ISR or the work queue.  The
work queue and IRQ will never be active at the same time (I'll add a
comment to the fact).  It also looks like list_empty is perfectly safe
to call without the protection of a spin lock (but somebody correct me
if I'm out to lunch).  It doesn't dereference any of the pointers in
the list_head structure.

>
>> +     /* Get the next message */
>> +     spin_lock(&ms->lock);
>
> The part that's a little confusing here is that the interrupt can
> actually activate the workqueue .. So I'm wondering if maybe you could
> have this interrupt driven any workqueue driven at the same time? If you
> could then you would need the above to be
> spin_lock_irq/spin_lock_irqsave ..

Ditto here, since the irq and workqueue are not enabled at the same
time there is no worry about collision.

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
