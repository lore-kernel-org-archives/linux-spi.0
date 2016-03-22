From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
Date: Tue, 22 Mar 2016 10:06:15 +0000
Message-ID: <20160322100615.GA2566@sirena.org.uk>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wkv87tf6M42+4Jbu"
Cc: Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Lakshmi Sai Krishna Potthuri
	<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C-4lKfpRxZ5ekkx2a1wsGfbYg+Gb3gawCHQz34XiSyOiE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Wkv87tf6M42+4Jbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 22, 2016 at 06:39:51AM +0000, Lakshmi Sai Krishna Potthuri wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.  Please also avoid reflowing other text
into longer lengths, this makes things worse.

> >This isn't enough to add the feature - a client driver trying to make use of this
> >needs to be able to tell if the cycles are actually going to be inserted.  I'd
> >expect to see a capability flag that can be checked and some error checking so
> >that if we try to do a transfer with dummy cycles and can't support it we don't
> >silently ignore the dummy cycles, ideally also something that'll handle
> >multiples of 8 bits with SPI controllers that don't otherwise support this
> >feature.

> Currently, all fast reads use 8 cycles or 1 byte of dummy. This generally works.
> But it can be vary based on the flash and the type of read command.
> Dummy bytes are taken care of in m25p80.c by adjusting the len field:
> Length = size of (command + address + dummy byte)

> There might be controllers (like ZynqMP GQSPI) that would be able to use
> the information that dummy byte(s) were added and the precise number
> of dummy cycles. This patch does not disturb the existing implementation
> of adjusting length (as described above). It adds an additional optional feature.
> So there is no harm to controllers that can't support it - they can ignore it and
> still work with the existing "length adjustment" implementation.
> If you think there value in adding a capability flag, please let me know.

This is really not what I'd expect to happen, I'd expect that these
dummy cycles would be in addition to the actual data (see my request for
better documentation...).  If they overlap with the data then what is
the point in specifying this?  It's more work for the host, what benefit
do we get from doing it over just handing it like a normal byte?

--Wkv87tf6M42+4Jbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8RkVAAoJECTWi3JdVIfQ9GoH/3Jas4s88xTpk1aqYIJuu9AJ
gQa8TtCN+IDg5aI+CKHOOzbxRc2STOecnpj3R5nQDj5pnZYM1v9FaJtfaOWm9u2G
PKcdAb+yzpGY7zEvSe1oKRPmSLsp7cvi6GBkRLWgGtMdpGbPE4Te/25eKGMv1soX
QnkSgbFL07yJEH+6twJMb1EWyZOZXDGBT1cyD04JHxHyPbv/2xow21yQ3F2jtEmY
sFMDrN80qlBPIWiGgfZrOd+RBEz9hVtztOFWJIMBffq1oIFpfwTjCjZbAaZi7W6c
4UpvQETxw8bwxGNdysHaYgd0Ca1SX4LgcyACa6u1QOr2MCFT+DlqBvKhCnaPty4=
=NF3t
-----END PGP SIGNATURE-----

--Wkv87tf6M42+4Jbu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
