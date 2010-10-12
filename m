From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Assert CS, wait for IRQ, write data sequence
Date: Tue, 12 Oct 2010 10:34:58 -0600
Message-ID: <AANLkTi=PfdvuGrLth6wnptMvGDb47qQv4Dec4FZb2oxU@mail.gmail.com>
References: <201010061649.45237.sentinelofsetch@gmail.com>
	<201010111922.23952.sentinelofsetch@gmail.com>
	<AANLkTi=sognho1_nuZw2xJmOTXQ4MMudVwktX6CniM+w@mail.gmail.com>
	<201010121922.36420.sentinelofsetch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sergii Kovalchuk <sentinelofsetch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201010121922.36420.sentinelofsetch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 12, 2010 at 10:22 AM, Sergii Kovalchuk
<sentinelofsetch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tuesday 12 October 2010 03:51:10 Jassi Brar wrote:
>> On Tue, Oct 12, 2010 at 1:22 AM, Sergii Kovalchuk
>>
>> <sentinelofsetch-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > On Thursday 07 October 2010 19:36:18 Grant Likely wrote:
>> >> On Wed, Oct 6, 2010 at 7:49 AM, Sergii Kovalchuk
>> >>
>> >> > I'm implementing an SPI protocol driver for TI WL12xx combo chip.
>> >> > According to the spec, for write transaction I should complete the
>> >> > following sequence:
>> >> >
>> >> > 1. Assert CS
>> >> > 2. Wait until chip will trigger IRQ
>> >> > 3. Write data
>> >> >
>> >> > Looking at spi_transfer structure I wondering, how I can implement
>> >> > such logic - there is no explicit ways to implement "wait for an
>> >> > event" within single spi_message processing.
>> >> >
>> >> > As current workarround I use a simple delay in 5 us, but for sleep
>> >> > states it might be not sufficient, since wake-up time are ususally
>> >> > greater.
>> >>
>> >> Wow. =A0That's nasty. =A0The SPI layer really doesn't have a mechanis=
m for
>> >> handling that. =A0What you *could* do is lock the spi bus; assert CS
>> >> manually; wait for the irq, and then issue the transfer. =A0Not exact=
ly
>> >> pretty, but it would work within the existing infrastructure.
>> >>
>> >> g.
>> >
>> > Yes, seems to be nasty. This is what I'm doing now - locking the bus a=
nd
>> > waiting for IRQ, but this is really ugly. Just wondered, if there is s=
ome
>> > hidden way.
>> >
>> > Not sure, if it more or less common situation. If so, may be it will be
>> > worth to extend spi_tranfer to handle "timed wait for IRQ/event" in so=
me
>> > kind of busy loop or completion - depending of context?
>>
>> By constraints of your bus controller, you can't possibly do anything
>> more useful than
>> waiting 'decently'. After all, only one CS can be active at any time
>> on the bus and
>> your h/w expects that while it prepares to send/recv data.
>> Or am I being naive?
>
> Almost certainly, there is no way to do something more useful. If I can
> manually assert CS (and prevent controller from serving others), then wai=
t for
> IRQ, continue transfer and manually deassert CS (and unlock controller) -=
 it
> will work. But this moves some controller functionality into protocol lay=
er
> and probably needs some "improuvements" into controller driver - to lock =
it.

There is a new API for exclusively locking the SPI bus.  Search for
spi_bus_lock and spi_bus_unlock in Linus' current tree.  It should do
what you need.  You'll still need to manually assert CS, and make sure
that CS doesn't toggle when the transfer is initiated, but otherwise
it should be good.  The best thing might be to manage the CS as a
simple gpio under the control of your driver and not let the bus touch
it at all.  As long as your driver holds the bus lock it should all be
okay.

g.

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
