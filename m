From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: reinitialize transfer
	parameters for every message
Date: Fri, 2 Jul 2010 10:00:00 -0500
Message-ID: <AANLkTilUz8FtBpyFtibPJFTjsVgr6YxwvSgo1N_17Mw-@mail.gmail.com>
References: <AANLkTil9nKF_tDNVl8cGliBbP-w0iQsLNxuKK6maYiuC@mail.gmail.com>
	<514863.1062.qm@web180315.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Vitaly Wool <vwool-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <514863.1062.qm-4JhmkcZgSkl+W+z1sZEpBPu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 27, 2010 at 3:32 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>> > This patch fixes the setup_transfer logic to account for the case where
>> > multiple messages to different SPI devices are queued simultaneously.
>
> Make that "sequentially"; queues are FIFO,
> not parallel!!

What I was saying was that there are multiple messages in the queue at
the same time.  In other words, the loop:

while (!list_empty(&bitbang->queue)) {
...
}

will be executed multiple times before bitbang_work exits.


> ... like it =A0was already supposed to be doing; but
> you say it wasn't (I've nt yet evaluated that):

I think what your original patch fixed was if there were two SPI
devices in the system, and they were used alternately, the parameters
for one device would be used for the other.  So you added the do_setup
initialization to make sure that the parameters were reset every time
bitbang_work was called.  For the most part that solution solves the
problem.  However, if messages to different devices are in the queue
and bitbang_work stays in the message loop and doesn't exit, you end
up with the same problem where the parameters for one device are used
for the next device.  That's what I'm trying to solve.

>> > With the current logic, the second message in the queue will end up
>> > using the transfer parameters for the previous message in the queue.
>
> ISTR it was supposed to change only the
> values which were incorrect. =A0(Which were
> of course all incorrect initially, but for
> later transfers might often be OK.

Yes, I think the transfer loop (processing transfers for a single
message) is fine.  setup_transfer() gets run again only if the
parameters changed for a particular transfer within a message.  My
patch was dealing with reinitialization in the message loop, since
messages can be to different devices.

>> It seems to me that with this change that always
>> forces setup_transfer() to be run at the beginning of a message,
>> that this
>> setup_transfer() call becomes completely superfluous and
>> can be
>> removed.
>
> Surely it's a useful abstraction, regardless?
> And in any case it can be overridden by the
> lower-level code to do things like write to
> hardware registers ... I can't see removing it.
>
> =A0 Why bother setting up the default parameters
>> for the last
>> device when all transfers to that device have completed?

I think I understand what you're saying now.  I believe you are
correct - the final setup_transfer() doesn't really do anything
because we are going to call setup_transfer() again when the next
message is processed.  I can remove that.

> (have they?)
> If that chip is still selected (because the
> cs_change for the last transfer of the last
> message said to do so) that's correct ...
>
>
>> =A0 However, I'd like to know
>> more about the
>> original intent of this code.=A0 Is this just and
>> optimization, or am I
>> missing something?
>>
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do_setup =3D 0;

Originally  do_setup was set to zero after processing the first
message in the queue.  That worked fine as long as all messages in the
queue were for the same device.  But if the next message is for a
different device then setup_transfer doesn't get called.  I moved the
do_setup=3D0 to fix this problem, but now that you point it out, I think
it doesn't provide the exact same behavior as before.  I'll resubmit
the patch with a fix that keeps the same behavior.

> Looks like "do_setup" semantics got
> swapped around at some point too..
> that zero case isn't commented as
> either init/-1 or override/1 ...

Yes, that is true.  do_setup was changed to be either true or false.
However, I'm going to resubmit the patch with the init/override
semantics restored.

>> >
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* normally deactivate
>> chipselect ... unless no error and
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * cs_change has hinted that
>> the next message will probably
>
> I recall trying to be sure this code got those
> cs_change semantics correct, and having a few
> messy issues associated with that ... this code
> should be the semantic reference for the whole
> SPI messaging behavior. =A0Maybe some bugs crept
> in; this specific behavior can be confusing.

I believe the cs_change code is correct and I didn't make any changes to th=
at.

>> However, looking at this code deeper, I wonder if there is
>> another
>> bug.=A0 Let me add the lines that finish the above
>> comment and
>> manipulate the cs:
>>
>> >
>> =A0=A0=A0* be for this chip too.
>
>
> Yeah, truncated comment should get fixed
>
>> >
>> =A0=A0=A0*/
>> >
>> if (!(status =3D=3D 0 && cs_change)) {
>> >
>> =A0 =A0 =A0 =A0 ndelay(nsecs);
>> >
>> =A0 =A0 =A0 =A0 bitbang->chipselect(spi,
>> BITBANG_CS_INACTIVE);
>> >
>> =A0 =A0 =A0 =A0 ndelay(nsecs);
>> >
>> }
>>
>> It seems that it is trying to provide the option for
>> leaving the CS
>> line active at the end of a transfer.
>
> Yes, though it's not done if the message
> itself triggered an error
>
>
>
> =A0 However, I
>> don't see any code
>> that verifies that when cs_change =3D=3D 0 at the end of a
>> message, that
>> the next message will definitely be for the same
>> device.
>
> Not required. =A0That's a hint. =A0If the hint is
> incorrect, the driver should recover and then
> activate the correct chipselect.
>
>
>
> =A0 It could be
>> that the CS won't get explicitly deactivated before a
>> message for
>> another device begins.
>
> ISTR coding it so the chip getting activated
> was always the right one
>
>> Granted, ->chipselect() will still get called regardless
>> to set the
>> new device chip select, which /should/ implicitly clear the
>> previous
>> chip select, but it won't get exactly the same behaviour
>
> No, the request was to avoid toggling the
> chipselect line, which can have side effects.
> Calling chipselect() generally toggles it, so
> the device would do something that's potentially
> undesirable. =A0Ergo, avoid chipselect() there.

As I mentioned above, I believe the chip select logic is correct.  It
is possible that a chip select for one device will remain active at
the end of a message, and that the next message will be for a new
device.  In that case, the chip select logic is required to deselect
the previous device and select the new device.

I will resubmit the patch again given your comments.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
