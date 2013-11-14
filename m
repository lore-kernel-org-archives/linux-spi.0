From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Thu, 14 Nov 2013 01:50:09 +0000
Message-ID: <20131114015009.GB26614@sirena.org.uk>
References: <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52823E73.503-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2013 at 03:42:59PM +0100, Martin Sperl wrote:

> This "chaining" is _obviously_ not possible with the transfer_one
> message BUS-master-API (or it would require some "ugly hacks" to
> make use of transfer_one_message API)

Meh, it doesn't seem that urgently different to be honest.  The basic
flow of interactions with the device is very much typical of SPI
controllers.

In any case while it's not entirely clearly explained here I *think* the
major thing that's being done differently here is that the register
writes to the controller are being done using DMA.  Is that the case?

That's certainly a bit of an innovation and I don't think it's actually
all that device specific - while reusing the same channel for things
other than the actual data transfer is a bit cute I can't see any
obvious reason why it shouldn't work and it's something that I'd expect
a great proportion of DMA controllers would be able to support.  The
delays are a bit dodgy for that but for untimed delays could probably be
implemented with dummy memcpy() type transfers easily enough.

I'd expect this to integrate nicely with the general stuff to split out
the pushing of transfers and configuration of transfers that I'd been
kicking around - transfer_one() is intended to be split into two for
this, one bit to configure the transfer and another bit to actually do
it.  The original idea was more around recognising and exploiting
scatter/gather patterns but pipelining the DMAs for configuration would
allow that to be extended a bit.

One thing that does concern me is the overhead of all the DMA work for
smaller transfers - once there's a queue built up it's more clearly
useful but without a queue it's not obvious that the effort is going to
be worth it.

> Well - as said I am wondering if the DMA engine can really can help
> - especially if you want to keep the "prepare" code fast. I am using
> dmapool for memory alloc/free, but I fear we would need to run 2 mallocs
> if I was using DMA-engine and more setup/tear-down overhead, as well
> as more code that needs to get executed to go via DMA-engine.

The big win from dmaengine is that it means that you don't need to
implement essentially the same DMA code in each and every driver, all
the DMA drivers end up with a uniform API.  Since by and by large the
process of mapping a SPI message for DMA is the same no matter what the
controller is this ends up being a win and we don't require each and
every master driver author to jump through the same hoops.

If it doesn't do what's desired we should fix it to make it better (same
as here).

> As said: I will keep it as is for now and first implement the full DMA
> chaining approach. then we can see how much the move to DMA-Engine
> is costing...

That's fine for experimentation but for an actual merged API I think it
does need to be generally applicable so that it's worth the effort for
client drivers to support it.

> not the prime "candidates" for the improvement in the first place.
> If they want to run with minimal latencies, they HAVE to run spi_async.
> Anything else is not very efficient as it requires several context
> switches by the way of the current design.

Well, the benefits of submitting things asynchronously are as much about
giving the stack something to play with and reducing turnaround time as
anything else - it means the stack can submit the next transfer to the
hardware before it tells the caller that the current one completed which
reduces the idle time on the bus and means that there's much more scope
for reducing needless context switching.  Right now we're not doing as
good a job of that as we can in most drivers though frankly even the
current state is an improvement on what we had.

> >The other bit of easy to implement that concerns me is making sure that
> >it's easy to implement for the stack as a whole - one of the big

> If you can get away from the idea that prepare is ONLY related to
> the Master, then it may provide additional "advantages". Also when
> you do have a non-prepared message, you can still can call the
> prepare code from the framework and afterwards unprepare it - like I
> had proposed.

> That way any "checks" the driver would need to do to see if it can
> handle the message, it can do immediately in the "prepare" code.

I'm having a really hard time getting excited about the improvements
=66rom saving the checks though, they just seem so small for the effort by
themselves.  You are right, they do exist, but they seem so small in
relation to the overall transfer time.  That said if a patch were to
appear which did that and didn't provide any master side hooks I think
that'd probably be OK.

> whatever the driver may find helpful for its own purpose. One
> candidate here could be also implement dma_map_single in the prepare
> call...

Of course this reduces the range of situations where the calling driver
can reuse a prepared message since it means if they want to access the
data they have to unprepare and then reprepare the message which rather
seems to defeat the point of having them worry about doing that.  This
is why I was asking about nailing down the sematics, I was worried about
this.

> So separating things out immediately reducing code of the individual
> drivers if they move to the newer interface of schedule_message...
> if they do not need prepare/unprepare, then it is (almost) a NOP.

Except for all the actually configuring the hardware stuff on
configuration changes if the register writes aren't DMAed (which is
going to be the common case unless it's frameworked).

> >Adding new interfaces is a change too, on the driver side as well.

> Which is optional and would get first used only by device-drivers
> that need high tru-put. And those device-drivers that need this,
> should already be heavily optimized to avoid memory allocations
> (even if it is just on the heap) and message setup for every call.

