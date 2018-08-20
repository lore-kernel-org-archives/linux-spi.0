From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mtd: m25p80: consider max message size when use the
 spi_mem_xx() API
Date: Mon, 20 Aug 2018 19:13:14 +0200
Message-ID: <20180820171314.GB18339@kroah.com>
References: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jiafei.pan@nxp.com, zhiqiang.hou@nxp.com
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 20, 2018 at 05:43:26PM +0800, Chuanhua Han wrote:
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
> 	- Place the adjusted transfer bytes code in spi_mem_adjust_op_size()
> 	and  check spi_max_message_size(mem->spi) value before subtracting 
> 	opcode, addr and dummy bytes.
> *fixes:
> 	spi: Extend the core to ease integration of SPI memory controllers
> ---
>  drivers/spi/spi-mem.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
