From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] FSL QSPI device tree cleanup for 4.21
Date: Thu, 20 Dec 2018 23:41:37 +0100
Message-ID: <CAK8P3a0QxoNyq=5LzQObFnq2i7mVRJDj73j7ur+cQ9rmoKZpMQ@mail.gmail.com>
References: <20181216084854.GJ13243@dragon>
 <CAK8P3a34R+Gv+H8_jjGP452i2kSqq+u0PsE-4pDnRRtY14SG0w@mail.gmail.com>
 <a73f86ff-15ce-9512-bbf0-be852cf39a35@kontron.de>
 <CAK8P3a1PMoR-WWcb_G8sTVW9HKUKvKfUZmcinkOEy9mJ5c=Lxw@mail.gmail.com>
 <6dde2248-da0d-7bd3-801b-b42b2974c038@kontron.de>
 <CAK8P3a0WCOcVjSegBKRPw3kkokE8S4JEXManqBkq4CjfcBRSMg@mail.gmail.com>
 <CAMuHMdW1NsqEHWBBn77wTAYnXi068iT2Lo8rxUUSvbo5UHDTkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: frieder.schrempf@kontron.de, linux-spi <linux-spi@vger.kernel.org>,
 arm-soc <arm@kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>,
 linux-imx@nxp.com, Sascha Hauer <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAMuHMdW1NsqEHWBBn77wTAYnXi068iT2Lo8rxUUSvbo5UHDTkA@mail.gmail.com>
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

On Thu, Dec 20, 2018 at 7:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Dec 20, 2018 at 5:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Dec 20, 2018 at 5:23 PM Schrempf Frieder
> > > As the new driver is a SPI driver, the common rules in
> > > Documentation/devicetree/bindings/spi/spi-bus.txt apply and
> > > spi-[tx/rx]-bus-width are defined to default to 1 if not specified.
> > > So we can't set those properties in the driver if they are missing in
> > > the dtb as we would deviate from the standard, although it would make
> > > more sense for a *Quad*-SPI driver to default to 4.
> >
> > Right, I guess that makes sense.
> >
> > Now, you could change the binding for the fsl-quadspi driver to
> > require the bus-width properties, which would then just make
> > the old dtb files invalid, and you give us an excuse to override
> > the properties by adding the =4 ones, once that is documented
> > in the driver specific binding.
> >
> > Since it's only a performance difference, I suppose we can live
> > with the limitation and stay a little closer to the normal binding.
>
> Please note that a quad-capable SPI FLASH may be physically wired
> to a quad-capable SPI controller using only 2 wires, so defaulting to
> 4 may cause issues.  Defaulting to 2 may work, if the device is
> dual-capable.

Right, this would only work because the old driver used 4 wires
in the absence of the DT property, and the driver would warn
when it's not there for new dtb files.

      Arnd

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
