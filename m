From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Thu, 26 Mar 2015 18:32:23 -0700
Message-ID: <20150327013222.GB1743@sirena.org.uk>
References: <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org>
 <20150325151611.GA3572@sirena.org.uk>
 <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org>
 <20150325165441.GI3572@sirena.org.uk>
 <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org>
 <20150325185007.GL3572@sirena.org.uk>
 <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org>
 <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org>
 <20150326173511.GW3572@sirena.org.uk>
 <C176096E-3731-4F47-9DCF-AE83B143EB9D@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C176096E-3731-4F47-9DCF-AE83B143EB9D-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 08:15:26PM +0100, Martin Sperl wrote:
> > On 26.03.2015, at 18:35, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > On Thu, Mar 26, 2015 at 11:08:36AM +0100, Martin Sperl wrote:
> >> This also allows for GPIO-CS to get used removing the limitation of
> >> 2/3 SPI devises on the SPI bus.

> > This doesn't apply against current code, please check and resend.  As
> > previously mentioned please use subject lines matching the style for the
> > subsystem.  A few other things below but it's basically all good.

> I have applied it against "for-next" (8befd715f1c1684b3).

> The reason I chose for-next is because there all the other patches
> I have submitted so far have been added there already...

> Against which one do you want to apply it instead?

I would expect to apply patches against the relevant topic branch if one
exists, if they don't apply there then mention the dependencies.  I've
managed to figure that out given the above and applied the patch, though
in addition to the issue with the subject line that I mentioned earlier
please (as I think also mentioned several times now) do not send patches
in reply to existing threads.

> You want me to merge all those patches into a single patch instead?

Please never do this, neither resend already applied patches nor combine
unrelated patches into a single patch.  Resending already applied
patches wastes people's time and combining unrelated patches makes
review harder and goes against the good practice covered in
SubmittingPatches.

> >> So the question is if we should depreciate native chip-selects for this
> >> driver with one of those future improvements listed below.

> > Given that this driver is only going to be used with a single SoC (or
> > perhaps a very limited set of SoCs, I don't know if it's the same driver
> > in the Pi 2) even if the DT specifies a hardware chip select we should
> > be able to look up which pin that's brought out to and put it into GPIO
> > mode if that's the most sensible thing for the driver.

> The point here is that we need to change the alternate function for that
> pin to output make it work.

Yes, I understand that.  To repeat we should (given that this only needs
to cope with a very limited range of systems) be able to figure this out
without DT.

> > This in particular is something the framework should have: it's
> > generally useful and we should be able to do it with either a new
> > transfer_irq_safe() (or something) operation or a refactoring of the
> > existing one.

> Let me see what I can do with the current setup and then we can generalize
> from that.

Pushing the next transfer immediately from the completion seems pretty
general?

> For most parts I see that I would use transfer_one and return 0 immediate=
ly
> if we can "chain" it in interrupts - only the last transfer would trigger
> a complete in the interrupt handler and return. We could even run the=20
> callback in the irq, if it is permitted...

You can't rely on an existing transfer_one() being interrupt safe.

> But as I see there would be a few cases that would also need a complete.
> These would be "delays" and maybe a CS-change - there mostly because of
> the hard-coded "udelay(10)", but then it might be acceptable to sleep
> 10us in the irq, because the overhead of the irq handler releasing the CPU
> is arround 5us and then you got another 3us inside the scheduler before
> the worker-thread wakes up. If you take all that then you may as well sle=
ep
> in the interrupt handler - those at least are my measurements for
> a RPI.

Yes, delays and /CS bouncing need to be punted to threads.

> >> +	/* error in the case of native CS requested with CS-id > 2 */
> >> +	dev_err(&spi->dev,
> >> +		"setup: only three native chip-selects are supported\n"
> >> +		);

> > The indentation here is weird - at least the last ); should be with the
> > string.

> Will fix that when you tell me which branch you want it to get patch to=
=20
> apply against.

Please send an incremental patch.

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFLMmAAoJECTWi3JdVIfQWCEH/i1smUaH/6tjPLyhLBC0R1In
Nzhf2zE+EEO0tJpIzp7VVKh2Ko+KPVjof3uUaQXTooUgAMc9I2WrqI6iK2wQQ2Tx
PorLwcle8ytVpHF+GfF9yx7lGFt4BrpVUG3dUKukTlfQTS/kN1AfoiLuYZEJqZ5Y
c1YIKBN126UYHlhREjSba8/zT05afbrAhkCvFMwOgF0nfM2UGqMcIkeafPmW3pBA
T6OkeYjP+w4ZCUNS/LSl+AvYG6wrnc1QRH05w2VxbiWh4xhNCwrUQ/gkK6v02XlF
/VhRIyoE22LXP5uvmxsR41Z5SwPlQtJXFQBRIwIyZYyArE7w9rPmEWgxiZCtt1Q=
=9OUf
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
