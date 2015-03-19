From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
Date: Thu, 19 Mar 2015 12:48:42 +0100
Message-ID: <20150319114842.GU10068@pengutronix.de>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
 <20150318135854.GI2869@sirena.org.uk>
 <20150318144854.GS10068@pengutronix.de>
 <20150319112430.GP2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150319112430.GP2869-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

On Thu, Mar 19, 2015 at 11:24:30AM +0000, Mark Brown wrote:
> On Wed, Mar 18, 2015 at 03:48:54PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 18, 2015 at 01:58:54PM +0000, Mark Brown wrote:
>=20
> > > My point here is that the analysis of the issue shouldn't depend =
on
> > > spidev in particular, if you need to call out the specific driver=
 you're
> > > working with that's an alarm sign that it's doing something weird=
 and
> > > perhaps the problem is with the driver.
>=20
> > This just happens to be the driver I saw the problem with. Don't ha=
ve
> > another spi device on that bus to cross check with other drivers. I
> > wouldn't be too concerned here.
>=20
> Sure, but it's better to write it up in terms of a generic driver - i=
t's
> the difference between "let's work around this driver" and "the core
> isn't doing the right thing for drivers here".
OK, so something like:

------------>8------------
spi: trigger trace event for message-done before mesg->complete

The message's complete callback might (permissibly) free the memory tha=
t
holds the message. As recording the trace event for the end of a
transfer accesses this message the recording is better done first.

This fixes an oops observed on a 3.14-rt system with bus activity using
spidev after

        echo 1 > /sys/kernel/debug/tracing/events/spi/enable

=2E (For spidev mesg->complete points to spidev_complete. Calling that
unblocks spidev_sync and so spidev_sync_write (or spidev_sync_read).
This in turn leaves the scope of the local variable that holds the
message.)
------------>8------------

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
