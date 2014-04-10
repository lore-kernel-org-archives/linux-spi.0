From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: ARM: bcm2835: DMA driver + spi_optimize_message - some
 questions/info
Date: Thu, 10 Apr 2014 23:35:32 +0100
Message-ID: <20140410223531.GF6518@sirena.org.uk>
References: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org>
 <20140402181547.GH2269@sirena.org.uk>
 <1AA37E97-BDD7-4B53-B092-18D5D7439F8B@martin.sperl.org>
 <20140403220232.GE14763@sirena.org.uk>
 <5AAD4FEA-2887-4A9D-9FE3-588210BFD1A6@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McOwgVabxjWRBDh+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: martin sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5AAD4FEA-2887-4A9D-9FE3-588210BFD1A6-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--McOwgVabxjWRBDh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2014 at 04:17:24PM +0200, martin sperl wrote:
> On 04.04.2014 00:02, Mark Brown wrote:

> > There should be some win from this purely from the framework too even
> > without drivers doing anything.

> If the device-driver does not do anything, then there is no cost involved=
 with
> framework (ok - besides an additional if "(!msg->is_optimized) ...")

> If the bus driver does not support optimization there is still some win.=
=20

Right, I was more pointing out that you were underselling here - you
were talking only about the benefits when everything is updated.  This
also means we can usefully merge partial support, addressing only some
of the improvements is still going to give some wins and makes it easier
to digest the code overall.

> For the framework there might also be the chance to do some optimizations=
 of
> its own when "spi_optimize" gets called for a message.
> There the framework might want to call the spi_prepare methods only once.
> But I do not fully know the use-cases and semantics for prepare inside the
> framework - you say it is different from the optimize I vision.

The main thing I'd like to do is actually coalesce adjacent transfers
within a message if they are compatible and we're doing DMA so we end up
with fewer hardware interactions overall.  There's a fairly common
pattern of writing multiple registers (for firmware download or setting
coefficients) where you have a small transfer for a register then a
larger one for a data block which would benefit.

For prepare I'd expect we can get to skipping reconfiguring the hardware
entirely when not needed even without an optimisation step, though the
tradeoff might not be worth it.  This may be required more than once in
a message though.

> > That would seem very surprising - I'd really have expected that we'd be
> > able to expose enough capability information from the DMA controllers to
> > allow fairly generic code; there's several controllers that have to work
> > over multiple SoCs.

> It is mostly related to knowing the specific registers which you need to =
set...
> How to make it more abstract I have not yet figured it out.

> But it might boil down to something like that:
> * create Fragment
> * add Poke(frag,Data,bus_address(register))
> * add Poke ...

Registers where?  If it's in the DMA controller we can just add ops for
the DMA controller can't we?

> But it is still complicated by the fact that the driver needs to use 3 DM=
A=20
> channels to drive SPI. As mentioned actually 2, but the 3rd is needed to=
=20
> stably trigger a completion interrupt without any race conditions, that=
=20
> would inhibit the DMA interrupt to really get called (irq-flag might have
> been cleared already).

Right, that's a peculiarity of your system (hopefully) which makes life
difficult for that.  The Samsung controller has a vaugely similar thing
where the transmit interrupt goes off too early for what we want so we
need to ensure there's always a read if we're doing interrupts but that
is a lot easier to work around.

> > Right, and it does depend on being able to DMA to set GPIOs which is
> > challenging in the general case.

> "pulling" GPIO up/down - on the BCM2835 it is fairly simple:
> to set a GPIO: write to GPIOSET registers with the corresponding bits
>  (1<<GPIOPIN) set.
> To clear it: write to GPIOCLEAR registers again with the same mask.
> So DMA can set all or 0 GPIO pins together.

That's quite convenient for this sort of use - lots of controllers just
have a register where you need to set the values of some GPIOs so you
end up doing a read/modify/write which is obviously hard with DMA.  We
would need gpiolib to export an interface to allow this operation; it
should be doable but I expect it's like the regular bulk set and tends
to get bogged down.

> > Broadly.  Like I say the DMA stuff is the biggest alarm bell - if it's
> > not playing nicely with dmaengine that'll need to be dealt with.

> As for DMA-engine: The driver should (for the moment) also work with mini=
mal
> changes also on the foundation kernel - there is a much bigger user base=
=20
> there, that use it for LCD displays, CAN controllers, ADCs and more - so =
it
> gets more exposure to different devices than I can access myself.

It's good to talk early so the ideas are in people's heads if nothing
else, it also helps ensure everyone is travelling in the same direction.

> But still: I believe I must get the basics right first before I can start
> addressing DMAengine.

Sounds like you already have a pretty good prototype?

> And one of the issues I have with DMA-engine is that you always have to s=
et up
> tear down the DMA-transfers (at least the way I understood it) and that i=
s why
> I created this generic DMA-fragment interface which can also cache some of
> those DMA artifacts and allows chaining them in individual order.

> So the idea is to take that to build the DMA-control block chain and then=
 pass
> it on to the dma-engine.

Right, that's the biggest thing I can see in what you're suggesting for
dmaengine and it sounds like something other users could also benefit
=66rom so I'd not expect massive pushback.

> This kind of thing is something that DMA-engine does not support as of no=
w.
> But prior to getting something like this accepted it first needs a proof
> that it works...=20

On the other hand you may find that what you've got already is enough
for people, or get a feel for the sort of things people are looking for
to show a win.  Sometimes you'll even get "oh, that's a really good idea
I'll just add the feature" (if you're very lucky).

BTW I have acquired a RPi for some other use - is the CAN board you are
using something I can order?  I'm not sure if I'd ever have much time to
look at it but I'm generally trying to expand the range of SPI hardware
I have available for test.

--McOwgVabxjWRBDh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTRxywAAoJELSic+t+oim9CeQP/2cgPP8rU15nVSDQci7vlibq
zw2gzzRN08zDnXrLghlsw5H4nyu+h6oG/+HMVXdIC4QWu00p315L/WpixiYEXZ83
d7v/3UN81mog4OosSi8l3Lsfg62SVM8tRp5HseEpuU43aXaJNEQRab2y3EtPMHDj
PiIJ38Ol1cvCpB+4w62taap7/yP7yTPXTx/mebQvTxehSNB+8swjyx5VT4jRG/3M
OLyjuuUYzm+3fNKBUqymMYoltmdFLVEjL4zRtwp8ERe+nYIhKUfgZBEegBIno1Q4
qKB9hhWejhOP3XNFm8J5g17HKiOGU1mdTxSpJaMdDu2vEvuG5HGLeju6TsJLsFdC
iwPGJU4qZZYOIPsUCml1FpMTQ/to9zk+kVV3K9ngDrIHHhBBjETcVlBPoqc89gsm
zPw/RN8P1GH2C27eNuYYqwBHpHUlGRxlk3LY+G65aLnMIb1h3BQWmw9GjK5hz53B
X6mrq5DI5n95czDLxZ/NvuwhWwTOZgXGvmAEYifSmL14oEJXDuY74vGTC2Xf27FB
YC/IWhS7AtWeI7W4lR2AB+agilGiOJlz1LL7OCl9YsfWyzoLcjVqPyuRptSpJ5AC
YXIqAw8ZLnPQ7UZ9os67XxSNkS9hP5vOQ4AH3E+JE3VST99LW5vpgQxMcitS0CEz
OAqPTVlshIpP114A89dr
=5Jeb
-----END PGP SIGNATURE-----

--McOwgVabxjWRBDh+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
