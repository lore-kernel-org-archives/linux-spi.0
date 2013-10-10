From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Thu, 10 Oct 2013 11:14:10 +0100
Message-ID: <20131010101410.GG21581@sirena.org.uk>
References: <52566ACC.1080100@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1444841976072649603=="
Cc: Peter Korsgaard <peter@korsgaard.com>, Trent Piepho <tpiepho@gmail.com>,
 balbi@ti.com, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <52566ACC.1080100@ti.com>
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


--===============1444841976072649603==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1/Dn3Y6YyfrTkYGL"
Content-Disposition: inline


--1/Dn3Y6YyfrTkYGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2013 at 02:22:28PM +0530, Sourav Poddar wrote:

> [Trent]: With mapping driver, I believe you are hinting at
> drivers/mtd/maps? I had
> a look at it and what I got is that it is used/suitable for parallel
> flashes and not the
> serial flashes.

Essentially what it looks like this hardware is trying to do is adapt a
serial flash so it looks more like a parallel flash.  It's not clear
that this is a good idea if we are already able to understand serial
flash though.

--1/Dn3Y6YyfrTkYGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVn3uAAoJELSic+t+oim9CCMQAJDvhzGwOH6RVk/ERlFG1K9o
AnFN++E8s1pOMZ/C82ukgoL8hFpi0T8pi2VllTg3rFdQdGk/5+buo9n+MM+Y/gvP
IR7OMTzBFQJl6QByzTbIGKR8YP6gT19oTIO/PsMB5rb3rqK9Ewq4bJqGgPtIhefz
JN0m47RqwhZR0CBkp82fdVOl1rFbnYMTHSkzEAH7H1DEtEvV536L8AvLLOA0L3TD
AK4/meXQGPp59asHYtp3a2eWG6Hno61PqSDjcXkPU2c8Mq7ePlRbJfyuTIsXkocF
v0sZA1onTBPPUmgz0KKl5JRuUhSIJJJAsA0ODNvNUGFoz1kzdCNqhodgMohPq9ri
MVWZCI6JUI7PRXwjBiR/BZSr2dmBFSHz7ABqRl1+S2V7F9Cjt2DuH/a/ESyenOJx
Ibe6HczVShEcxfo5Ic04ddXYB6HMDTWKnMF2PqGMKalZ8gAQ77G3BRbfbV+S0nK5
Vs48ScuEB1eG3ChyLzH8Ruw5I8K3Q0zleATk1ROYiWihnqa2h8Q1Q2/WjiKvTkda
S8p91RP2rvnlUXwUGRq4h6j+y4FG3pl5Cp8c0uVlHtEPoVEzXYwFCUL9QKV6uZ0D
FA9Et719JulEEMUrqDknNNryQ3oS4uGtkKScQEz1O65X6cMFT8Ue7yLgIMMbdj0I
NBWS4K49GQU5uq6bfptn
=f0nu
-----END PGP SIGNATURE-----

--1/Dn3Y6YyfrTkYGL--


--===============1444841976072649603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1444841976072649603==--
