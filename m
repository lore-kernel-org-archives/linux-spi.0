From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 06/11] dt-bindings: spi/spi-pxa2xx: Add spi-slave property
Date: Wed, 17 Oct 2018 14:33:46 -0500
Message-ID: <20181017193346.GB8853@bogus>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-7-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010170936.316862-7-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 10, 2018 at 07:09:31PM +0200, Lubomir Rintel wrote:
> This is used to indicate that the chip attached to this controller is a SPI
> master.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  Documentation/devicetree/bindings/spi/spi-pxa2xx.txt | 1 +
>  1 file changed, 1 insertion(+)

This could be rolled into patch 1. Either way,

Reviewed-by: Rob Herring <robh@kernel.org>
