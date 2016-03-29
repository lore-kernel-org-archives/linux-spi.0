From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: spi-pic32: Add PIC32 SPI master driver
Date: Tue, 29 Mar 2016 09:25:01 -0700
Message-ID: <20160329162501.GP2350@sirena.org.uk>
References: <1458740576-9168-1-git-send-email-purna.mandal@microchip.com>
 <1458740576-9168-2-git-send-email-purna.mandal@microchip.com>
 <20160328192629.GG2350@sirena.org.uk>
 <56FA6EE1.3000405@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYfJCIN5rqlfy3K0"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Joshua Henderson <digitalpeer-icZdIMMiY0PM6KjX8ROVJw@public.gmane.org>,
	Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56FA6EE1.3000405-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WYfJCIN5rqlfy3K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 05:32:41PM +0530, Purna Chandra Mandal wrote:

> It is required for MMC-over-SPI support. Linux MMC_SPI driver sometimes
> (depending on some logic) want chip-select to be kept enabled (using
> transfer.cs_change) even at the end of SPI message so that following
> message(s) can also be made part of the running MMC transaction.
> In this case if there is any error (and in some other cases as well)

If your hardware doesn't support per-/CS setup then your driver needs to
record whatever is configured via setup() and apply it later.

> MMC_SPI will have to terminate on-going MMC transactions and it is
> done by calling setup(). It is assumed that setup() will always leave
> the chip-select deactivated.

No, this is just completely broken - that's quite simply not what
setup() does.  See spi-summary.  There is *no* code in the core that
terminates ongoing transfers as a result of calling setup(), if that's
happening it's a result of triggering error handling.

> Best thing I can add is wait for unprepare_message() before calling
> cleanup().

The cleanup() function is for deallocating dynamically allocated data,
it will be called by the core.

> If you could suggest better alternative that will be great.

If you want to change the chip select you need to use the normal
interfaces for changing the chip select via message processing.

--WYfJCIN5rqlfy3K0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+qxcAAoJECTWi3JdVIfQCGEH/0ro4qDCRm3bQh+5p5470DJg
e0fokQVirG2OGwmCyvj2uIIwPflYltBY0D6Cp3UasEXmFwj0k4yulHy05NZAo97I
+BNqSGlUCqjfpoS6vQ8cOUnLkpa7O/8/W6TF6fBwkrrKehRpHKkeAa1RV8Ln/KQr
nhkXEw7U5nxLsx0DKSyJfEkBiHFLSM2kd1t+k/8Uh38LPjU2LviOoS7yvijdaZbs
WBmmHdyh8hdB0eZAFJadERpYgXtzRumya7c/DQUsFi9GjhnBkV4x39JfPC26Mvd5
v+/d6DanAjQGKY0E7EL6JWVhn7NKbxNu3qXPBcBSoM05ei36deB1yiZhF7rKTAs=
=0JYq
-----END PGP SIGNATURE-----

--WYfJCIN5rqlfy3K0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
