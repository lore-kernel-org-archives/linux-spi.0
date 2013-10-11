From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Fri, 11 Oct 2013 10:59:48 +0100
Message-ID: <20131011095948.GZ21581@sirena.org.uk>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
 <1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
 <20131009160759.GQ21581@sirena.org.uk> <52558A49.5090904@ti.com>
 <20131009174027.GS21581@sirena.org.uk>
 <87hacq1d5k.fsf@dell.be.48ers.dk>
 <CA+7tXii4J_Hie2v-DaSevFHn-YqriiVowhpXCP9H+U51_tbhvQ@mail.gmail.com>
 <20131010101052.GF21581@sirena.org.uk>
 <CA+7tXigijA6ASOiHkRDz45PTruv2vwYJu0UUWz0hvKr0=zwu5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1809433356435919944=="
Cc: Peter Korsgaard <peter@korsgaard.com>, balbi@ti.com,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 Sourav Poddar <sourav.poddar@ti.com>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Trent Piepho <tpiepho@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CA+7tXigijA6ASOiHkRDz45PTruv2vwYJu0UUWz0hvKr0=zwu5w@mail.gmail.com>
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


--===============1809433356435919944==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s7M5BJIhvg7FvZ9p"
Content-Disposition: inline


--s7M5BJIhvg7FvZ9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2013 at 04:53:46PM -0700, Trent Piepho wrote:
> On Thu, Oct 10, 2013 at 3:10 AM, Mark Brown <broonie@kernel.org> wrote:

> > Yeah, though of course at the minute the implementation of that thread
> > is pretty much up to the individual drivers which isn't triumph - and
> > the quality of implementation does vary rather a lot. I'm currently
> > working on trying to factor more of this out, hopefully then it'll be
> > easier to push out improvements. It may be nice to be able to kick off
> > the first DMA transfer from within the caller for example.

> I did testing with the mxs driver, which uses transfer_one
> _message and the spi core queue pumping code.  For small messages the
> overhead of queuing work to the pump_messages queue and waiting for
> completion is rather more than the time the actual transfer takes.  Which
> makes using a kthread rather pointless.  Part of the problem could be the
> high context switch cost for ARMv5.

Indeed - that's what I'd expect to happen.  Sufficiently small PIO
transfers and DMA initiation should both be faster if done from the
calling context.  The thread starts to get more useful once you start
building up work (at which point it should reduce context switches,
especially if multiple threads are using the bus) and if the system is
very heavily loaded when you can raise the thread priority so it can
drive data in more quickly. =20

That said it's also helpful in terms of making the code simpler to just
have the one data path.

--s7M5BJIhvg7FvZ9p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSV8wRAAoJELSic+t+oim9QWUP/jDqXgdZThj7rvqmG3lOJrRA
MZCBfEhTGB8lXJcivy/R0C0wjxFLERSMrGTQzdFbmf3Y5iTaQzmUYQvdx/yXA3B9
uoMui9Hj+vkPak19HOASksgF/deTDARQSDA0hQ55Xiu2CMQMy7ftCofUGUPFsRIC
dLmtVmyCSBVrKoaDPUR4+EvMeHnTelPosgB8783bElAyed/PrUX78gXpTUmUAvkk
rHhzl4aIzsVPBB7DfCq0ApyHwRwoqBTZd8B10XsNvRdQ3t9lJdj89zAeQUn3FB63
h7EbngNjjQWegQ7Pe6oGnAiTcOJILakeP4r4hoFAP4P90ZwIh4s1S6l077uMTJIG
aDVgBsLXM4iM5MgR+Bp7Tep1ViivhB6k9vQj1JdO6G3Ai59R+2vqkrectRXktHvU
nTeyrvRwpbUpXgweC8iYmrjAwqzONiKylb1hX2h4c5HM4YydxjGv3wWR68mr5g+P
KXM3BWjG6ZErDt4s5CqPBjAoqh88Zm5swwFOSssOOuPPBdIN7wSwiCzPfgQpP4ei
fZSbw0TbuNkPj1BIiOqwe27p8OttmgKPz9aSADDCzt1lEE5dljAtMYbvgg/vxgTA
z81b61ux9EoXFaZ10cgWzR7w1Mb07R2nF7hZhVGkv9X2zj8Fx8FKJIEre6jE6o+0
5AyF+GN9e0hnYAsiQcrH
=KX4G
-----END PGP SIGNATURE-----

--s7M5BJIhvg7FvZ9p--


--===============1809433356435919944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1809433356435919944==--
