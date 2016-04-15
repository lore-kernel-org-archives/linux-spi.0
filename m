From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: pic32-sqi: add SPI driver for PIC32 SQI
 controller.
Date: Fri, 15 Apr 2016 10:35:35 +0100
Message-ID: <20160415093535.GD3217@sirena.org.uk>
References: <1460553778-1662-1-git-send-email-purna.mandal@microchip.com>
 <1460553778-1662-2-git-send-email-purna.mandal@microchip.com>
 <20160414055546.GA18024@sirena.org.uk>
 <57108A63.50803@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57108A63.50803-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 15, 2016 at 11:59:55AM +0530, Purna Chandra Mandal wrote:
> On 04/14/2016 11:25 AM, Mark Brown wrote:
> > On Wed, Apr 13, 2016 at 06:52:58PM +0530, Purna Chandra Mandal wrote:

> >> +	enable = readl(sqi->regs + PESQI_INT_ENABLE_REG);
> >> +	status = readl(sqi->regs + PESQI_INT_STAT_REG);
> >> +	if (!status)
> >> +		return IRQ_NONE;

> > For robustness the check should be if there was anything handled, not if
> > there was anything set.

> In PESQI controller INT_STAT_REG specifies interrupting reason(s) as usual,
> but mostly to confirm completion of on-going DMA operation. It is sticky,
> no way to acknowledge the interrupt source except masking the source.
> In short, whole interrupt logic is mere extension of status polling logic.

> And in driver isr logic is completely depended on the INT_STAT_REG; if status
> is zero no handling can be done and is unexpected!

That's fine, if something goes wrong there's error handling in genirq
which will notice that the interrupt is screaming and disable it.

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXELXlAAoJECTWi3JdVIfQYSEH/09u2k1l18aOWSIqJFvSdsyQ
m0X8w6wxlXMJk6s29O0R5xgjqraomkvYfeWqSCPDuqNH4Xc+SShZuYDk8fh81all
C7q6yEcFOM4vD7Vkdc6ZR4heSc7opYExQa4kLTlv5O6ZpP/gmfzpmKtvxg1C9VoC
tFyDBkr4IzzhOnYcaa/1eqeb4KPsPYeGwIna9ISvQg5eMymf9EW1Co7EzgXi6Ydl
Mm0l4wZhYSvQ84qgjU8Ykn5VzIdb4vuHSGVrIXIOlIhTWvJ1ilucaRhRn7Z8EQBq
KBO1d48rsQtK+yURE+ioXJ9sBQsCKhmJoAYRWXAOUhfiei2nkUU+/c0nQh3tzXw=
=Fhdf
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
