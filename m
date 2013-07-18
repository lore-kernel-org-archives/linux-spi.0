From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 01/12] spi/mxs: Always set LOCK_CS
Date: Wed, 17 Jul 2013 18:08:35 -0700
Message-ID: <CA+7tXijy8zVuU6t8s1GUq_domKdFWtE0hvsnX9bjgZLK+iZPow@mail.gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
	<201304030118.42976.marex@denx.de>
	<CAOMZO5AEU3D3o-8fKLQJvsRSwBMNn0jfwZFC6R93TKaUpxffSw@mail.gmail.com>
	<20957.32214.721252.361301@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20957.32214.721252.361301-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 10, 2013 at 8:29 AM, Lothar Wa=DFmann <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>w=
rote:

> > >> always be set.  The DMA code will always set it, explicitly on the
> > >> first segment of the first transfer, and then implicitly on all the
> > >> rest by never clearing the bit from the value read from the ctrl0
> > >> register.
> > >>
> > >> The only reason to not set LOCK_CS would be to attempt an altered
> > >> protocol where CS pulses between each word.  Though don't get your
> > >> hopes up if you want to do this, as the hardware doesn't appear to do
> > >> this in any sane manner.
> > >
> > > Can you please elaborate on this part above? The description is very
> vague.
> > >
> > >> LOCK_CS keeps CS asserted though the entire transfer.  This should
> From my experience the HW deasserts CS whenever the output fifo runs
> empty.
>
>
I think that might be the case.  Since I have no need to add support for
some non-standard SPI protocol nobody has wanted, I didn't spend the time
to reverse engineer how exactly it worked.  I think what would happen is
that if you used multi-word transfers (and the current PIO mode in the
driver ONLY uses single word transfers!) you would sometimes get a CS pulse
between each word and sometimes every four words.  It seemed to make a
difference if one used multi-word PIO with a FIFO, which the current driver
doesn't support, or multi-word DMA.

I did spend enough time on it to determine that, "always set LOCK_CS all
the time for normal SPI," is correct.  The driver's method of setting in
for all transfers but the last, except in DMA mode where it's set on the
last transfer too, apparently by accident, is unnecessarily complex and
inefficient.  It only "works" because the current PIO code only supports
single word transfers at the hardware level.
---------------------------------------------------------------------------=
---
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=3D48808831&iu=3D/4140/ostg.cl=
ktrk