Equally well is it really worth their while if you don't get much win
without a specially optimised controller driver?  Extra advantages with
a good driver are one thing but requiring it makes it a harder sell to
drivers using the API.

> >These seem rather artificial and I'm not sure they'd tell us much about
> >why the effects were being observed.  What would be more interesting
> >would be seeing where the time is being spent at the minute for real
> >loads (for example by using trace points like those that are currently
> >being added in mainline for examining the behaviour of the message pump)

> well - my use case is exactly that CAN issue where I have message loss
> when only sending 5 packets in sequence in 30% of all cases with
> stock drivers. That is why I started investigating the issue in the
> first place - so do not tell me it is academic!

Sure, there's room for improvement but let's make that as general an
improvement as possible.  Something that flows better for existing
drivers is much more of a win there.  I'm getting alarm bells that the
gains for this one system might be hard to realise on other systems.

> The proposed SPI-test driver is academic to some extent, but it
> still tries to simulate "real" device traffic with optimal thru-put.
> Or do you think that reading an ADC as fast as possible is an
> academic exercise? (the test driver would essentially mimic that and
> allow for
> scheduling mechanism to work that allow high thruput (if you
> configure multiple messages)

I'm suspicous of benchmarks which limit so that you end up running so
fast you don't have time to actually do anything with the data, you can
end up tuning things so that more realistic users suffer (spending too
much time in interrupt context for example).

> >- if we really are spending a noticeable proportion of the time in setup
> >then that's obviously a good case for optimising it but right now I
> >don't feel I understand which bits are slow enough to register in the
> >context of the overall transaction and hence if the suggested approach
> >is the best way to optimise them.

> well - you see the setup I have to make to transfer 2 writes 10 reads?
> that is 10+ calls to dmapool_alloc, then filling in the structure.
> That takes some time (cant remember how many usec right now).
> And then tearing it down I need to do the same again - ok mostly
> dmapool_release...

Yes, but then this is because the driver is doing lots of really small
DMAs when most only DMA for larger transfers and then only the data.  I
can see can be a benefit if you have a big enough DMA queue to be busy
for extended periods but that's not always going to be the case and then
you get into wondering about how much you can keep mapped and so on.

Like I say I can see this being a technique which is useful over a range
of drivers but there's going to be a point where it's simpler to just do
the I/O.

> >An implementation that avoided the need to have the master drivers
> >updated in order to get benefits would be a lot more interesting since
> >that would make this much more generally useful, and of course concrete
> >patches would be good too, but the main thing I'm missing is clarity on
> >how the gains are being made.

> a master driver will never be able to profit from the new interface,
> besides the "small" gain of not having to validate the messages
> every time in __spi_async (if the device-driver does call prepare)

What about all the DMA pipelining stuff for the register I/O and so on?
That seems to be the biggest part of the win here.

> And as said: all the spi_sync methods are candidates to optimization
> of this - at the cost of some memory used for caching multiple
> messages.
> (say having 16 times 1xspi_message+1xspi_transfer structures for
> transfer length 1 to 16 in spi_write. Similar for spi_read. Or 256
> 1xspi_message+2xspi_transfer to transfer 1-16 writes and 1-16 reads.
> plus some memory copy for the reads and writes)

But then that's a memory plus cache management cost (per master), not to
mention complexity.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShCxOAAoJELSic+t+oim9mGMQAIV1sLb5A5X9PYrjzKY6qrx9
D1vXY5WWFMzuikiMYIlYQXUMA0ncybmlsUDdpUWCzu3ynDCUZdQ2O3YshHo3gjVu
dYhwmr0ziASt/oSXht8UMJCoMSIqVy8SB6Ej2taBJqLJBoXtd1V7jw4aC4fjx2px
4PPDR5irXjT3k6cP6ANpa395JNFPbyg2wx8McsAvXGYMB322gXIo5g9hN+XshoW/
eKlYvg6PHjZu/udhRE0VEf8qNmhpa30a75Xg2/aeFEbIWO4a++GD/OwS2coWUo3c
UK/qQeZDuXrXXP0VXBq85nRciQ0j1VZn6CSngzh8743C080PiF1Le5oiJlz7EUmT
/fTFw4dYXUt94VwrHBsDDc99cO4NQnohPqm2BlzEYkq0AmsxcdLabKqozyzmfTMU
1iC9HnDQNsFPiEmoKyK1PpYZ2DAL7Rky3esA/OiiXyvAoo8W7lRJUoThS6qGIP3g
C0KZGqeiZ1z6vTulrdVJa8yAko3x6RxRSY0MaoCMzrd1P663ceYpMU57n22+rQao
gpIeyA31ehMpsi/FQxzHVBc6T/9XntVdTvg8MyAoc1yFT5zGsk739H3mtCoeiL50
O7xQeWvK50Kftq0w4GnNjYNJRyje8q9uAObPFWjiVs4CepUlNyPU85/B0EcKYasD
6idtlvVgh2fA1eL6Vo2u
=0ShP
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
