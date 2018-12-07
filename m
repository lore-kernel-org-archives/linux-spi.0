From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH 2/4] mtd: spi-nor: Add support for is25lp016d
Date: Fri, 7 Dec 2018 09:43:05 +0000
Message-ID: <4996db3a-26eb-2035-3d98-7aba2bc8630c@microchip.com>
References: <1541075705-1333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1541075705-1333-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Chris.Paterson2@renesas.com,
 magnus.damm@gmail.com, linux-spi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
 biju.das@bp.renesas.com
To: <fabrizio.castro@bp.renesas.com>, <broonie@kernel.org>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marek.vasut@gmail.com>,
 <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
 <boris.brezillon@bootlin.com>, <geert+renesas@glider.be>,
 <horms@verge.net.au>, <richard@nod.at>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1541075705-1333-3-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Language: en-US
Content-ID: <D3685F6842A18A45BBF47B11B6FC306D@namprd11.prod.outlook.com>
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



On 11/01/2018 02:35 PM, Fabrizio Castro wrote:
> The is25lp016d is found on the iwg23s from iWave, therefore
> add driver support for it so that we can upstream board support.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 9407ca5..85d869b 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1352,6 +1352,8 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "is25cd512",  INFO(0x7f9d20, 0, 32 * 1024,   2, SECT_4K) },
>  	{ "is25lq040b", INFO(0x9d4013, 0, 64 * 1024,   8,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "is25lp016d", INFO(0x9d6015, 0, 64 * 1024,  32,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25lp080d", INFO(0x9d6014, 0, 64 * 1024,  16,
>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "is25lp128",  INFO(0x9d6018, 0, 64 * 1024, 256,
> 
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
