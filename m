From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: rspi: Add r8a77470 to the compatible list" to the spi
 tree
Date: Wed,  7 Nov 2018 15:41:03 +0000 (GMT)
Message-ID: <20181107154103.C8F421124E14@debutante.sirena.org.uk>
References: <1541075705-1333-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Magnus Damm <magnus.damm@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
 devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-mtd@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Biju Das <biju.das@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
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

The patch

   spi: rspi: Add r8a77470 to the compatible list

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From df80e0478972260bf285c5ed33f99b2424fba2af Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Date: Thu, 1 Nov 2018 12:35:02 +0000
Subject: [PATCH] spi: rspi: Add r8a77470 to the compatible list

Add r8a77470 to the list of examples with soctypes.
No driver change is needed as "renesas,qspi" will activate
the right code within the corresponding driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
index fc97ad64fbf2..421722b93992 100644
--- a/Documentation/devicetree/bindings/spi/spi-rspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -15,6 +15,7 @@ Required properties:
 			- "renesas,qspi-r8a7743" (RZ/G1M)
 			- "renesas,qspi-r8a7744" (RZ/G1N)
 			- "renesas,qspi-r8a7745" (RZ/G1E)
+			- "renesas,qspi-r8a77470" (RZ/G1C)
 			- "renesas,qspi-r8a7790" (R-Car H2)
 			- "renesas,qspi-r8a7791" (R-Car M2-W)
 			- "renesas,qspi-r8a7792" (R-Car V2H)
-- 
2.19.0.rc2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
