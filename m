From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Fri, 2 May 2014 01:28:26 +0200
Message-ID: <CAMuHMdUWa1_n94sDvv=L_goc+SOnD9CAKi5DzifrY7GWYRdQmw@mail.gmail.com>
References: <1398705774-12361-1-git-send-email-maxime.ripard@free-electrons.com>
	<20140429183758.GH15125@sirena.org.uk>
	<20140430180609.GC3000@lukather>
	<20140501011811.GF3245@sirena.org.uk>
	<20140501223629.GJ3000@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140501223629.GJ3000@lukather>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Maxime,

On Fri, May 2, 2014 at 12:36 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> But it actually doesn't work in a case where you can't really predict
> what is on the other side of the bus. Either because, on the board
> you're using the pins are exposed and it's pretty much up to the user
> to know what to put on it. That could be handled by DT overlays
> though.
>
> What never works is where the device on the other side is so generic
> that you really can't tell what it does. Think of a microcontroller
> that would behave as a SPI slave. It's behaviour and what it does is
> pretty much dependant of what we flashed on it, and suddenly the
> compatible string is not the proper reprensentation anymore.

So you will (hopefully soon) use overlay DT to change the DTS to match what's
connected?

And then you want spidev to bind to it. Would it help if DT offered a feature
to add a compatible entry to a driver at runtime, cfr.
/sys/bus/pci/drivers/.../new_id on PCI?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
