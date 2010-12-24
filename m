From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] eSPI: fix wrong setting of the address in the
	command buffer
Date: Fri, 24 Dec 2010 01:55:18 -0700
Message-ID: <20101224085518.GG5544@angua.secretlab.ca>
References: <1292894822-7983-1-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
To: Mingkai Hu <Mingkai.hu@freescale.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <1292894822-7983-1-git-send-email-Mingkai.hu@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 21, 2010 at 09:27:02AM +0800, Mingkai Hu wrote:
> Or else we cann't operate on the right address when the trans length
> is greater than 65535.
> 
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>

Applied to merge branch for 2.6.27, thanks.

g.

> ---
>  drivers/spi/spi_fsl_espi.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi_fsl_espi.c b/drivers/spi/spi_fsl_espi.c
> index ae78926..a99e233 100644
> --- a/drivers/spi/spi_fsl_espi.c
> +++ b/drivers/spi/spi_fsl_espi.c
> @@ -258,18 +258,18 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
>  	return mpc8xxx_spi->count;
>  }
>  
> -static void fsl_espi_addr2cmd(unsigned int addr, u8 *cmd)
> +static inline void fsl_espi_addr2cmd(unsigned int addr, u8 *cmd)
>  {
> -	if (cmd[1] && cmd[2] && cmd[3]) {
> +	if (cmd) {
>  		cmd[1] = (u8)(addr >> 16);
>  		cmd[2] = (u8)(addr >> 8);
>  		cmd[3] = (u8)(addr >> 0);
>  	}
>  }
>  
> -static unsigned int fsl_espi_cmd2addr(u8 *cmd)
> +static inline unsigned int fsl_espi_cmd2addr(u8 *cmd)
>  {
> -	if (cmd[1] && cmd[2] && cmd[3])
> +	if (cmd)
>  		return cmd[1] << 16 | cmd[2] << 8 | cmd[3] << 0;
>  
>  	return 0;
> @@ -395,9 +395,11 @@ static void fsl_espi_rw_trans(struct spi_message *m,
>  			}
>  		}
>  
> -		addr = fsl_espi_cmd2addr(local_buf);
> -		addr += pos;
> -		fsl_espi_addr2cmd(addr, local_buf);
> +		if (pos > 0) {
> +			addr = fsl_espi_cmd2addr(local_buf);
> +			addr += pos;
> +			fsl_espi_addr2cmd(addr, local_buf);
> +		}
>  
>  		espi_trans->n_tx = n_tx;
>  		espi_trans->n_rx = trans_len;
> -- 
> 1.6.4
> 
> 
