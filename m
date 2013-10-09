From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Wed, 9 Oct 2013 19:41:39 +0100
Message-ID: <20131009184139.GZ21581@sirena.org.uk>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
 <1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
 <20131009160759.GQ21581@sirena.org.uk> <52558A49.5090904@ti.com>
 <20131009174027.GS21581@sirena.org.uk> <52559D52.4010400@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1159928803749060466=="
Cc: spi-devel-general@lists.sourceforge.net, computersforpeace@gmail.com,
 dwmw2@infradead.org, balbi@ti.com, linux-mtd@lists.infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <52559D52.4010400@ti.com>
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


--===============1159928803749060466==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iAb4HJL2YUi6ElHq"
Content-Disposition: inline


--iAb4HJL2YUi6ElHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 09, 2013 at 11:45:46PM +0530, Sourav Poddar wrote:
> On Wednesday 09 October 2013 11:10 PM, Mark Brown wrote:

> >I'm not convinced that this is the most useful API, it sounds like the
> >hardware can "memory map" the entire flash chip so the whole SPI
> >framework seems like overhead.

> But this memory map read will work only with read opcodes.(mtd_read
> path). For all other operations, normal SPI operations will be used.

> As for this, I also though of bypassing the SPI frameowrk, and doing
> a memcopy
> at the beginning of the mtd_read api. But, then before doing a memory mapped
> read -
> 1. Controller need to be switched to memory mapped port using control module
>      register and ti qspi switch register.
> 2. There is SOC specific memory mapped address space from where read
> should happen,
>     this is SOC specific and should be known to mtd layer the
> adreess to read for.
> So, I thought of going this way using t.memory map flag.

Sure, but these things sound like we should be able to support them
without having to bounce over to the SPI thread all the time and...

> >It also seems seems like it's going to involve the CPU being stalled
> >waiting for reads to complete instead of asking the SPI controller to
> >DMA the data to RAM and allowing the CPU to get on with other things -
> >replacing the explicit transmission of commands with memory to memory
> >DMAs might be advantageous but replacing DMA with memcpy() would need
> >numbers to show that it was a win.

...like I say it's not clear to me that this is actually a change that's
going to be beneficial.  I'd really like to see some analysis of the
performance showing that this helps and why it helps.

--iAb4HJL2YUi6ElHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSVaNgAAoJELSic+t+oim9TUIP/2pqeA/nUCU+KL3qQGwmxHot
Gezf1eDoQJJkyuHtEAgDa/SqhVhfBoXI6D5yTlgp5GnqFYDmet63RuAzjaU+ck0R
EpN/ptHNejSD2/92K305xArA5/I73di3rGHybxBT2w7D57kZK5N/X8cFsSJ7v9ZJ
a69me89rK2n/Vg4jQUOTnc1Wr+eo3KIorcOckkIx5RYVZ3AUtjxLzAIrT/gxkI4N
glUc+Ye1CNFLTbRFJnXqhXn2pyaDDbqbde5oCR2LFL0IJYaZ/9yma2WI+Ket0uS7
M15vcbU61DPN07fh4wVqxuZOyvbTSukg69EVmrmurkRT4gwKY+IKh8Wo7FgJ8z32
w6kzYqi40VB+ccZj5og7NOCyW8xUR5DYSyg2mMUZ77heyqJ3ywouzGFwpywZurRX
QMxVmhZa6ABJkrW+yDbz6wQaDjnVXXauyy66UiKSATmRDSW7gW6EX3RAmVst502N
a5kqmBx+IWcXvhXlpqWbxWirr0ilQ9Fx2xZyIlpX6i0dY8Tjurah/WhCemkQyXbW
uagaBUk2N/wPMdELcIOY4poZ+AVdaBXvkIj9DuAk0CGcv/fRnvWm2oeA9f2s7TPX
Y+BM4S5dmCDzsADa9JXnaRsy7zFZo2DRGlpdCA/NkxRJoq+Io9LhS9cuEtO8WP/t
sgtYEABPj3fk3FrBughj
=/N7d
-----END PGP SIGNATURE-----

--iAb4HJL2YUi6ElHq--


--===============1159928803749060466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1159928803749060466==--
