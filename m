From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] dt-bindings: powerpc: adapt mpc5121-psc document to reality
Date: Thu, 16 Jul 2015 21:35:28 +0200
Message-ID: <1437075328-2574-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20150716133259.GI4039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>,
	linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150716133259.GI4039-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The drivers support MPC5125 additionally to MPC5121, and there is an sp=
i
mode that is also supported. Additionally some minor corrections are
done.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Hello,

I sent a patch adding mpc5125 support to the mpc512x driver and Mark
requested the new compatible to be documented. While at it I updated th=
e
document a bit more, and obviously the spi support for mpc5125 depends
on my patch that isn't mainline yet.

Best regards
Uwe

 .../bindings/powerpc/fsl/mpc5121-psc.txt           | 24 ++++++++++++++=
++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.=
txt b/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt
index 8832e8798912..647817527c88 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5121-psc.txt
@@ -6,14 +6,14 @@ PSC in UART mode
 For PSC in UART mode the needed PSC serial devices
 are specified by fsl,mpc5121-psc-uart nodes in the
 fsl,mpc5121-immr SoC node. Additionally the PSC FIFO
-Controller node fsl,mpc5121-psc-fifo is requered there:
+Controller node fsl,mpc5121-psc-fifo is required there:
=20
-fsl,mpc5121-psc-uart nodes
+fsl,mpc512x-psc-uart nodes
 --------------------------
=20
 Required properties :
- - compatible : Should contain "fsl,mpc5121-psc-uart" and "fsl,mpc5121=
-psc"
- - cell-index : Index of the PSC in hardware
+ - compatible : Should contain "fsl,<soc>-psc-uart" and "fsl,<soc>-psc=
"
+   Supported <soc>s: mpc5121, mpc5125
  - reg : Offset and length of the register set for the PSC device
  - interrupts : <a b> where a is the interrupt number of the
    PSC FIFO Controller and b is a field that represents an
@@ -25,12 +25,21 @@ Recommended properties :
  - fsl,rx-fifo-size : the size of the RX fifo slice (a multiple of 4)
  - fsl,tx-fifo-size : the size of the TX fifo slice (a multiple of 4)
=20
+PSC in SPI mode
+---------------
=20
-fsl,mpc5121-psc-fifo node
+Similar to the UART mode a PSC can be operated in SPI mode. The compat=
ible used
+for that is fsl,mpc5121-psc-spi. It requires a fsl,mpc5121-psc-fifo as=
 well.
+The required and recommended properties are identical to the
+fsl,mpc5121-psc-uart nodes, just use spi instead of uart in the compat=
ible
+string.
+
+fsl,mpc512x-psc-fifo node
 -------------------------
=20
 Required properties :
- - compatible : Should be "fsl,mpc5121-psc-fifo"
+ - compatible : Should be "fsl,<soc>-psc-fifo"
+   Supported <soc>s: mpc5121, mpc5125
  - reg : Offset and length of the register set for the PSC
          FIFO Controller
  - interrupts : <a b> where a is the interrupt number of the
@@ -39,6 +48,9 @@ Required properties :
  - interrupt-parent : the phandle for the interrupt controller that
    services interrupts for this device.
=20
+Recommended properties :
+ - clocks : specifies the clock needed to operate the fifo controller
+ - clock-names : name(s) for the clock(s) listed in clocks
=20
 Example for a board using PSC0 and PSC1 devices in serial mode:
=20
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
