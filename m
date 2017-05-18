From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/1] spi: imx: fix issue when tx_buf or rx_buf is NULL
Date: Thu, 18 May 2017 13:08:34 +0300
Message-ID: <1495102114.26925.20.camel@nxp.com>
References: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: <jiada_wang@mentor.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2017-05-18 at 03:01 -0700, jiada_wang@mentor.com wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
> 
> In case either transfer->tx_buf or transfer->rx_buf is NULL,
> manipulation of buffer in spi_imx_u32_swap_u[8|16]() will cause
> NULL pointer dereference crash.
> 
> Add buffer check at very beginning of spi_imx_u32_swap_u[8|16](),
> to avoid such crash.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Reported-by: Leonard Crestez <leonard.crestez@nxp.com>

Tested-by: Leonard Crestez <leonard.crestez@nxp.com>
