From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 4/6] spi: atmel: use atmel_io.h to provide on-chip IO
Date: Thu, 26 Mar 2015 16:41:29 +0100
Message-ID: <551428A9.9090604@atmel.com>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk> <1427370354-21247-5-git-send-email-ben.dooks@codethink.co.uk> <20150326153855.GP3572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>, <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list:
	SPI SUBSYSTEM <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ;
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150326153855.GP3572-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 26/03/2015 16:38, Mark Brown a =E9crit :
> On Thu, Mar 26, 2015 at 11:45:52AM +0000, Ben Dooks wrote:
>> Use <linux/atmel_io.h> to provide IO accessors which work on both
>> AVR32 and ARM for on-chip peripherals.
>=20
> To repeat the feedback on your previous big endian fix: I've not been
> CCed on the cover letter or any of the other patches so can someone t=
ell
> me if there are any dependencies or anything?

Yes, there is dependency on a common header file. So I think we should
keep the series grouped or plan a migration path.

Bye,
--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
