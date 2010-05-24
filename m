From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: reinitialize transfer
	parameters for each message
Date: Mon, 24 May 2010 10:26:16 -0500
Message-ID: <AANLkTikLrP73tkD_ZJVV60LgB8_iGZDm2kIm5oXEELRs@mail.gmail.com>
References: <1268175375-13970-1-git-send-email-bniebuhr@efjohnson.com>
	<AANLkTimZ06_xg77TXLlRfWAPnVAEEcOwnN4u6XpEzAQ1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimZ06_xg77TXLlRfWAPnVAEEcOwnN4u6XpEzAQ1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, May 22, 2010 at 4:27 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
> On Tue, Mar 9, 2010 at 4:56 PM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> It is possible that multiple messages for different SPI devices could
>> be queued. =A0The transfer parameters are currently only set for the
>> first message in the bitbang work queue. =A0If subsequent messages in
>> the queue are for devices that do not have compatible transfer
>> parameters (speed, phase, polarity, etc.) then those transfers will fail.
>>
>> The fix is to reinitialize the transfer parameters for each message
>> rather than only once on the first message.
>>
>> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
>> ---
>> =A0drivers/spi/spi_bitbang.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
>> index f1db395..1e9247a 100644
>> --- a/drivers/spi/spi_bitbang.c
>> +++ b/drivers/spi/spi_bitbang.c
>> @@ -258,7 +258,6 @@ static void bitbang_work(struct work_struct *work)
>> =A0 =A0 =A0 =A0struct spi_bitbang =A0 =A0 =A0*bitbang =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0container_of(work, struct spi_bitbang, wo=
rk);
>> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 flags;
>> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setup =3D -=
1;
>> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*setup_trans=
fer)(struct spi_device *,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct spi_transfer *);
>>
>> @@ -274,6 +273,7 @@ static void bitbang_work(struct work_struct *work)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t=
mp;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0c=
s_change;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 status;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 do_setup =3D -1;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m =3D container_of(bitbang->queue.next, s=
truct spi_message,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue);
>
> This doesn't look right. =A0Effectively moving the do_setup
> initialization inside the loop completely short circuits the logic
> around setup_transfer() calls. =A0In some cases this change will cause
> setup_transfer() to get called twice back to back with no transfer in
> between (after the last transfer if do_setup =3D=3D 1).

That is what I intended to happen - in fact that is the whole point of
this fix :-)  Here's a verbal description to help clarify what the
existing setup_transfer logic was trying to do:  When transfering a
message, setup_transfer() has to be called at least once to initialize
the controller with the parameters for that device.  Furthermore, each
transfer that makes up that message can override the default transfer
speed or word size, in which case we need to call setup_transfer()
again for each transfer.  Finally, if one of the transfers did
override the default transfer speed or word size, we need to restore
the default before handling the next message.  So the idea is that if
setup_transfer() was called to override the defaults, it has to be
called again before the next message to restore the defaults.  So if
you have two messages back-to-back that have transfers that use
non-default parameters, then setup_transfer() will be called multiple
times in a row with no transfer in between.  That is expected.

The problem with the way the driver is written is that it does not
handle the case properly where multiple messages to different devices
on the same controller have been queued.  Consider the following
example (this is a simple example where we don't even worry about
overrides):

1. Two messages have been queued in bitbang->queue.  These messages
are to two different devices on the same controller, and each uses
different settings (speed, polarity, phase, etc.).

2. When entering bitbang_work, do_setup is set to -1 indicating that
an init call to setup_transfer() is required.  setup_transfer() is
called for the first message, setting the parameters correctly for the
first device.

3. do_setup is set to 0.

4. We come back in the second loop for the second message.  Since
do_setup is zero, we don't call setup_transfer().  However the
controller is set up for the previous device, not the current device.
So when the transfer is initiated the wrong parameters are used and
the transfer fails.

The only time this becomes an issue is if you have multiple SPI
devices, with different transfer parameters, sharing the same
controller, with the chance for a message to be sent to each more or
less simultaneously.  I don't know that that situation comes up very
often, which is why people may have not seen this issue before.

> If the logic is wrong, then this patch should pull out and fix the bad
> logic instead instead of force-overriding it.

I don't think the logic is wrong, it just doesn't correctly take into
account the fact that two messages to two different devices could be
queued simultaneously.  I don't feel that this patch is overriding the
logic at all.  In fact, I think this patch corrects the code to obtain
the result that the logic intends.

I think the issue you may have is that if there are multiple messages
queued for the _same_ device, then setup_transfer() may be called
unnecessarily in between those messages.  You are correct that this
may occur, but I think my solution is still the cleanest option.
Here's why:

- I would imagine that the case where two messages to the same device
are sent back-to-back does not occur all that often (i.e. one would
expect that most of the time the driver is initiating a request that
needs to resolved before the next request is sent).

- Therefore when there are multiple messages in bitbang->queue, they
will likely be to different devices

- For those cases where two messages to the same device are sent
back-to-back, one message would likely complete before the other made
it into the queue, meaning bitbang_work() be called multiple times, in
which case setup_transfer() would be called in between the messages
anyway.

- The only other option for solving this problem involves adding more
logic for do_setup.  Namely, adding a variable that keeps track of
which SPI device the last message was sent to.  Then, if the next
message in the queue is not to the same device, the code would have to
set do_setup so that setup_transfer will be called before transferring
the second message.  In my opinion the setup_transfer() logic is
complicated enough without adding this new case.

So, in summary, not reinitializing do_setup for each message is wrong.
 My solution is to reinitialize it on every message to ensure
correctness.  I could add extra logic to only reinitialize do_setup
when the SPI device is different for consecutive messages, but I
thought it probably was not saving much in terms of performance and it
makes code that's already hard to follow even harder to follow.

Thoughts?

Brian

---------------------------------------------------------------------------=
---
