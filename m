From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: Add support for
	non-blocking synchronous transfers
Date: Sun, 1 Mar 2009 01:43:47 -0800
Message-ID: <200903010143.47425.david-b@pacbell.net>
References: <20090228081036.31964.80618.stgit@fedora.yogi>
	<200902281233.50612.david-b@pacbell.net>
	<49AA3DD6.4040807@openmoko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Balaji Rao <balajirrao-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
To: Andy Green <andy-4Bgg8jF3iZdWk0Htik3J/w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <49AA3DD6.4040807-4Bgg8jF3iZdWk0Htik3J/w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Saturday 28 February 2009, Andy Green wrote:
> | This sounds like a bad design. =A0How can you know that no other
> | transfers are going on ... or are queued in front of the transfer
> | you're requesting?
> |
> | You'd need to wait for all the other transfers to work their
> | way through the transfer queue. =A0There are *much* better things
> | to do in interrupt handlers.
> =

> In our case, the sync and async SPI things are mutually exclusive, you =


Come up with some new terminology for what you're proposing,
instead of trying to repurpose the existing terms.  The
spi_sync() and spi_async() calls already exist, and they
are *NOT* mutually exclusive.

I suggest you talk about "non-sleeping" calls, since that
seems to be close to what you're thinking about.  (Though
it does beg the question of why you're not using the async
calls, if sleeping makes trouble...)


> either talk to your thing with interrupt-lockout protected sync
> transfers entirely or use the existing API. =A0It can be enforced if
> that's the concern.

The API proposal is a generic one, and the reference
implementation has deep issues as I noted.  At the
level of data corruption.  How would that be "enforced"
generally?


> I think it's a little fast to call down the airstrike of "bad design"
> on being able to use bitbang SPI inside an ISR.

The way to access SPI inside an ISR is spi_async().
No exceptions for bitbang are necessary.

Neither you nor Balaji have mentioned any issue that
prevents using that.  Or, for that matter, that you
even tried using the interface as designed.  You're
defending something that -- so far -- is not defensible;
it introduces data corruption.  I'm not sure what else
to call it but "bad design".  Regardless, the key point
is to call your attention to the fact that you're doing
something quite wrong.  (The nonsensical $SUBJECT was
the first clue...)


> Clearly, adding this =

> ability does not replace the existing system and exists parallel but
> compatibly with it;

No, it's not compatible.  Start by answering the question
I asked above (quoted at the top of this email), and you'll
surely begin to understand.


> but the existing system cannot provide the same =

> capability as it stands.

Erm, the existing system is clearly self-compatible.
I don't think that word means what you think it means.  ;)


> With two lis302dl motion sensors in GTA02, =

> they can spam up to 800 interrupts a second that need servicing each
> with a 7-byte bitbang read.

Hmm, I'm looking at a schematic with a lis302dl hooked up
using I2C ... at 400 KHz max.  So those chips have useful
use cases that don't need much of a data rate at all.

Now, 800 IRQ/sec * 7 bytes * 8 bits/byte =3D=3D 44800 bits/sec,
which is easy to achieve.  At least, in drivers that are
written sensibly.  (Even if that's 45 Kbit/sec *each*...)


> The existing SPI setup in Linux does not =

> provide a way to deal with that in a CPU-friendly and low latency way
> (there's no FIFO in these devices either).

If you can't get 45 Kbit/second you're doing something
extremely odd.  I've bitbanged SPI at over 2 MHz on
ARM chips less than half the speed of your OpenMoko
hardware.


So to recap:  the $SUBJECT proposal has serious issues;
and simple math suggests that the performance issues you
are seeing are not fundamentally due to the code at or
below the layer being patched.

- Dave


---------------------------------------------------------------------------=
---
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
