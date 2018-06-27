From: Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: [RFC PATCH v2 6/6] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
Date: Wed, 27 Jun 2018 15:16:09 +0200
Message-ID: <20180627131609.13681-7-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Piotr Bugalski <pbu@cryptera.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180627131609.13681-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
this change is just moving DT-binding documentation.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>
---
 Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
rename to Documentation/devicetree/bindings/spi/atmel-quadspi.txt
-- 
2.11.0
