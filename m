From: Mark Brown <broonie@kernel.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Thu, 4 Jul 2013 20:12:16 +0100
Message-ID: <20130704191216.GK27646@sirena.org.uk>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704143645.GA27646@sirena.org.uk>
 <20130704180656.GA1974@sig21.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4490056335135669796=="
Cc: Grant Likely <grant.likely@secretlab.ca>,
 spi-devel-general@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 yuhang wang <wangyuhang2014@gmail.com>, linux-arm-kernel@lists.infradead.org
To: Johannes Stezenbach <js@sig21.net>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20130704180656.GA1974@sig21.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============4490056335135669796==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l2oS3IZyNaLBAPfX"
Content-Disposition: inline


--l2oS3IZyNaLBAPfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2013 at 08:06:56PM +0200, Johannes Stezenbach wrote:
> On Thu, Jul 04, 2013 at 03:36:45PM +0100, Mark Brown wrote:

> > OK, so all this is about is devices that have extra data lines.  Please
> > don't invent terms like "DUAL" and "QUAD", it makes things much less
> > clear.  Just describe it as support for multiple data lines.

> Flash data sheets use the terms Dual and Quad I/O Mode,
> e.g. for MX25L25635E
> http://www.macronix.com/QuickPlace/hq/PageLibrary4825740B00298A3B.nsf/h_Index/6F878CF760C559BD482576E00022E6CC/?OpenDocument&EPN=MX25L25635E

OK, but this is not a flash specific feature but rather something at the
SPI level and even with flash are they typically written in all caps?
This really needs to be described at the SPI level for the SPI subsystem,
not in terms of the specific application.

> > Calling this "bandwidth" is really unclear - I would expect a bandwidth
> > to be expressed in bits per second or similar.  This would be much
> > clearer if it was just the number of data signals.

> "bitwidth" != "bandwidth", but maybe the name could be improved,
> how about xfer_width?  The mmc susbsysem has something similar
> and calls it bus_width.

Bus width is better but I think half the issue here is the use of
"width" and the fact that this isn't being done separately for RX and
TX, it's really not clear what's being talked about.  xfer_width sounds
to me like it's something to do with the word size so I don't think
that's a good idea.  n_mosi and n_miso perhaps?

> > > +       t[0].rx_buf = buf;
> > > +       t[0].len = len;
> > > +       t[0].bitwidth = spi->rx_bitwidth/spi->tx_bitwidth;
> > > +       spi_message_add_tail(&t[0], &m);

> > This interface won't work for bidirectional transfers with asymmetric
> > numbers of data lines - we need separate fields for rx and rx.

> I'm not aware that bidirectional transfers are supported in
> dual or quad IO mode.  I think only flash supports it and

As far as I can tell this is just because you guys are only thinking in
terms of flash chips here - I can't believe that only flash manufacturers
came up with the idea of adding extra data signals to SPI, it's not that
big a leap (and MMC obviously has some overlap here...).  If nothing
else I'd expect some FPGAs would use this, and I wouldn't be surprised
if there were DSPs that could use this.

--l2oS3IZyNaLBAPfX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1ckNAAoJELSic+t+oim9DrsP/AiVNxUOZbByU1WHHlCv5ga+
vrheagppDckfCflmliXBsOfHjER9eXQ7nUY+FnRoSVks6RNQn3/V0iT3dYiUrjMM
YD9Be8Ea3O+iKqNw9mC5BaesjSMDljMMsvRTIeSpoMYfPAljLBd+rkMJFaKapK2B
N3LA4bGTMlTYS8nF9tT/CB5NkG30f8NHQxVF7zpHO21EH0bmKbCGxpy4jodW5PnY
Yf1uE8QUTmMiwbTZmVx7Lrmq1A5GXx+UGVQfhRvXthd/zSadTktCq1PTZdHXeXrW
NIPDk47ygK0fh7w0wRvsGCppTGQ0kahNe6THUTv2cRIqtSY/EvMRkFUF4MVKryhM
vyRkVItAbeSUW5Pb1CQMdw0YsXkQzdkRMvreLE8QKBGwYwGHaXoZ2tMlTgvfDn4O
kh5JKahH9ZJyAL6P1GxFxK0AkAP5UrBMJ0V4Uni3swrjwKHjOI8fcZtGrVCetkwE
K7Hz408z3fVyuvayoM7VWyvVgMcRbHPP1fXDNQ4+wVxNexv5qYODNFsFR/z8ujzh
TU1C6toqJlhSpCdc5CR3jRezQjtYCcysGS9R9KAST4mioTRQNIfdZpTL4kAx48MH
ZAcKA9I0NTqbHcbuJS2FYSSciU8z8A4dzBlZtbd7/oPSSYBRU2DJ+S26YgAeyDFV
Dg9NSaRdIIRV4+voSJjd
=M0XC
-----END PGP SIGNATURE-----

--l2oS3IZyNaLBAPfX--


--===============4490056335135669796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4490056335135669796==--
