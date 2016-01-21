From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [TROLL PATCH] spi: add option to create spidev nodes for unclaimed chip selects
Date: Thu, 21 Jan 2016 17:23:01 +0000
Message-ID: <yw1x4me6onii.fsf@unicorn.mansr.com>
References: <1453394169-11458-1-git-send-email-mans@mansr.com>
	<CAMuHMdXgL-mXPhTw6d=eRwBme3nU=FNp4G+JSNcJrY0UVe8kUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel\@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXgL-mXPhTw6d=eRwBme3nU=FNp4G+JSNcJrY0UVe8kUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Geert Uytterhoeven's message of "Thu, 21 Jan 2016 18:11:07 +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> writes:

> On Thu, Jan 21, 2016 at 5:36 PM, Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org> wrote=
:
>> This adds an option to create spidev nodes for any chip selects not
>> bound to a driver via DT/ACPI.  It probably doesn't play nicely with
>> modules.
>
> And with pinmux, FWIW ;-)

In my particular case, I can put whatever pinmux I want in the DT and
bring out the SPI signals, but I simply don't know what device will be
connected.

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
