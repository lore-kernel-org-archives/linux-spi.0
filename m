From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 09/11] spi-dw: Fix condition in spi_dw_{writer/reader}
Date: Thu, 23 Jun 2011 10:45:06 +0800
Message-ID: <20110623104506.3cfd55ce@feng-i7>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com>
	<1308794413-11069-10-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
To: "dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308794413-11069-10-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 23 Jun 2011 10:00:11 +0800
"dirk.brandewie@gmail.com" <dirk.brandewie@gmail.com> wrote:

> From: Dirk Brandewie <dirk.brandewie@gmail.com>
> 
> Fix the condition based on whether the current transfer has a tx/rx
> buffer.
> 
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
>  drivers/spi/spi-dw.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index cc38aa0..35b952b 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -193,8 +193,8 @@ static void spi_dw_writer(struct spi_dw *dws)
>  	u16 txw = 0;
>  
>  	while (max--) {
> -		/* Set the tx word if the transfer's original "tx"
> is not null */
> -		if (dws->tx_end - dws->len) {
> +		/* Set the tx word if the transfer's "tx" is not
> null */
> +		if (dws->tx) {

No, in current mainstream code, the dws->tx is changing, see code:
	dws->tx += dws->n_bytes;
so we have to use if (dws->tx_end - dws->len) for now, maybe
we can use some bit to indicate whether the original tx is null

>  			if (dws->n_bytes == 1)
>  				txw = *(u8 *)(dws->tx);
>  			else
> @@ -213,7 +213,7 @@ static void spi_dw_reader(struct spi_dw *dws)
>  	while (max--) {
>  		rxw = dw_readw(dws, dr);
>  		/* Care rx only if the transfer's original "rx" is
> not null */
> -		if (dws->rx_end - dws->len) {
> +		if (dws->rx) {
>  			if (dws->n_bytes == 1)
>  				*(u8 *)(dws->rx) = rxw;
>  			else
