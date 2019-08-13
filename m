From: Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add ls2080a compatibility string to bindings
Date: Tue, 13 Aug 2019 15:53:09 +0530
Message-ID: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-next@vger.kernel.org, Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
To: linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There are 2 version of QSPI-IP, according to which controller registers sets
can be big endian or little endian.There are some other minor changes like
RX fifo depth etc.

The big endian version uses driver compatible "fsl,ls1021a-qspi" and
little endian version uses driver compatible "fsl,ls2080a-qspi"

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Han Xu <han.xu@nxp.com>
---
v4:
-Rebase to spi.git,
-Add new patch to series.
-Previous versions reviewed here http://patchwork.ozlabs.org/patch/1118639/
v3:
Rebase to top
v2: 
Convert to patch series and rebasing done on top of tree

 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index e8f1d62..6d7c9ec 100644
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
2.7.4
