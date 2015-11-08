From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sun4i: allow transfers to set
 transmission speed
Date: Sun, 8 Nov 2015 10:44:28 +0000
Message-ID: <20151108104428.GD6746@sirena.org.uk>
References: <1446936065-15868-1-git-send-email-mweseloh42@gmail.com>
 <20151108093515.GB6746@sirena.org.uk>
 <CAGNoLaNR8av48D7T4XNt9KcdDuD0xYiC2O3f8qCSK8K5CntCCg@mail.gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBHOP7SYQKGQEW3AZ5UY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGNoLaNR8av48D7T4XNt9KcdDuD0xYiC2O3f8qCSK8K5CntCCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sun, Nov 08, 2015 at 11:13:33AM +0100, Marcus Weseloh wrote:
> 2015-11-08 10:35 GMT+01:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:

> > This is not needed, the core will always ensure that the transfer speed
> > is set per on each transfer.

> Ah, so we could always use tfr->speed_hz and completely ignore the
> spi->max_speed_hz for the clock calculations, correct?

Yes.

> I did notice however, that the SPI system doesn't validate the
> speed_hz value. So if I leave out the above quoted sanity checking,
> then tfr->speed_hz could also contain values like -400, which trips up
> the spi system in such a way that I could only repair with a reboot. I
> was testing this with spidev... so maybe spidev should be patched to
> check the speed value for validity?

No, why would it make sense to have this validation in spidev - it's
just one SPI device.  It's better to add the validation to the SPI core.
--tEFtbjk+mNEviIIX--
