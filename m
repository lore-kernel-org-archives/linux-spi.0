From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] spi: rspi: Add r8a77470 to the compatible list
Date: Tue, 6 Nov 2018 15:09:05 +0100
Message-ID: <20181106140905.yfhr7fayi6decjzz@verge.net.au>
References: <1541075705-1333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1541075705-1333-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Magnus Damm <magnus.damm@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Biju Das <biju.das@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1541075705-1333-2-git-send-email-fabrizio.castro@bp.renesas.com>
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

On Thu, Nov 01, 2018 at 12:35:02PM +0000, Fabrizio Castro wrote:
> Add r8a77470 to the list of examples with soctypes.
> No driver change is needed as "renesas,qspi" will activate
> the right code within the corresponding driver.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> ---
> 
> As per Mark Brown's comment on patch "dt-bindings: spi: rspi: Add
> r8a7744 to the compatible list", this patch doesn't come with the
> "dt-bindings" prefix in the title.
> 
>  Documentation/devicetree/bindings/spi/spi-rspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
> index fc97ad6..421722b 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
> @@ -15,6 +15,7 @@ Required properties:
>  			- "renesas,qspi-r8a7743" (RZ/G1M)
>  			- "renesas,qspi-r8a7744" (RZ/G1N)
>  			- "renesas,qspi-r8a7745" (RZ/G1E)
> +			- "renesas,qspi-r8a77470" (RZ/G1C)
>  			- "renesas,qspi-r8a7790" (R-Car H2)
>  			- "renesas,qspi-r8a7791" (R-Car M2-W)
>  			- "renesas,qspi-r8a7792" (R-Car V2H)
> -- 
> 2.7.4
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
