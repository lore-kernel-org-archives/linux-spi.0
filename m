From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 00/18] spi: rspi: Add DMA support for QSPI on R-Car Gen2
Date: Thu, 5 Jun 2014 14:58:29 +0900
Message-ID: <53900705.4030906@renesas.com>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Magnus Damm <magnus.damm@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert-san,

Thank you for the patches!

(2014/06/02 22:38), Geert Uytterhoeven wrote:
> This patch series refactors the Renesas SPI driver and adds DMA support
> using the SPI DMA framework for QSPI on R-Car Gen2, for Single, Dual, and
> Quad SPI Transfers.
> It also adds DMA support for RZ/A1H, but this was untested.
> 
> Apart from refactorings that don't change behavior:
>   - [02/18] reverts a (harmless?) behavioral change for RSPI on SH,
>   - [03/18] removes 16-bit DMA support, which has no in-tree users.
> 	    16-bit DMA support requires using a double-sized buffer to
> 	    accomodate the interleaved data format.
> 	    If there's a strong requirement to keep this, I think it's best
> 	    to re-add support after this series.

I agree with you.
(I wrote this 16-bit DMA function. But, as you know, nobody uses this function.)

< snip >
>  Documentation/devicetree/bindings/spi/spi-rspi.txt |   6 +
>  drivers/spi/spi-rspi.c                             | 604 ++++++++-------------
>  include/linux/spi/rspi.h                           |   2 -
>  3 files changed, 228 insertions(+), 384 deletions(-)

All of the patch series:
Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
