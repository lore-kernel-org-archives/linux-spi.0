From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 11/18] spi/xilinx: Remove rx_fn and tx_fn pointer
Date: Tue, 27 Jan 2015 07:42:34 -0800
Message-ID: <1422373354.18650.8.camel@perches.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
	 <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com>
	 <20150127000903.GM21293@sirena.org.uk>
	 <CAPybu_3gF1BXhq4j5Z3DfM8_PxuK72Pshm6_5qVKH-ZyYTpgig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"moderated list:ARM/S5P EXYNOS AR..."
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPybu_3gF1BXhq4j5Z3DfM8_PxuK72Pshm6_5qVKH-ZyYTpgig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2015-01-27 at 11:00 +0100, Ricardo Ribalda Delgado wrote:
> >> +     xspi->rx_ptr += xspi->bits_per_word/8;
> > Also there's
> > a coding style thing - spaces around the / please.
[]
> I am also cc: the maintainers of checkpatch, because for whatever
> reason, this was not found by the script

Because it's personal preference.

checkpatch would note if a space was used
inconsistently (before but not after the /,
or the other way 'round)


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
