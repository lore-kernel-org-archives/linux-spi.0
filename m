From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Fri, 15 Nov 2013 13:33:12 +0000
Message-ID: <20131115133312.GE26614@sirena.org.uk>
References: <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
 <20131114015009.GB26614@sirena.org.uk>
 <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dKeYJkA19bNVVKdr"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9640F4C7-7F82-453E-9D83-5875A1559A20-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dKeYJkA19bNVVKdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2013 at 08:47:35PM +0100, Martin Sperl wrote:
> > Meh, it doesn't seem that urgently different to be honest.  The basic
> > flow of interactions with the device is very much typical of SPI
> > controllers.

> Well - if it was not for the requirement to call=20
> spi_finalize_current_message prior to leaving transfer_one message to get
> the next one - I might have continued this route with pipelining.
> But hacking my way around those limitations (by taking the next item of t=
he=20
> list, etc.) seemed a bit absurd to be honest.

The thing to do there is extend the interface, you're treating things
like you're working on a proprietary OS where the APIs are fixed.

> Well - if you think this "approach" is also applicable to other devices,
> then this is one more argument to allow device drivers to prepare its=20
> messages (with the is_dma_mapped requirement to keep cost low).=20

No, this isn't something which should be being open coded in individual
drivers - it's far too much redundant work especially once you get into
doing the tradeoffs for no queue vs queue cases.  Using regmap MMIO may
be helpful but we need to do that in a way that allows us to integrate
it into the DMA pipeline...

This is part of what I keep saying about doing things in a way that
makes them generally applicable.

> Note that if you do that and want to leverage the "prepare_message",
> then I would recommend you add an additional flag field to these calls.
> Because then you may pass some hints to the engine (like if it can
> use GFP_KERNEL or GFP_ATOMIC during allocations). And prepare=20
> could get done with GFP_KERNEL, while a "prepare" during spi_async
> would need to be done via GFP_ATOMIC.

Or in the async case we just punt the prepare to the thread.

> > That's fine for experimentation but for an actual merged API I think it
> > does need to be generally applicable so that it's worth the effort for
> > client drivers to support it.

> First of all it is a bus-driver that should be working.
> (also to avoid the expected "short transfer issue" for some use-cases I=
=20
> would propose to run it in parallel to the existing version)

> Then I believe we can start discussing any approach to refactor things
> after we get that far and we see the performance improvements and=20
> drawbacks for each of those steps.

It'll definitely need some experimentation and tuning.

> Well, actually if you do it right - like I did in my version of the
> mcp2515 driver, I am actually scheduling 2 spi_messages back to back.
> and only the first has a callback.=20

> The first reads the status registers on which to base decisions what
> to do and also pulls the interrupt high.

> While the second message does a speculative transfer of the=20
> first inbound message buffer and reads some error counters.

> So ideally while the callback of the 1st message is running the 2nd
> message is running in HW.

Yes, this is exactly the sort of thing I'm talking about - it's cutting
out dead time on the bus.

> For any driver that is _not_ optimized for latencies and where one=20
> needs low latency then a rewrite is required.

Right, and the big concern with the way you're currently proposing to
implement the optimisation is that it's leaving essentially the whole
thing up to the individual driver.  This is going to result in limited
adoption and is going to mean there's no sharing of learning and fixes
between drivers.

> I believe I should finish my POC to get fully up to my expectations
> and then I can show you the advantage of having this "minimal" change,
> which has also an overall positive impact (even though slight).

To repeat yet again, something that is just a tunnel through to this one
heavily optimised master driver isn't good.  The problem with the
proposed implementation is that it is essentially just tunnelling
through to a heavily optimised master, it's not generic enough.  If
other devices can make use of it it's more interesting but then those
uses ought to be being factored out.

--dKeYJkA19bNVVKdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShiKVAAoJELSic+t+oim9H6gP/1hWfAlFtT7xZPOCOpYjsQ24
Ghwd1vKdBPCIz+XWr4BWdCrsTyqb693ncNCxhv70fTvQJY/pNfBIzvqmo2FjXVf+
QoslnbGOCUjAvJNTuoc0kG5u3MXIR5gefU24pyczWXYONtAYQmfhjcv7WGjNWdu+
MvgRMW1AzL9VDK3PznoHdE7mWx4IRFyJgSWI22xWdXIW/lnT5a0PV+53XAFN/J2p
T8U0hf8q02HhF2PpwqzhqK9KJYUCjrk+pt8bLMOYU5I16myZNv2UyrIJQ1J0fuw4
DJRmIEWm8378JpABa6RJbwGnzkSNkIwz7IxGGgJNmzqZNzCrF41dgbH+LBpA2HC8
I7p+6Oi3HiszfrAo5Jpc0+zbzjXEjs75aOKntFWWYEvlxov+tbeFImTn0VDqk0Ob
NztN1tTnsseWq3F9G1EUNaLYrOty11vSrC/UgMn7DjPY97ht2PEfRYLgQTVMsr6n
NNIKNoCxUb6KxY15/WWq0JsOg9pey2j/77+DNu4WzFnJ3gpvGOGhOXHOyT0aZNFl
Wra5hPcNq4sw/xupk+pMojWWxCmoQCTlLNWBwZowW2jgZgY8wZ7gPfr7pwPYkWun
MoeS5AghynW/DLRDOyz/NgzI+mg7z11YXRJqXlPMNGuL5WJAciL+d0vKUHCThbwH
jzjM0O+DgYLEOgdZj8z+
=rU1V
-----END PGP SIGNATURE-----

--dKeYJkA19bNVVKdr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
