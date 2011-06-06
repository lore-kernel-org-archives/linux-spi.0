From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 16:15:04 +0100
Message-ID: <20110606151504.GA7448@n2100.arm.linux.org.uk>
References: <20110605071725.26517.11573.stgit@ponder>
	<201106061100.38249.arnd@arndb.de>
	<BANLkTi=XoD8RiiEihB5bC1Zogxo+J7o3Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Michael Buesch <mb@bu3sch.de>, Arnd Bergmann <arnd@arndb.de>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Matt Porter <mporter@kernel.crashing.org>,
	"David S. Miller" <davem@davemloft.net>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <BANLkTi=XoD8RiiEihB5bC1Zogxo+J7o3Qg@mail.gmail.com>
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

On Mon, Jun 06, 2011 at 08:39:04AM -0600, Grant Likely wrote:
> However, there are a number of bus types that have infrastructure, but
> no actual drivers associated with them, like mca, amba and clk.  It
> might make sense to move those bus types into drivers/base alongside
> the platform_bus_type implementation.

More or less agreed - I'm not sure we should think about clk just yet
because we don't know what that'll end up looking like yet...
