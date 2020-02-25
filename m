From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
Date: Tue, 25 Feb 2020 08:56:22 +0100
Message-ID: <b705ab09-b4ce-29f2-448f-cca5556f848c@xilinx.com>
References: <20200224162643.29102-1-thommyj@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Thommy Jakobsson <thommyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        naga sureshkumar relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200224162643.29102-1-thommyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 24. 02. 20 17:26, Thommy Jakobsson wrote:
> In the public interface for chipselect, there is always an entry
> commented as "Dummy generic FIFO entry" pushed down to the fifo right
> after the activate/deactivate command. The dummy entry is 0x0,
> irregardless if the intention was to activate or deactive the cs. This
> causes the cs line to glitch rather than beeing activated in the case
> when there was an activate command.
> 
> This has been observed on oscilloscope, and have caused problems for at
> least one specific flash device type connected to the qspi port. After
> the change the glitch is gone and cs goes active when intended.
> 
> The reason why this worked before (except for the glitch) was because
> when sending the actual data, the CS bits are once again set. Since
> most flashes uses mode 0, there is always a half clk period anyway for
> cs to clk active setup time. If someone would rely on timing from a
> chip_select call to a transfer_one, it would fail though.
> 
> It is unknown why the dummy entry was there in the first place, git log
> seems to be of no help in this case. The reference manual gives no
> indication of the necessity of this. In fact the lower 8 bits are a
> setup (or hold in case of deactivate) time expressed in cycles. So this
> should not be needed to fulfill any setup/hold timings.
> 
> Signed-off-by: Thommy Jakobsson <thommyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 60c4de4e4485..7412a3042a8d 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -401,9 +401,6 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
>  
>  	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
>  
> -	/* Dummy generic FIFO entry */
> -	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
> -
>  	/* Manually start the generic FIFO command */
>  	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
>  			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> 

Naga: Can you please review this?

Thanks,
Michal
