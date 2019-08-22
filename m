From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-qspi: Add ls2080a compatibility string to bindings" to the spi tree
Date: Thu, 22 Aug 2019 20:22:54 +0100 (BST)
Message-ID: <20190822192254.EC64ED02CB0@fitzroy.sirena.org.uk>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
Cc: Ashish Kumar <ashish.kumar@nxp.com>, broonie@kernel.org,
        devicetree@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
To: Ashish Kumar <Ashish.Kumar@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-qspi: Add ls2080a compatibility string to bindings

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

>From be28f76b7e8ffaf04690e30fd17683d8afea1fd9 Mon Sep 17 00:00:00 2001
From: Ashish Kumar <Ashish.Kumar@nxp.com>
Date: Tue, 13 Aug 2019 15:53:09 +0530
Subject: [PATCH] spi: spi-fsl-qspi: Add ls2080a compatibility string to
 bindings

There are 2 version of QSPI-IP, according to which controller registers sets
can be big endian or little endian.There are some other minor changes like
RX fifo depth etc.

The big endian version uses driver compatible "fsl,ls1021a-qspi" and
little endian version uses driver compatible "fsl,ls2080a-qspi"

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Han Xu <han.xu@nxp.com>
Link: https://lore.kernel.org/r/1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 1b23cfd7b39b..69dc5d57b1ef 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -3,9 +3,8 @@
 Required properties:
   - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
 		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
-		 "fsl,ls1021a-qspi"
+		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
 		 or
-		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
 		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
   - reg : the first contains the register location and length,
           the second contains the memory mapping address and length
-- 
2.20.1
