From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: clps711x: Driver refactor
Date: Thu, 2 Jan 2014 18:46:23 +0100
Message-ID: <201401021846.23488.arnd@arndb.de>
References: <1388556568-10973-1-git-send-email-shc_work@mail.ru> <1388583851.810843204@f301.i.mail.ru> <20140101150737.GR31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140101150737.GR31886-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday 01 January 2014, Mark Brown wrote:
> > As an alternative, I can create patch to remove current driver,
> > then re-adding new one.  Will be more convenient to watch. Is it better? 
> 
> No, that's really not good.  It's very rare that we just completely
> rewrite a driver especially not one that's been around for a while -
> there needs to be a really good reason for it.  This is a key part of
> how the development process works, incremental improvements and code
> review.  Doing this both helps improve quality control on changes and
> allows collaboration.

I definitely agree with what you say, but please note that Alexander is
the only person who ever sends clps711x patches, so there is not much
hope of collaboration. I also suspect he's the only one who would
suffer from accidental breakage, especially since the existing driver
is not used anywhere upstream (no instance of platform data, and no
DT support).

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
