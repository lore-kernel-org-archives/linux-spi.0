From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 0/2] spi: Add Macronix controller driver
Date: Tue, 25 Sep 2018 17:20:44 +0200
Message-ID: <20180925172044.6513402f@bbrezillon>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Mon, 17 Sep 2018 15:16:17 +0800
masonccyang@mxic.com.tw wrote:

> From: Mason Yang <masonccyang@mxic.com.tw>
> 
> Hi Mark and Trent,
> 
> I patched spi-mxic.c and add the run time PM function.

BTW, you forgot to add v2 in the subject prefix (can be done by passing
-vX to git format-patch, where X is the version number).

Regards,

Boris

> 
> thanks & best regards,
> Mason
> 
> Mason Yang (2):
>   spi: Add MXIC controller driver
>   dt-binding: spi: Document Macronix controller bindings
> 
>  Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
>  drivers/spi/Kconfig                                |   6 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-mxic.c                             | 674 +++++++++++++++++++++
>  4 files changed, 715 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
>  create mode 100644 drivers/spi/spi-mxic.c
> 
