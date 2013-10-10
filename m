From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Thu, 10 Oct 2013 11:10:52 +0100
Message-ID: <20131010101052.GF21581@sirena.org.uk>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
 <1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
 <20131009160759.GQ21581@sirena.org.uk> <52558A49.5090904@ti.com>
 <20131009174027.GS21581@sirena.org.uk>
 <87hacq1d5k.fsf@dell.be.48ers.dk>
 <CA+7tXii4J_Hie2v-DaSevFHn-YqriiVowhpXCP9H+U51_tbhvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7960476595572401136=="
Cc: Peter Korsgaard <peter@korsgaard.com>, balbi@ti.com,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 Sourav Poddar <sourav.poddar@ti.com>, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Trent Piepho <tpiepho@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CA+7tXii4J_Hie2v-DaSevFHn-YqriiVowhpXCP9H+U51_tbhvQ@mail.gmail.com>
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


--===============7960476595572401136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/phDVh97NXcsfHGu"
Content-Disposition: inline


--/phDVh97NXcsfHGu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 07:27:11PM -0700, Trent Piepho wrote:

> I've found that the SPI layer adds rather a lot of overhead to SPI
> transactions.  It appears to come mostly from using another thread to
> run the queue.  A fast SPI message of a few dozen bytes ends up having
> more overhead from the SPI layer than the time it takes the driver to
> do the actual transfer.

Yeah, though of course at the minute the implementation of that thread
is pretty much up to the individual drivers which isn't triumph - and
the quality of implementation does vary rather a lot.  I'm currently
working on trying to factor more of this out, hopefully then it'll be
easier to push out improvements.  It may be nice to be able to kick off
the first DMA transfer from within the caller for example.

> So memory mapped mode via some kind of SPI hack seems like a bad
> design.  All the SPI layer overhead and you don't get DMA.  Memory
> mapped SPI could be a win, but I think you'd need to do it at the MTD
> layer with a mapping driver that could read the mmapped SPI flash
> directly.

Yes, exactly and even then I'm not convinced that it's going to be much
advantage for anything except small transfers without DMA.

--/phDVh97NXcsfHGu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVn0pAAoJELSic+t+oim9G9sP/1dOieJkYzytp5QnWcvnKhA9
+g+TzToOqsxlnlSmawVdplOQt2vkwJ6zYmoLoNqLVBONPS5+vfDldxjkaE5ceOcE
24ht62ukSngEkiKPK4aRzph84xxJF4ovR9AjhmSr/Ivk7//Cinsukb61kOfkQ4mg
KK1Ug9PNGbvtrSY4++uU0UhvFJRL4m87YDW1RvzMcEifwyRAwsb1fUFygxtl7UCI
OlO7Ph02a/T82eRvCeEwxYxwhNtHTS/7zXZRr4lxh6/f2Hve2uRm6mQ+J1RD9VC3
V48H3VxFbk01M4cl7sUVwvqd+NSytiBYMAvCfAarTlpp+ilgEiyyZfNlohJK3kw4
36qwR/Xr94U9Obh4jtkj/Py16yWzyQjtUOgeSyO3rKAPemRwr1zSVnyBbVDgzNYW
DSEAMbjip+ra9Coq3Dc0gipO2VycM2sl00WEZLo/VwrfS6+slWJ/88HnSUPPW0ns
DjHFppvcBrd9w97Jm1u0IdcVomYtD4S2l34s8d+tvvhh255hpXLo224WdogRG82r
uVzeWhFOwnEY+zao95tliPgzFrXxjnu6tlaf5XgheJu8GNFErQovjZO/OqNB/UNL
5PgmAxwm46g3jxjVsrUI423rFvAgpD92GfJq79NSFbqBwVY0SNMYF/9Q3v7sXy0E
+b9s+9m+++zM4PtbJMUa
=4G1t
-----END PGP SIGNATURE-----

--/phDVh97NXcsfHGu--


--===============7960476595572401136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7960476595572401136==--
