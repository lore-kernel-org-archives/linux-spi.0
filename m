From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] tools: spi: enable CROSS_COMPILE in Makefile
Date: Wed, 7 Sep 2016 16:06:39 +0100
Message-ID: <ab8b24cf-0d9a-60e5-9291-d5e6e44756be@linaro.org>
References: <1473258496-14565-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473258496-14565-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 07/09/16 15:28, Jorge Ramirez-Ortiz wrote:
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  tools/spi/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/spi/Makefile b/tools/spi/Makefile
> index cd0db62..d1845b0 100644
> --- a/tools/spi/Makefile
> +++ b/tools/spi/Makefile
> @@ -1,4 +1,8 @@
> +CC = $(CROSS_COMPILE)gcc
> +
>  all: spidev_test spidev_fdx
>
> +%: %.c
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<

What is this extra rule for?

The built in rules should already honour both these variables (and more 
besides).


Daniel.
