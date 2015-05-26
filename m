From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
Date: Tue, 26 May 2015 14:08:53 +0200
Message-ID: <20150526120853.GB28523@lunn.ch>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Boris BREZILLON <boris.brezillon@free-electrons.com>,
 Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>,
 Lior Amsalem <alior@marvell.com>, Mark Brown <broonie@kernel.org>,
 Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

> --- a/Documentation/devicetree/bindings/spi/spi-orion.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
> @@ -1,7 +1,13 @@
>  Marvell Orion SPI device
>  
>  Required properties:
> -- compatible : should be "marvell,orion-spi" or "marvell,armada-370-spi".
> +- compatible : should be on of the following:
> +    - "marvell,orion-spi" for the Orion, mv78x00, Kirkwood and Dove SoCs
> +    - "marvell,armada-370-spi", for the Armada 370 SoCs
> +    - "marvell,armada-375-spi", for the Armada 375 SoCs
> +    - "marvell,armada-380-spi", for the Armada 38x SoCs
> +    - "marvell,armada-390-spi", for the Armada 38x SoCs

Hi Gregory

Is that a typ0?

   Andrew
