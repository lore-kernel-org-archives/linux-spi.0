From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] trivial: fix double "of of" in comment in spidev
 code
Date: Fri, 23 Oct 2009 03:48:31 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0910230348210.8582@wotan.suse.de>
References: <1256240069-25223-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751334AbZJWBs2@vger.kernel.org>
In-Reply-To: <1256240069-25223-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 22 Oct 2009, Thadeu Lima de Souza Cascardo wrote:

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> ---
>  drivers/spi/spidev.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 5d23983..d9b4100 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -42,7 +42,7 @@
>   * This supports acccess to SPI devices using normal userspace I/O calls.
>   * Note that while traditional UNIX/POSIX I/O semantics are half duplex,
>   * and often mask message boundaries, full SPI support requires full duplex
> - * transfers.  There are several kinds of of internal message boundaries to
> + * transfers.  There are several kinds of internal message boundaries to
>   * handle chipselect management and other protocol options.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
