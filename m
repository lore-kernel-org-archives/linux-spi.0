From: Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR capability
Date: Mon, 2 Mar 2020 15:23:45 +0530
Message-ID: <20200302095343.3yec6inur52vx6bg@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com>
 <20200227162842.GE4062@sirena.org.uk>
 <CAMuHMdWMCDzQm0tjpybJZyHy4imbC9NqRXP5d4C0xgxQx-Pf8g@mail.gmail.com>
 <20200227164425.GF4062@sirena.org.uk>
 <CAMuHMdV_1RfGFgDjJYzAnGd_x57zSwjZd8si=UTPp8ksgdwYGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@microchip.com>,
 Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Sekhar Nori <nsekhar@ti.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 MTD Maling List <linux-mtd@lists.infradead.org>,
 Boris Brezillon <boris.brezillon@collabora.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdV_1RfGFgDjJYzAnGd_x57zSwjZd8si=UTPp8ksgdwYGA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=m.gmane-mx.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 27/02/20 06:03PM, Geert Uytterhoeven wrote:
> Hi Mark,
> 
> On Thu, Feb 27, 2020 at 5:44 PM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Feb 27, 2020 at 05:40:31PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 27, 2020 at 5:28 PM Mark Brown <broonie@kernel.org> wrote:
> > > > It's what we do for other properties, and if this is anything like the
> > > > other things adding extra wiring you can't assume that the ability to
> > > > use the feature for TX implies RX.
> >
> > > Double Transfer Rate uses the same wire.
> >
> > But is it still on either the TX or RX signals?
> 
> E.g. good old Spansion S25FL512S supports single/dual/quad DDR, but
> apparently only for read, not write.
> Other FLASHes may support both directions. I guess.

The flash datasheet says under section 9.4 (Read Memory Array Commands):

  Some commands transfer address and data on both the rising edge and 
  falling edge of SCK. These are called Double Data Rate (DDR) commands.

Since the address is transferred in DDR mode, both Tx and Rx signals use 
DDR.

So, unless we have a flash that supports a mode like 1S-1S-8D, we don't 
really need two properties.

-- 
Regards,
Pratyush Yadav
Texas Instruments India

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
