From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v2 03/10] mtd: spi-nor: add DDR quad read support
Date: Mon, 28 Apr 2014 22:23:58 +0200
Message-ID: <201404282223.58671.marex@denx.de>
References: <1398657227-20721-1-git-send-email-b32955@freescale.com> <1398657227-20721-4-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
	linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1398657227-20721-4-git-send-email-b32955@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday, April 28, 2014 at 05:53:40 AM, Huang Shijie wrote:
> This patch adds the DDR quad read support by the following:
> 
>   [1] add SPI_NOR_DDR_QUAD read mode.
> 
>   [2] add DDR Quad read opcodes:
>        SPINOR_OP_READ_1_4_4_D / SPINOR_OP_READ4_1_4_4_D
> 
>   [3] add set_ddr_quad_mode() to initialize for the DDR quad read.
>       Currently it only works for Spansion NOR.
> 
>   [3] about the dummy cycles.
>       We set the dummy with 8 for DDR quad read by default.
>       The m25p80.c can not support the DDR quad read, but the SPI NOR
> controller can set the dummy value in its child DT node, and the SPI NOR
> framework can parse it out.
> 
> Test this patch for Spansion s25fl128s NOR flash.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
