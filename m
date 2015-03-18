From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
Date: Wed, 18 Mar 2015 14:32:26 +0100
Message-ID: <20150318133226.GR10068@pengutronix.de>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150318113635.GB2869-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 18, 2015 at 11:36:35AM +0000, Mark Brown wrote:
> On Wed, Mar 18, 2015 at 11:27:28AM +0100, Uwe Kleine-K=F6nig wrote:
> > With spidev the mesg->complete callback points to spidev_complete.
> > Calling this unblocks spidev_sync and so spidev_sync_write finishes=
=2E As
> > the struct spi_message just read is a local variable in
> > spidev_sync_write and recording the trace event accesses this messa=
ge
> > the recording is better done first. The same can happen for
> > spidev_sync_read.
>=20
> Applied, thanks.  I'm a bit suspicious that the changelog talks only
> about spidev though...
That's my workflow. Maybe the important thing here is also that I use
-rt?!

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
