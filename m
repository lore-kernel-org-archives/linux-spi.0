From: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: sun4i: allow transfers to set
 transmission speed
Date: Sun, 8 Nov 2015 11:27:51 +0100
Message-ID: <CAGNoLaMc5s1tufp+RPGRmyHKejkdgFgbz9Gc+RU2KXHByZJM5Q@mail.gmail.com>
References: <1446936065-15868-1-git-send-email-mweseloh42@gmail.com>
	<20151108093515.GB6746@sirena.org.uk>
	<CAGNoLaNR8av48D7T4XNt9KcdDuD0xYiC2O3f8qCSK8K5CntCCg@mail.gmail.com>
Reply-To: mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBDFO74UEV4IRBJ6H7SYQKGQEB677HCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGNoLaNR8av48D7T4XNt9KcdDuD0xYiC2O3f8qCSK8K5CntCCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

2015-11-08 11:13 GMT+01:00 Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> I did notice however, that the SPI system doesn't validate the
> speed_hz value. So if I leave out the above quoted sanity checking,
> then tfr->speed_hz could also contain values like -400, which trips up
> the spi system in such a way that I could only repair with a reboot. I
> was testing this with spidev... so maybe spidev should be patched to
> check the speed value for validity?

I just had a look through the spi core and noticed that it does indeed
validate the maximum and minium speed if set correctly on the spi
master. So I guess it's just a matter of a missing minimum transfer
speed in the DT. Sorry, should have done that earlier.

Ok, I will prepare a new patch version that simply uses tfr->speed_hz.
And I will also change sun6i-spi in the same patch, as sun4i and sun6i
are using the same transfer logic.

Cheers,

   Marcus
