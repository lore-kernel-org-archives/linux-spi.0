From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers shorter than 30us
Date: Sun, 19 Apr 2015 11:44:02 +0200
Message-ID: <E9247B42-11B6-4032-A6C1-1FCEA3EDA2A6@martin.sperl.org>
References: <20150410185132.GU6023@sirena.org.uk> <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org> <20150415185824.GU6023@sirena.org.uk> <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org> <20150418104202.GA26185@sirena.org.uk> <54169601-55F7-464C-8A0E-ABF833C0F3BA@martin.sperl.org> <20150418115343.GI26185@sirena.org.uk> <EB2DE44C-29CA-422D-A89C-4173E02A2CEF@martin.sperl.org> <20150418122748.GO26185@sirena.org.uk> <2DB27253-8254-4098-ADE3-9AA22D52BE9D@martin.sperl.org> <20150418170756.GX26185@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418170756.GX26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 18.04.2015, at 19:07, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> Sure, but with the fallback to a much longer sleeping delay that'd be
> covered transparently anyway - it doesn't matter if we don't always
> manage to busy wait under load, what's more important is that we don'=
t
> fail the operation as a whole.
>=20
> Actually if it's just scheduling that's a concern then one final chec=
k
> after the time expires should do the trick shouldn't it?

Well - I have tried now lots of things now and I have also started some
diagnostics on timeouts as well as trying to detect reschedules and the=
n
report on the jiffies that have passed between start of loop and the ch=
eck
and I get values like this:

[ 5867.943426] mcp251x spi32759.2: detected reschedule: 7 jiffies
[ 5868.628859] mcp251x spi32759.2: detected reschedule: 8 jiffies
[ 5869.867311] mcp251x spi32759.2: detected reschedule: 8 jiffies
[ 5870.139622] mcp251x spi32759.0: detected reschedule: 8 jiffies
[ 5870.272004] mcp251x spi32759.2: detected reschedule: 8 jiffies
[ 5871.352704] mcp251x spi32759.0: detected reschedule: 5 jiffies
[ 5871.469095] mcp251x spi32759.0: detected reschedule: 8 jiffies
[ 5908.783971] mcp251x spi32759.2: detected reschedule: 75 jiffies
[ 5955.831822] mcp251x spi32759.0: detected reschedule: 75 jiffies
[ 5977.380447] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 5977.602457] mcp251x spi32759.0: detected reschedule: 15 jiffies
[ 5980.093570] mcp251x spi32759.2: detected reschedule: 2 jiffies
[ 6006.559147] mcp251x spi32759.2: detected reschedule: 5 jiffies
[ 6009.030543] mcp251x spi32759.0: detected reschedule: 8 jiffies
[ 6016.872027] mcp251x spi32759.0: detected reschedule: 27 jiffies
[ 6018.808468] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 6021.586796] mcp251x spi32759.2: detected reschedule: 81 jiffies
[ 6024.411264] mcp251x spi32759.2: detected reschedule: 77 jiffies
[ 6033.868509] mcp251x spi32759.2: detected reschedule: 55 jiffies
[ 6035.914697] mcp251x spi32759.0: detected reschedule: 81 jiffies
[ 6051.216355] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 6051.801190] mcp251x spi32759.0: detected reschedule: 55 jiffies
[ 6052.075748] mcp251x spi32759.0: detected reschedule: 27 jiffies
[ 6054.004605] mcp251x spi32759.0: detected reschedule: 81 jiffies
[ 6068.815078] mcp251x spi32759.2: detected reschedule: 27 jiffies
[ 6072.394473] mcp251x spi32759.2: detected reschedule: 81 jiffies
[ 6081.257468] mcp251x spi32759.2: detected reschedule: 81 jiffies
[ 6085.751653] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 6111.253374] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 6119.573181] mcp251x spi32759.2: detected reschedule: 74 jiffies
[ 6131.105261] mcp251x spi32759.0: detected reschedule: 4 jiffies
[ 6131.960492] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 6132.808198] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 6132.958858] mcp251x spi32759.2: detected reschedule: 8 jiffies
[ 6137.992678] mcp251x spi32759.2: detected reschedule: 48 jiffies
[ 6144.553370] mcp251x spi32759.2: detected reschedule: 34 jiffies
[ 6146.819876] mcp251x spi32759.0: detected reschedule: 82 jiffies
[ 6146.969923] mcp251x spi32759.2: detected reschedule: 8 jiffies
[ 6152.984406] mcp251x spi32759.2: detected reschedule: 82 jiffies
[ 6170.475425] mcp251x spi32759.0: detected reschedule: 74 jiffies
[ 6174.954398] mcp251x spi32759.2: detected reschedule: 82 jiffies

That happens when running torture CAN message receive test and
concurrently taring the =E2=80=9C*.o=E2=80=9D files of the kernel - whi=
ch produces
lots of IO...
But sometimes it also happens during other =E2=80=9Cminimal=E2=80=9D ac=
tivities -=20
but that is a much rarer event.

This is really the worsted case, as even those typical 8000 irq/s
on an idle RPI sometimes drop down to 200 irqs/s (plus high block out
counts) - and then the system is no very responsive to put it mildly...

So the only solution seem to be: if a timeout of > 2 jiffies occurs
fall back to interrupts.

This way we are catering for the worsted case and at least our code
should not make some drivers fail due to missing error-handling=20
in the driver when the system is overloaded and produces this kind
of delays.

In the hope that this is an acceptable approach I will post a patch
as soon as I have confirmed it to be working with  a much longer
torture-test that does not show any hiccups on the driver-side.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
