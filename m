From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v5 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Date: Tue, 5 Feb 2019 17:26:38 +0100
Message-ID: <20190205172638.11a69968@collabora.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
        <20190205154257.29529-14-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205154257.29529-14-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 5 Feb 2019 15:44:04 +0000
<Tudor.Ambarus@microchip.com> wrote:

> @@ -450,28 +499,49 @@ static int atmel_qspi_probe(struct
> platform_device *pdev) goto exit;
>  	}
>  
> +	aq->caps = of_device_get_match_data(&pdev->dev);
> +	if (aq->caps && aq->caps->has_qspick) {

Can we add a caps instance to the sama5d2 entry instead of allowing
caps to be NULL?

The rest looks good to me, feel free to add

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

on your next version.
