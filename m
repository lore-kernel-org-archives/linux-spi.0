From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/7] Add RZ/G2N MSIOF/RWDT/PCIEC support
Date: Fri,  4 Oct 2019 09:35:26 +0100
Message-ID: <1570178133-21532-1-git-send-email-fabrizio.castro@bp.renesas.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>, xu_shunji@hoperun.com
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Dear All,

this series adds MSDIF/RWDT/PCIEC support to the HiHope RZ/G2N.

This series depends on the following series and patches:
* https://patchwork.kernel.org/cover/11166155/
* https://patchwork.kernel.org/cover/11157129/
* https://patchwork.kernel.org/cover/11158259/
* https://patchwork.kernel.org/patch/11166327/
* https://patchwork.kernel.org/cover/11171325/
* https://patchwork.kernel.org/patch/11162283/

Thanks,
Fab

Fabrizio Castro (7):
  dt-bindings: watchdog: renesas-wdt: Document r8a774b1 support
  dt-bindings: spi: sh-msiof: Add r8a774b1 support
  dt-bindings: PCI: rcar: Add device tree support for r8a774b1
  arm64: dts: renesas: r8a774b1: Add RWDT node
  arm64: dts: renesas: r8a774b1: Add all MSIOF nodes
  arm64: dts: renesas: r8a774b1: Add PCIe device nodes
  arm64: dts: renesas: hihope-rzg2-ex: Let the board specific DT decide
    about pciec1

 Documentation/devicetree/bindings/pci/rcar-pci.txt |   1 +
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |   1 +
 .../devicetree/bindings/watchdog/renesas,wdt.txt   |   1 +
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi    |   4 -
 .../boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts  |   4 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          | 111 ++++++++++++++++++++-
 6 files changed, 115 insertions(+), 7 deletions(-)

-- 
2.7.4
