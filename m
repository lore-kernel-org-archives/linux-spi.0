From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 2/6] dt-bindings: Add bindings for SPI NAND devices
Date: Mon, 25 Jun 2018 08:45:41 -0600
Message-ID: <20180625144541.GA8597@rob-hp-laptop>
References: <20180622122828.12939-1-boris.brezillon@bootlin.com>
 <20180622122828.12939-3-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Mason Yang <masonccyang@mxic.com.tw>, Julien Su <juliensu@mxic.com.tw>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Piotr Bugalski <Piotr.Bugalski@cryptera.com>,
 Richard Weinberger <richard@nod.at>, Kumar Gala <galak@codeaurora.org>,
 linux-spi@vger.kernel.org, Peter Pan <peterpansjtu@gmail.com>,
 Marek Vasut <marek.vasut@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180622122828.12939-3-boris.brezillon@bootlin.com>
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

On Fri, Jun 22, 2018 at 02:28:24PM +0200, Boris Brezillon wrote:
> Add bindings for SPI NAND chips.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v9:
> - Do not describe generic SPI device properties, and more importantly
>   do not change their meaning
> 
> Changes in v8:
> - Fixed a typo in the commit message
> ---
>  Documentation/devicetree/bindings/mtd/spi-nand.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt

Reviewed-by: Rob Herring <robh@kernel.org>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
