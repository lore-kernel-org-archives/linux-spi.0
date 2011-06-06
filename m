From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 08:39:04 -0600
Message-ID: <BANLkTi=XoD8RiiEihB5bC1Zogxo+J7o3Qg@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder>
	<201106061100.38249.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Russell King <linux@arm.linux.org.uk>,
	Michael Buesch <mb@bu3sch.de>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Matt Porter <mporter@kernel.crashing.org>,
	"David S. Miller" <davem@davemloft.net>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <201106061100.38249.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 6, 2011 at 3:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sunday 05 June 2011, Grant Likely wrote:
>> =A0rename drivers/spi/{omap2_mcspi.c =3D> spi_omap2_mcspi.c} (100%)
>> =A0rename drivers/spi/{omap_spi_100k.c =3D> spi_omap_100k.c} (100%)
>> =A0rename drivers/spi/{omap_uwire.c =3D> spi_omap_uwire.c} (100%)
>> =A0rename drivers/spi/{orion_spi.c =3D> spi_orion.c} (100%)
>> =A0rename drivers/spi/{amba-pl022.c =3D> spi_pl022.c} (100%)
>> =A0rename drivers/spi/{pxa2xx_spi.c =3D> spi_pxa2xx.c} (100%)
>> =A0rename drivers/spi/{pxa2xx_spi_pci.c =3D> spi_pxa2xx_pci.c} (100%)
>> =A0rename drivers/spi/{ti-ssp-spi.c =3D> spi_ti_ssp.c} (100%)
>> =A0rename drivers/spi/{tle62x0.c =3D> spi_tle62x0.c} (100%)
>> =A0rename drivers/spi/{xilinx_spi.c =3D> spi_xilinx.c} (100%)
>
> I recently looked at the directory structure in drivers/ and found a lot
> of bus drivers with very few files, plus a few bus drivers with a lot
> of files in them besides directories for non-bus specific subsystems.
>
> I think it would be good to move them into a deeper directory drivers/bus/
> if we have support from the maintainers, and it's probably better if we
> only have to move the files once to reduce the amount of churn on the
> MAINTAINERS file and any out of tree patches.

I had this thought too when I was looking at reorganizing the gpio and
spi directories, but ultimately I came to the conclusion that it
didn't really make much sense to move them.  Bus drivers are just
another kind of device driver.  In general, the organization of having
a directory (like spi or i2c) containing both the common bus
infrastructure and a set of drivers using it, and this isn't even
unlike what we do for non-bus drivers.  I don't see much need to move
these.

However, there are a number of bus types that have infrastructure, but
no actual drivers associated with them, like mca, amba and clk.  It
might make sense to move those bus types into drivers/base alongside
the platform_bus_type implementation.

g.
