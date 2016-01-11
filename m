From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: atmel: improve internal vs gpio chip-select choice
Date: Mon, 11 Jan 2016 16:16:31 +0000
Message-ID: <yw1xd1t8w0ps.fsf@unicorn.mansr.com>
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
	<20160111161333.GK6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Yang\, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160111161333.GK6588-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Mon, 11 Jan 2016 16:13:33 +0000")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Mon, Jan 11, 2016 at 04:01:42PM +0000, Mans Rullgard wrote:
>> The driver currently chooses between internal chip-select or gpio
>> based on the existence of the cs-gpios DT property which fails on
>> non-DT systems and also enforces the same choice for all devices.
>
> Normally you shouldn't send incremental patches against patches that
> have already been applied.

Should or shouldn't?

> However in this case I'm going to drop your original patch anyway due
> to the issue that was found so it's OK.

Sorry, I hadn't noticed it was already applied.  Too many trees to keep
track of.

--=20
M=E5ns Rullg=E5rd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
