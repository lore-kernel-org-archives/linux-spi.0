From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: clps711x: Driver refactor
Date: Thu, 02 Jan 2014 20:03:24 +0100
Message-ID: <1466537.jU4x6flQ6J@wuerfel>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru> <201401021846.23488.arnd@arndb.de> <20140102182549.GF31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140102182549.GF31886-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday 02 January 2014 18:25:49 Mark Brown wrote:
> On Thu, Jan 02, 2014 at 06:46:23PM +0100, Arnd Bergmann wrote:
> 
> > I definitely agree with what you say, but please note that Alexander is
> > the only person who ever sends clps711x patches, so there is not much
> > hope of collaboration. I also suspect he's the only one who would
> 
> There's stuff been going in from the people who do generic cleanups and
> updates.

Yes, I meant patches for new clps711x functionality. I saw the cleanups
as well.

> > suffer from accidental breakage, especially since the existing driver
> > is not used anywhere upstream (no instance of platform data, and no
> > DT support).
>
> Right.  On the other hand I really don't want to get into setting bad
> precedents that people then use when they complain that I actually want
> to review their code, that's just going to be more miserable in the long
> run.

Makes sense.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
