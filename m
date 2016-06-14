From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [V3, 2/4] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Tue, 14 Jun 2016 17:58:16 +0100
Message-ID: <20160614165816.GT2282@sirena.org.uk>
References: <1465589171-25575-1-git-send-email-kdasu.kdev@gmail.com>
 <1465589171-25575-2-git-send-email-kdasu.kdev@gmail.com>
 <20160613101352.GF2282@sirena.org.uk>
 <CAKekbesr2i3N+yw0VV1aYqJONbBraKTNpibzm7NO_+sBbwENyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uc+LCsvbRhlIZa01"
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Vikram Prakash <vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Andy Fung <andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKekbesr2i3N+yw0VV1aYqJONbBraKTNpibzm7NO_+sBbwENyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uc+LCsvbRhlIZa01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 14, 2016 at 11:43:56AM -0400, Kamal Dasu wrote:
> On Mon, Jun 13, 2016 at 6:13 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > On Fri, Jun 10, 2016 at 04:06:09PM -0400, Kamal Dasu wrote:

> >> +     /* deassert CS on the final byte */
> >> +     if (fnb & FNB_BREAK_DESELECT) {
> >> +             mspi_cdram = read_cdram_slot(qspi, slot - 1) &
> >> +                     ~MSPI_CDRAM_CONT_BIT;
> >> +             write_cdram_slot(qspi, slot - 1, mspi_cdram);
> >> +     }

> > Let the core handle asserting and deasserting chip select.

> Its actually a peripheral CS (PCS) bit in the MSPI block. Peripheral
> chip selects are used to select an external device for serial data
> transfer. PCS[i] corresponds to pin SS[i].

That doesn't appear to address the issue, what you're describing sounds
like the normal function of the chip select?

> >> +             switch (command) {
> >> +             case SPINOR_OP_READ4_FAST:
> >> +                     if (!bcm_qspi_is_4_byte_mode(qspi))

> > No, this is not a good idea. You should not be attempting to parse
> > the data stream.  If your controller has flash support it should
> > implement the flash interfaces, otherwise it should just pass the data
> > streams through.

> This is only for read command we need to setup both tx and rx at the
> same time for improved performance.

No, to repeat what I said if you want to support accelerated flash reads
implement the standard accelerated flash read operation we have
(spi_flash_read()).  This is a fairly common feature and trying to open
code this in individual drivers would at the very least lead to a lot of
duplicated code and is the source of most of the problems in the code.

> >> +     spi_message_init(&m);
> >> +     m.spi = &spi;

> > I don't know why your driver is creating and trying to do SPI transfers
> > but that is completely inappropriate for a SPI controller.  Whatever
> > functionality this is implementing should be in a separate SPI device
> > driver.

> Currently not used. But I did not see a good way to be able to send
> commands, like finding the ID, setting 3/4 byte addressing mode , quad
> mode, on a PM resume(). Are you suggesting I make a driver similar to
> m25p80  ?.

I am suggesting you implement the standard flash interfaces and as a
result directly use m25p80.

> >> +MODULE_DEVICE_TABLE(of, bcm_qspi_of_match);

> > This is adding new DT bindings but there is no documentation,
> > documentation is required for all DT bindings.

> This was part of Patch 1/4 as pointed to by Florian

Please use standard formatting when posting patches.

--uc+LCsvbRhlIZa01
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXYDeiAAoJECTWi3JdVIfQ+zoH/jzmXyWd3heTK8sm57F6/JlI
Q68a8ox7X2xnNAJgzsHgCs3PaGZ646p1BDP7UUH1Z74feQqo0ZibzLki/LWksMkF
/sCbj96b/+OaEyu5ItgpZ29CUFcH0LlO34pIR0sLEG37EdYmG6g+J2ezh2tHmcYG
C6pI7fJ5H91VirEiO5bbNwIAMGQG4Csi5S8Jyg/ZenpHzTP4ghbEwNc54SdEPX7U
KRTLmJntWSoXmvnXv04iXancQyOTVU6QaasqzcNgQE+ZLkOgqmvF+WcY5ww5W8DJ
BOYjJRBdUPqNnJqe6euq6D8tX5pfK7QVzbCGhAfYcqSyWdj9g1E0zUw2upoqtQ0=
=KEEQ
-----END PGP SIGNATURE-----

--uc+LCsvbRhlIZa01--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
