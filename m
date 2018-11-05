From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 6/6] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
Date: Mon, 5 Nov 2018 15:21:48 -0600
Message-ID: <20181105212148.GA13045@bogus>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
 <20181105103625.9644-7-bugalski.piotr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>
To: Piotr Bugalski <bugalski.piotr@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181105103625.9644-7-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon,  5 Nov 2018 11:36:25 +0100, Piotr Bugalski wrote:
> Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
> this change is just moving DT-binding documentation.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
> ---
>  Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
