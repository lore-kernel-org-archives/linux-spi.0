From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 0/8] ARM: s3c64xx: Let amba-pl08x driver handle DMA
Date: Wed, 4 Dec 2013 13:39:33 -0800
Message-ID: <CAOesGMhkEhr0XvTNoObWO4XckUzU1vRiC-ZX2ArcgvSa8-WoQA@mail.gmail.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
	<20131017102201.GK2443@sirena.org.uk>
	<52644563.1000203@samsung.com>
	<20131120123152.GZ2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>,
	"linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org"
	<linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Padmavathi Venna <padma.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Sangbeom Kim <sbkim73-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131120123152.GZ2674-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 20, 2013 at 4:31 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Oct 21, 2013 at 06:04:35AM +0900, Kukjin Kim wrote:
>
>> Applied this whole series.
>
> This didn't seem to make it into -next or your tree, it'd be really
> helpful to be able to merge into both ASoC and SPI so they can be used
> for some framework work (I already have some patches for ASoC).  Would
> it be possible to get the changes published on a separate branch or
> signed tag so I can pull it into those subsystems for the next merge
> window?

Following up here too: I've merged this branch into arm-soc directly now.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
