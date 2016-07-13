From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] spi: add DT binding for clps711x SPI
Date: Wed, 13 Jul 2016 10:13:58 +0200
Message-ID: <9132787.CoNHcRuYpT@wuerfel>
References: <20160707094952.4111577-1-arnd@arndb.de>
 <20160707094952.4111577-2-arnd@arndb.de>
 <20160712204947.GA6182@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Alexander Shiyan <shc_work@mail.ru>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160712204947.GA6182@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Tuesday, July 12, 2016 3:49:47 PM CEST Rob Herring wrote:
> On Thu, Jul 07, 2016 at 11:49:46AM +0200, Arnd Bergmann wrote:
> > +
> > +An additional register is present in the system controller,
> > +which is assumed to be in the same device tree, with and marked
> > +as compatible with "cirrus,ep7209-syscon3".
> > +
> > +Example:
> > +
> > +spi@80000500 {
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +     compatible = "cirrus,ep7209-spi";
> > +     reg = <0x80000500 0x4>;
> > +     interrupts = <15>;
> > +     clocks = <&clks CLPS711X_CLK_SPI>;
> > +     status = "disabled";
> > +};
> > +
> > +syscon3: syscon@80002200 {
> 
> This looks like it shouldn't be here.

The label, or the entire node?

	Arnd
